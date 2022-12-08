//
//  Residents.swift
//  Navigation
//
//  Created by Андрей Васильев on 07.12.2022.
//

import Foundation

struct Resident: Codable {

    var name = String()
    var height = String()
    var mass = String()
    var hairColor = String()
    var skinColor = String()
    var eyeColor = String()
    var birthYear = String()
    var gender = String()
    var homeworld = String()
    var films = [String]()
    var species = [String]()
    var vehicles = [String]()
    var starships = [String]()
    var created = String()
    var edited = String()
    var url = String()

    enum CodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender
        case homeworld
        case films
        case species
        case vehicles
        case starships
        case created
        case edited
        case url
    }

}
var resident = Resident()
var arrayNameResident = [Resident]()
