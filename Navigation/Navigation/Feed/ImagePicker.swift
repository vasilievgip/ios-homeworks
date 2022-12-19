//
//  ImagePicker.swift
//  Navigation
//
//  Created by Андрей Васильев on 19.12.2022.
//

import Foundation
import UIKit


class ImagePicker {

    static let defaultPicker = ImagePicker()

    func showPicker (in viewController: UIViewController, completion: @escaping (_ text: String) -> Void) {

        let alert = UIAlertController(title: "Добавить картинку", message: "Введите имя файла", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter text"
        }
        alert.addAction(UIAlertAction(title: "Создать", style: .default, handler: { action in
            if let text = alert.textFields?[0].text,
               text != "" {
                completion(text)
            }
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: { action in
            print("отмена")
        }))
        viewController.present(alert, animated: true)
    }

}
