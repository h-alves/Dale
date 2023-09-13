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
    @State var barUp: CGFloat = 250
    
    @State var annotations: [Place] = PlaceController().recuperar() ?? []
    @State var annotationSelected: Place = .emptyPlace
    
    @State var state: Modo = .none
    
    @State var nome = ""
    @State var descricao = ""
    @State var categoria: Categoria = Categoria.vazia
    
    @State var busca = ""
    
    var body: some View{
        ZStack(alignment: .bottom){
            Map(coordinateRegion: $manager.region, interactionModes: .all, showsUserLocation: true, annotationItems: annotations){ place in
                MapAnnotation(coordinate: place.state == .creating ? manager.region.center : place.coordinate) {
                    PlaceAnnotation(place: place){
                        if state == .none{
                            HapticsService.shared.play(.rigid)
                            annotationSelected = place
                            manager.region.center = annotationSelected.coordinate
                            state = .clicking
                            withAnimation{
                                barUp = 120
                            }
                        }
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
                        state = .none
                        withAnimation {
                            barUp = 250
                        }
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
                        HapticsService.shared.play(.medium)
                        
                        if state == .creating{
                            annotations.removeAll { $0.id == annotationSelected.id }
                            annotationSelected = .emptyPlace
                            state = .none
                            withAnimation {
                                barUp = 250
                            }
                        }else{
                            let newAnnotation = Place(name: "", descricao: "", categoria: Categoria.geral, coordinate: manager.region.center, state: .creating)
                            annotationSelected = newAnnotation
                            annotations.append(newAnnotation)
                            state = .creating
                            withAnimation {
                                barUp = 160
                            }
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
            
            BottomBarView(annotations: $annotations, annotation: $annotationSelected,  state: $state, nome: $nome, descricao: $descricao, categoria: $categoria, selected: $categoria, buscar: $busca){
                let index = annotations.firstIndex(where: { $0.id == annotationSelected.id})
                
                switch state{
                case .creating:
                    HapticsService.shared.play(.medium)
                    annotations[index!].coordinate = manager.region.center
                    annotations[index!].state = .editing
                    
                    state = .editing
                    withAnimation {
                        barUp = 0
                    }
                    
                    nome = ""
                    descricao = ""
                    categoria = Categoria.geral
                case .editing:
                    HapticsService.shared.play(.heavy)
                    annotations[index!].name = nome
                    annotations[index!].descricao = descricao
                    annotations[index!].categoria = categoria
                    
                    annotationSelected = .emptyPlace
                    
                    PlaceController().salvar(places: annotations)
                    
                    state = .none
                    withAnimation {
                        barUp = 250
                    }
                    
                case .clicking:
                    state = .editing
                    withAnimation {
                        barUp = 0
                    }
                case .none:
                    withAnimation {
                        barUp = 0
                    }
                }
            } deleteFunction: {
                if state == .editing{
                    annotations.removeAll { $0.id == annotationSelected.id }
                    state = .none
                    withAnimation {
                        barUp = 250
                    }
                }
            }
            // Sistema de abaixar e levantar barra (provisório)
            .onTapGesture {
            }
            .offset(x: 0, y: barUp)
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
