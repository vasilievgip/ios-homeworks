//
//  Planet.swift
//  Navigation
//
//  Created by Андрей Васильев on 06.12.2022.
//

import Foundation

struct Planet: Codable {

    var name = String()
    var rotationPeriod = String()
    var orbitalPeriod = String()
    var diameter = String()
    var climate = String()
    var gravity = String()
    var terrain = String()
    var surfaceWater = String()
    var population = String()
    var residents = [String]()
    var films = [String]()
    var created = String()
    var edited = String()
    var url = String()

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter
        case climate
        case gravity
        case terrain
        case surfaceWater = "surface_water"
        case population
        case residents
        case films
        case created
        case edited
        case url
    }
    
}

var planet = Planet()

func planetRequest() {
    if let url = URL(string: "https://swapi.dev/api/planets/1") {
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            if let unwrappedData = data {
                do {
                    let serializedData = try JSONDecoder().decode(Planet.self, from: unwrappedData)
                    planet.orbitalPeriod = serializedData.orbitalPeriod
                    planet.residents = serializedData.residents
                } catch let error {
                    print(error)
                }
            }
        })
        task.resume()
    }
}
