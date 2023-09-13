//
//  HistoricoView.swift
//  Dale
//
//  Created by Yana Preisler on 11/09/23.
//

import SwiftUI
import CoreLocation

struct HistoricoView: View {
    @State var annotations: [Place]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView{
            VStack {
                VStack{
                    ForEach(annotations) { annotation in
                        CardView(annotation: annotation)
                    }
                }
            }
            .padding(.horizontal, 24)
            .navigationBarBackButtonHidden()
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack{
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(Color("MagentaMarrenta"))
                    }
                }
            }
        }
    }
}

struct HistoricoView_Previews: PreviewProvider {
    static var previews: some View {
        HistoricoView(annotations: [Place.emptyPlace])
    }
}
