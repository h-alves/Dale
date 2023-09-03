//
//  BottomBarView.swift
//  Mini2
//
//  Created by Henrique Semmer on 02/09/23.
//

import SwiftUI

struct BottomBarView: View {
    @Binding var creatingAnnotation: Bool
    @State var nome = ""
    @State var descricao = ""
    
    @State var definir: () -> Void
    
    var body: some View{
        VStack{
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 40, height: 5)
                .foregroundColor(Color(UIColor.systemGray2))
            
            if creatingAnnotation{
                annotationView
            }else{
                defaultView
            }
            
            Spacer()
        }
        .padding(.vertical, 5)
        .frame(height: 300)
        .frame(maxWidth: .infinity)
        .background(.white)
    }
    
    var annotationView: some View {
        VStack{
            CaixaTexto(textoCaixa: "Nome", texto: $nome)
            
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
    }
    
    var defaultView: some View{
        VStack{
            
        }
    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(creatingAnnotation: .constant(false)){
            print("a")
        }
    }
}
