//
//  FeedModel.swift
//  Navigation
//
//  Created by Андрей Васильев on 03.11.2022.
//

import Foundation

class FeedModel {

    let secretWord: String
    init() {
        secretWord = "Привет"
    }
    func check(word: String) -> Bool {
        self.secretWord == word
    }

}
