//
//  PlaceAnnotationView.swift
//  Dale
//
//  Created by Henrique Semmer on 02/09/23.
//

import SwiftUI

struct PlaceAnnotation: View {
    // Mudar o estilo se tiver sendo criado, editado ou parado no lugar
    var funcao: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
          Image("IconeGeral")
            .resizable()
            .frame(maxWidth: 100, maxHeight: 100)
          
          
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
