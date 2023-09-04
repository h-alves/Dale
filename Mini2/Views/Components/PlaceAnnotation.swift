//
//  PlaceAnnotationView.swift
//  Mini2
//
//  Created by Henrique Semmer on 02/09/23.
//

import SwiftUI

struct PlaceAnnotation: View {
    // Mudar o estilo se tiver sendo criado, editado ou parado no lugar
    var funcao: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
          Image(systemName: "mappin.circle.fill")
            .font(.title)
            .foregroundColor(.red)
          
          Image(systemName: "arrowtriangle.down.fill")
            .font(.caption)
            .foregroundColor(.red)
            .offset(x: 0, y: -5)
        }
        .onTapGesture {
            withAnimation {
                funcao()
            }
        }
    }
}

struct PlaceAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        PlaceAnnotation(){
            print("a")
        }
    }
}
