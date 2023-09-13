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
    
    static var geral = Categoria(name: "Geral", symbol: "Geral", color: Color("Lilás"))
    static var perigo = Categoria(name: "Perigo", symbol: "Perigo", color: Color("Laranja"))
    static var estacionamento = Categoria(name: "Estacionamento", symbol: "Estacionamento", color: Color("VerdeVelocidade"))
    static var via = Categoria(name: "Via danificada", symbol: "Danificada", color: Color("RoxoEscuro"))
    static var manutencao = Categoria(name: "Em manutenção", symbol: "Manutenção", color: Color("AzulAmoroso"))
    
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
