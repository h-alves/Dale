//
//  CardView.swift
//  Dale
//
//  Created by Yana Preisler on 11/09/23.
//

import SwiftUI
import CoreLocation

struct CardView: View {
    @State var annotation: Place
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
               Text(annotation.name)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.bottom, 2)
                
                Text(annotation.descricao)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    
                    .padding(.bottom, 8)
                
                CategoryButton(categoria: annotation.categoria)
            }
            .padding(.vertical, 20)
            
            Spacer()
            
            Image(annotation.categoria.symbol)
                .frame()
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .background(Color("RoxoBGaux"))
        .cornerRadius(10)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(annotation: Place(name: "teste", descricao: "teste", categoria: .estacionamento, coordinate: CLLocationCoordinate2D(latitude: 12, longitude: 12), state: .none))
    }
}
