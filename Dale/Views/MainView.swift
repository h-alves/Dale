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
    @State var annotations: [Place] = []
    
    @State var showingBar = false
    @State var annotationSelected: Place = .emptyPlace
    
    @State var state: Modo = .none
    
    @State var nome = ""
    @State var descricao = ""
    @State var categoria: Categoria = Categoria.vazia
    
    var body: some View{
        ZStack(alignment: .bottom){
            Map(coordinateRegion: $manager.region, interactionModes: .all, showsUserLocation: true, annotationItems: annotations){ place in
                MapAnnotation(coordinate: place.state == .creating ? manager.region.center : place.coordinate) {
                    PlaceAnnotation(){
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
                        if state == .creating{
                            annotations.removeAll { $0.id == annotationSelected.id }
                            annotationSelected = .emptyPlace
                        }
                        withAnimation {
                            showingBar = false
                        }
                        state = .none
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
                        
//                        manager.centered = false
                        if state == .creating{
                            annotations.removeAll { $0.id == annotationSelected.id }
                            annotationSelected = .emptyPlace
                            withAnimation {
                                showingBar = false
                            }
                            state = .none
                        }else{
                            let newAnnotation = Place(name: "", descricao: "", categoria: Categoria.vazia, coordinate: manager.region.center, state: .creating)
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
            
            BottomBarView(annotation: $annotationSelected,  state: $state, nome: $nome, descricao: $descricao, categoria: $categoria){
                let index = annotations.firstIndex(where: { $0.id == annotationSelected.id})
                
                switch state{
                case .creating:
                    annotations[index!].coordinate = manager.region.center
                    annotations[index!].state = .editing
                    state = .editing
                case .editing:
                    annotations[index!].name = nome
                    annotations[index!].descricao = descricao
                    annotations[index!].categoria = categoria
                    annotationSelected = .emptyPlace
                    
                    withAnimation {
                        showingBar = false
                    }
                    
                    state = .none
                    nome = ""
                    descricao = ""
                case .clicking:
                    state = .editing
                case .none:
                    print("a")
                }
            }
            // Sistema de abaixar e levantar barra (provisório)
            .onTapGesture {
            }
            .offset(x: 0, y: showingBar ? 0 : 250)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
