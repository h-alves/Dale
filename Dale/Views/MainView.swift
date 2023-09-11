//
//  MainView.swift
//  Dale
//
//  Created by Henrique Semmer on 02/09/23.
//

import SwiftUI
import MapKit

struct MainView: View {
    @StateObject var manager = LocationManager()
    @State var showingBar = false
    @State var barUp = 250
    
    @State var annotations: [Place] = []
    @State var annotationSelected: Place = .emptyPlace
    
    @State var state: Modo = .none
    
    @State var nome = ""
    @State var descricao = ""
    @State var categoria: Categoria = Categoria.vazia
    
    var body: some View{
        ZStack(alignment: .bottom){
            Map(coordinateRegion: $manager.region, interactionModes: .all, showsUserLocation: true, annotationItems: annotations){ place in
                MapAnnotation(coordinate: place.state == .creating ? manager.region.center : place.coordinate) {
                    PlaceAnnotation(place: place){
                        annotationSelected = place
                        manager.region.center = annotationSelected.coordinate
                        withAnimation{
                            showingBar = true
                        }
                        state = .clicking
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .gesture(DragGesture().onChanged { _ in
                manager.centered = false
            })
            .gesture(
                TapGesture(count: 1)
                    .onEnded { tap in
                        annotationSelected.state = .none
                        if state != .none{
                            if state != .clicking || annotationSelected.name == "" || annotationSelected.descricao == ""{
                                    annotations.removeAll { $0.id == annotationSelected.id }
                            }
                        }
                        annotationSelected = .emptyPlace
                        withAnimation {
                            showingBar = false
                        }
                        state = .none
                        
                        annotations.removeAll { $0.id == annotationSelected.id }
                    }
            )
            .gesture(LongPressGesture(
                minimumDuration: 0.25)
                .sequenced(before: DragGesture(
                    minimumDistance: 0,
                    coordinateSpace: .local).onChanged({ _ in
                        manager.centered = false
                    })
                )
                    .onEnded { value in
                        // Feedback de tremida e/ou mexidinha no ponto
                        HapticsService.shared.play(.light)
                        
                        if state == .creating{
                            annotations.removeAll { $0.id == annotationSelected.id }
                            annotationSelected = .emptyPlace
                            withAnimation {
                                showingBar = false
                            }
                            state = .none
                        }else{
                            let newAnnotation = Place(name: "", descricao: "", categoria: Categoria.geral, coordinate: manager.region.center, state: .creating)
                            annotationSelected = newAnnotation
                            annotations.append(newAnnotation)
                            withAnimation {
                                showingBar = true
                            }
                            state = .creating
                        }
                    })
            
            CenterToggleButton(centered: $manager.centered, centerSymbol: true) {
                if manager.centered{
                    manager.centered = false
                }else{
                    manager.centered = true
                }
            }
            .position(x: 350, y: 40)
            
            BottomBarView(annotation: $annotationSelected,  state: $state, nome: $nome, descricao: $descricao, categoria: $categoria, selected: $categoria){
                let index = annotations.firstIndex(where: { $0.id == annotationSelected.id})
                
                switch state{
                case .creating:
                    annotations[index!].coordinate = manager.region.center
                    annotations[index!].state = .editing
                    
                    state = .editing
                    nome = ""
                    descricao = ""
                    categoria = Categoria.geral
                case .editing:
                    annotations[index!].name = nome
                    annotations[index!].descricao = descricao
                    annotations[index!].categoria = categoria
                    
                    annotationSelected = .emptyPlace
                    
                    withAnimation {
                        showingBar = false
                    }
                    
                    state = .none
                case .clicking:
                    state = .editing
                case .none:
                    print("a")
                }
            } deleteFunction: {
                if state == .editing{
                    annotations.removeAll { $0.id == annotationSelected.id }
                    withAnimation {
                        showingBar = false
                    }
                    
                    state = .none
                }
            }
            // Sistema de abaixar e levantar barra (provisório)
            .onTapGesture {
            }
            .offset(x: 0, y: showingBar ? 0 : 250)
        }
    }
    
    func updateAnnotation(lugar: Place, index: Int){
        let newAnnotation = Place(name: lugar.name, descricao: lugar.descricao, categoria: lugar.categoria, coordinate: lugar.coordinate, state: lugar.state)
        // Remover a antiga anotação
        annotations.removeAll { $0.id == lugar.id }
        // Adicionar uma nova anotação
        annotations.insert(newAnnotation, at: index)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
