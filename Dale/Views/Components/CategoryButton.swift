//
//  CategoryButton.swift
//  Dale
//
//  Created by Henrique Semmer on 03/09/23.
//

import SwiftUI

struct CategoryButton: View {
    @State var categoria: Categoria
    var isSelected: Bool
    
    var body: some View {
        Text(categoria.name)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .background(isSelected ? Color(.gray) : categoria.color)
            .cornerRadius(6)
    }
}

struct CategoryButton_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButton(categoria: Categoria.geral, isSelected: false)
    }
}
