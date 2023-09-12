//
//  HistoricoView.swift
//  Dale
//
//  Created by Yana Preisler on 11/09/23.
//

import SwiftUI
import CoreLocation

struct HistoricoView: View {
    @State var annotations: [Place] = []
    
    
    var body: some View {
        VStack {
            
            HStack {
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                Text("Buscar")
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(Color("RoxoBGaux"))
            .cornerRadius(10)
            
            VStack{
                
                ForEach(annotations) { annotation in
                    CardView(annotation: annotation)
                }
            }
        }
        .padding(.horizontal, 24)
    }
}

struct HistoricoView_Previews: PreviewProvider {
    static var previews: some View {
        HistoricoView()
    }
}
