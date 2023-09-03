//
//  Categorias.swift
//  Mini2
//
//  Created by Henrique Semmer on 03/09/23.
//

import Foundation
import SwiftUI

struct Categoria: Identifiable{
    let id = UUID()
    let name: String
    let symbol: String
    let color: Color
    
    static var buraco = Categoria(name: "Buraco", symbol: "", color: Color.purple)
    static var pavimentacao = Categoria(name: "Não pavimentada", symbol: "", color: Color.green)
    static var transito = Categoria(name: "Trânsito", symbol: "", color: Color.indigo)
    static var queda = Categoria(name: "Caí aqui", symbol: "", color: Color.red)
    static var reforma = Categoria(name: "Reforma", symbol: "", color: Color.pink)
    static var manutencao = Categoria(name: "Em manutenção", symbol: "", color: Color.cyan)
    
    static func getAll() -> [Categoria]{
        var result: [Categoria] = []
        result.append(buraco)
        result.append(pavimentacao)
        result.append(transito)
        result.append(queda)
        result.append(reforma)
        result.append(manutencao)
        
        return result
    }
}
