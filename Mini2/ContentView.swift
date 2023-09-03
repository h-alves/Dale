//
//  ContentView.swift
//  Mini2
//
//  Created by Henrique Semmer on 24/08/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var manager = LocationManager()
    @State var annotations: [Place] = []
    
    @State var showingCredits = false
    @State var creatingAnnotation = false
    @State var annotationSelected: Place = .emptyPlace
    
    var body: some View{
        ZStack(alignment: .bottom){
            Map(coordinateRegion: $manager.region, interactionModes: .all, showsUserLocation: true, annotationItems: annotations){ place in
                MapAnnotation(coordinate: place.creating ? manager.region.center : place.coordinate) {
                    PlaceAnnotationView(){
                        showingCredits.toggle()
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
                            withAnimation {
                                showingCredits = false
                            }
                            creatingAnnotation = false
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
                        manager.centered = false
                        if creatingAnnotation{
                            annotations.removeAll { $0.id == annotationSelected.id }
                            annotationSelected = .emptyPlace
                            withAnimation {
                                showingCredits = false
                            }
                            creatingAnnotation = false
                        }else{
                            //verifica se já não existe uma anotação naquela coordenada
                            let newAnnotation = Place(name: "Nova anotação", coordinate: manager.region.center, creating: true)
                            annotationSelected = newAnnotation
                            annotations.append(newAnnotation)
                            creatingAnnotation = true
                            withAnimation {
                                showingCredits = true
                            }
                        }
                    })
            
            CenterToggleView(centered: $manager.centered, centerSymbol: true) {
                if manager.centered{
                    manager.centered = false
                }else{
                    manager.centered = true
                }
            }
            .position(x: 350, y: 40)
            
            BottomBarView(creatingAnnotation: creatingAnnotation){
                if creatingAnnotation{
                    let index = annotations.firstIndex(where: { $0.id == annotationSelected.id})
                    annotations[index!].coordinate = manager.region.center
                    annotations[index!].creating = false
                    //Mudar essas variaveis dentro do elemento igual o annotationSelected que esta dentro do annotations
                    annotationSelected = .emptyPlace
                    withAnimation {
                        showingCredits.toggle()
                    }
                    creatingAnnotation = false
                }
            }
            .onTapGesture {
                withAnimation {
                    showingCredits.toggle()
                }
            }
            .offset(x: 0, y: showingCredits ? 0 : 250)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
