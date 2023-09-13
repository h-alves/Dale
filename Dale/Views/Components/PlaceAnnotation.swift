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
        Button {
            place.state = .clicking
            funcao()
        } label: {
            Image("IconeGeral")
              .resizable()
              .frame(maxWidth: 60, maxHeight: 60)
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
