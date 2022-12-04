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
        if let url = URL(string: configuration.rawValue) {
            print(url)            
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
    
}
