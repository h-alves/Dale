//
//  Place.swift
//  Dale
//
//  Created by Henrique Semmer on 02/09/23.
//
import SwiftUI
import Foundation
import CoreLocation

struct Place: Identifiable{
    let id = UUID()
    var name: String
    var descricao: String
    var categoria: Categoria
    var coordinate: CLLocationCoordinate2D
    var state: Modo
    
    // Adicione conformidade aos protocolos Decodable e Encodable
    enum CodingKeys: String, CodingKey {
        case id, name, descricao, categoria, coordinate, state
    }

    static var emptyPlace = Place(name: "", descricao: "", categoria: .vazia, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), state: .none)
}

struct ponto: Codable{
    var id = UUID()
    var symbol: String
    var color: String
    var name: String
    var descricao: String
    var lon: Double
    var lat: Double
}


class PlaceController{
    
    func salvar(places: [Place]) {
        let vet = self.converterPlace(places: places)
        do {
            let encoder = JSONEncoder()
            let placeData = try encoder.encode(vet)
            UserDefaults.standard.set(placeData, forKey: "placesKey")
        } catch {
            print("Erro ao salvar places: \(error)")
        }
    }
    
    // Função para recuperar o vetor [Via] localmente
    func recuperar() -> [Place]? {
        if let pontosData = UserDefaults.standard.data(forKey: "placesKey") {
            do {
                let decoder = JSONDecoder()
                let pontos = try decoder.decode([ponto].self, from: pontosData)
                let places = self.converterPonto(pontos: pontos)
                return places
            } catch {
                print("Erro ao recuperar places: \(error)")
                return nil
            }
        }
        return nil
    }
    
    private func converterPlace(places: [Place]) -> [ponto]{
        var i = 0
        var pontinhos = [ponto]()
        while i < places.count{
            let cor = "Red"
            let aux = places[i]
            let p = ponto(symbol: aux.categoria.symbol, color: cor, name: aux.name, descricao: aux.descricao, lon: aux.coordinate.longitude, lat: aux.coordinate.latitude)
            pontinhos.append(p)
            i += 1
        }
        return pontinhos
    }
    private func converterPonto(pontos: [ponto]) -> [Place]{
        var i = 0
        var places = [Place]()
        while i < pontos.count{
            let aux = pontos[i]
            let cat = Categoria(name: aux.name, symbol: aux.symbol, color: Color("\(aux.color)"))
            let coordenada = CLLocationCoordinate2D(latitude: aux.lat, longitude: aux.lon)
            let p = Place(name: aux.name, descricao: aux.descricao, categoria: cat, coordinate: coordenada, state: .none )
            i += 1
        }
        return places
    }
}
