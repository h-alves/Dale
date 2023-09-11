//
//  Categorias.swift
//  Dale
//
//  Created by Henrique Semmer on 03/09/23.
//

import Foundation
import SwiftUI

struct Categoria: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let symbol: String
    let color: Color
    
    static var geral = Categoria(name: "Geral", symbol: "", color: Color("Lilás"))
    static var perigo = Categoria(name: "Perigo", symbol: "", color: Color("Laranja"))
    static var estacionamento = Categoria(name: "Estacionamento", symbol: "", color: Color("VerdeVelocidade"))
    static var via = Categoria(name: "Via danificada", symbol: "", color: Color("RoxoEscuro"))
    static var manutencao = Categoria(name: "Em manutenção", symbol: "", color: Color("AzulAmoroso"))
    
    static var vazia = Categoria(name: "", symbol: "", color: Color.white)
    
    static func getAll() -> [Categoria]{
        var result: [Categoria] = []
        result.append(geral)
        result.append(perigo)
        result.append(estacionamento)
        result.append(via)
        result.append(manutencao)
        
        return result
    }
}
