//
//  Place.swift
//  Dale
//
//  Created by Henrique Semmer on 02/09/23.
//

import Foundation
import CoreLocation

struct Place: Identifiable {
    let id = UUID()
    var name: String
    var descricao: String
    var categoria: Categoria
    var coordinate: CLLocationCoordinate2D
    var state: Modo
    
    static var emptyPlace = Place(name: "", descricao: "", categoria: Categoria.vazia, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), state: .none)
}
