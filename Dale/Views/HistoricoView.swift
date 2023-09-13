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
