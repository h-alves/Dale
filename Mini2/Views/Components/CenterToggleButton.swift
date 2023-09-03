//
//  CenterToggleView.swift
//  Mini2
//
//  Created by Henrique Semmer on 02/09/23.
//

import SwiftUI

struct CenterToggleButton: View {
    @Binding var centered: Bool
    @State var centerSymbol: Bool
    
    @State var funcao: () -> Void
    
    var body: some View {
        VStack{
            Button {
                funcao()
                if centered{
                    centerSymbol = true
                }else{
                    centerSymbol = false
                }
                print("Houve clique | Centered: \(centered) CenterSymbol: \(centerSymbol)")
            } label: {
                Image(systemName: icon())
                    .frame(width: 15, height: 15)
                    .padding()
                    .background(.white)
                    .cornerRadius(12)
            }
        }
    }
    
    func icon() -> String{
        if centered{
            return "location.fill"
        }else{
            return "location"
        }
    }
}

struct CenterToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        CenterToggleButton(centered: .constant(true), centerSymbol: true){
            print("a")
        }
    }
}
