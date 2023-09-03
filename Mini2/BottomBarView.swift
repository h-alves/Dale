//
//  BottomBarView.swift
//  Mini2
//
//  Created by Henrique Semmer on 02/09/23.
//

import SwiftUI

struct BottomBarView: View {
    @State var creatingAnnotation: Bool
    
    @State var definir: () -> Void
    
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 40, height: 5)
                .foregroundColor(Color(UIColor.systemGray2))
            Button {
                definir()
            } label: {
                Text("Define")
                    .frame(width: 50, height: 10)
                    .padding(12)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(12)
            }

            Spacer()
        }
        .padding(.vertical, 5)
        .frame(height: 300)
        .frame(maxWidth: .infinity)
        .background(.white)
    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(creatingAnnotation: false){
            print("a")
        }
    }
}
