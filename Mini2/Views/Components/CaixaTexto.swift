//
//  CaixaTexto.swift
//  Mini2
//
//  Created by Henrique Semmer on 02/09/23.
//

import SwiftUI

struct CaixaTexto: View {
    let textoCaixa: String
    @Binding var texto: String
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        TextField(textoCaixa, text: $texto)
            .focused($isFocused)
            .underlineTextField()
            .foregroundColor(.black)
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
            .foregroundColor(.black)
            .padding(10)
    }
}

struct CaixaTexto_Previews: PreviewProvider {
    static var previews: some View {
        CaixaTexto(textoCaixa: "Nome", texto: .constant(""))
    }
}
