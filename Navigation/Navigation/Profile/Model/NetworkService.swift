//
//  NetworkService.swift
//  Navigation
//
//  Created by Андрей Васильев on 29.11.2022.
//

import Foundation

struct NetworkService {
    
    static func request(for configuration: AppConfiguration) {

        let urlSession = URLSession.shared
        let url: URL
        let configurationURL = configuration
        switch configurationURL {
        case .url_1:
            url = URL(string: "https://swapi.dev/api/people/8")!
        case .url_2:
            url = URL(string: "https://swapi.dev/api/starships/3")!
        case .url_3:
            url = URL(string: "https://swapi.dev/api/planets/5")!
        }

        let task = urlSession.dataTask(with:url, completionHandler: {data, response, error in
            if let unwrappedData = data {
                let parsedData = String(data: unwrappedData, encoding: .utf8)
                print("Data: \(String(describing: parsedData))")
            }
            if let castedResponce = response as? HTTPURLResponse {
                print("ResponseAllHeaderFields: \(castedResponce.allHeaderFields)")
                print("ResponseStatusCode: \(castedResponce.statusCode)")
            }
            print("Error: \(error.debugDescription)")
        })
        task.resume()

    }
    
}
