//
//  InfoViewController.swift
//  Navigation
//
//  Created by Андрей Васильев on 02.05.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    let deleteButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.deleteButton.setTitle("Удалить пост", for: .normal)
        self.deleteButton.setTitleColor(.black, for: .normal)
        self.view.addSubview(deleteButton)
        self.deleteButton.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        self.deleteButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
    }
    
    @objc
    func handleButtonTap() {
        let alert = UIAlertController(title: "Удалить пост?", message: "Пост будет удален", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ДА", style: .default, handler: { action in print("Пост удален") }))
        alert.addAction(UIAlertAction(title: "НЕТ", style: .cancel, handler: { action in print("Отмена удаления") }))
        self.present(alert, animated: true)
    }
    
}
