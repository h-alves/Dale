//
//  Place.swift
//  Mini2
//
//  Created by Henrique Semmer on 02/09/23.
//

import Foundation
import CoreLocation

struct Place: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
    var creating: Bool
    
    static var emptyPlace = Place(name: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), creating: false)
}
