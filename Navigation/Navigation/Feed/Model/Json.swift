//
//  Json.swift
//  Navigation
//
//  Created by Андрей Васильев on 06.12.2022.
//

import Foundation

func jsonRequest(comletion: ((_ json: String) -> Void)?) {
    if let url = URL(string: "https://jsonplaceholder.typicode.com/todos/") {
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            if let unwrappedData = data {
                do {
                    let serializedData = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                    if let arrayData = serializedData as? [[String: Any]] {
                        let dictData = arrayData[5]
                        if let titleString = dictData["title"] as? String {
                            comletion?(titleString)
                        }
                    }
                } catch let error {
                    print(error)
                }
            }
        })
        task.resume()
    }
}
