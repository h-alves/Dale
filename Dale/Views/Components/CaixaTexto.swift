//
//  CaixaTexto.swift
//  Dale
//
//  Created by Henrique Semmer on 02/09/23.
//

import SwiftUI

struct CaixaTexto: View {
    let textoCaixa: String
    @Binding var texto: String
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        TextField(textoCaixa, text: $texto, prompt: Text("Placeholder").foregroundColor(Color.white))
            .focused($isFocused)
            .underlineTextField()
            .foregroundColor(.white)
            .autocorrectionDisabled()
            .onTapGesture {
                self.isFocused = true
            }
    }
}

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(.white)
            .padding(10)
    }
}

struct CaixaTexto_Previews: PreviewProvider {
    static var previews: some View {
        CaixaTexto(textoCaixa: "Nome", texto: .constant(""))
    }
}
