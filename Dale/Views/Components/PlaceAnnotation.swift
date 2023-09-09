//
//  PlaceAnnotationView.swift
//  Dale
//
//  Created by Henrique Semmer on 02/09/23.
//

import SwiftUI
import CoreLocation

struct PlaceAnnotation: View {
    // Mudar o estilo se tiver sendo criado, editado ou parado no lugar
    @State var place: Place
    
    var funcao: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(place.categoria.color)
            
            if place.state != .none{
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(place.categoria.color)
                    .offset(x: 0, y: -5)
            }
        }
        .onTapGesture {
            place.state = .clicking
            funcao()
        }
    }
}

struct PlaceAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        PlaceAnnotation(place: Place(name: "teste", descricao: "test", categoria: Categoria.manutencao, coordinate: CLLocationCoordinate2D(latitude: 12, longitude: 12), state: Modo.none)){
            print("a")
        }
    }
}
