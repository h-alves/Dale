//
//  MainView.swift
//  Mini2
//
//  Created by Henrique Semmer on 02/09/23.
//

import SwiftUI
import MapKit

struct MainView: View {
    @StateObject var manager = LocationManager()
    @State var annotations: [Place] = []
    
    @State var showingCredits = false
    @State var creatingAnnotation = false
    @State var clickingAnnotation = false
    @State var annotationSelected: Place = .emptyPlace
    
    @State var nome = ""
    @State var descricao = ""
    @State var categoria: Categoria = Categoria.vazia
    
    var body: some View{
        ZStack(alignment: .bottom){
            Map(coordinateRegion: $manager.region, interactionModes: .all, showsUserLocation: true, annotationItems: annotations){ place in
                MapAnnotation(coordinate: place.creating ? manager.region.center : place.coordinate) {
                    PlaceAnnotation(){
                        annotationSelected = place
                        manager.region.center = annotationSelected.coordinate
                        withAnimation{
                            showingCredits = true
                        }
                        clickingAnnotation = true
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
                        if creatingAnnotation{
                            annotations.removeAll { $0.id == annotationSelected.id }
                            annotationSelected = .emptyPlace
                        }
                        withAnimation {
                            showingCredits = false
                        }
                        creatingAnnotation = false
                        clickingAnnotation = false
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
                        
                        manager.centered = false
                        if creatingAnnotation{
                            annotations.removeAll { $0.id == annotationSelected.id }
                            annotationSelected = .emptyPlace
                            withAnimation {
                                showingCredits = false
                            }
                            creatingAnnotation = false
                        }else{
                            let newAnnotation = Place(name: "", descricao: "", categoria: Categoria.vazia, coordinate: manager.region.center, creating: true)
                            annotationSelected = newAnnotation
                            annotations.append(newAnnotation)
                            creatingAnnotation = true
                            withAnimation {
                                showingCredits = true
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
            
            BottomBarView(annotation: $annotationSelected, creatingAnnotation: $creatingAnnotation, clickingMarker: $clickingAnnotation, nome: $nome, descricao: $descricao, categoria: $categoria){
                if creatingAnnotation{
                    let index = annotations.firstIndex(where: { $0.id == annotationSelected.id})
                    annotations[index!].name = nome
                    annotations[index!].descricao = descricao
                    annotations[index!].categoria = categoria
                    annotations[index!].coordinate = manager.region.center
                    annotations[index!].creating = false
                    annotationSelected = .emptyPlace
                    withAnimation {
                        showingCredits.toggle()
                    }
                    creatingAnnotation = false
                    nome = ""
                    descricao = ""
                }
            }
            // Sistema de abaixar e levantar barra (provisório)
            .onTapGesture {
                if !creatingAnnotation{
                    withAnimation {
                        showingCredits.toggle()
                    }
                }
            }
            .offset(x: 0, y: showingCredits ? 0 : 250)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
