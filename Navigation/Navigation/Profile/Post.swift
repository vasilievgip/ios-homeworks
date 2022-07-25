//
//  Post.swift
//  Navigation
//
//  Created by Андрей Васильев on 22.06.2022.
//

import Foundation
import UIKit

struct Post {
    var author: String
    var description: String
    var image: UIImage
    var likes: Int
    var views: Int
    
    static func makeMockModel() -> [Post] {
        var model = [Post]()
        model.append(Post(author: "Shuriban", description: "Вчера вечером решил отметить профессиональный праздник небольшим скриптом. Всех коллег с праздником!", image: UIImage(named: "programmerday")!, likes: 658, views: 47687))
        model.append(Post(author: "Рушка - 50 лучших постов ВКонтакте за сутки", description: "Бездонное озеро в кратере потухшего вулкана. Этот кратер с одним из самых глубоких в мире озер - до 1500 метров в глубину находится в Уганде, на территории Национального парка королевы Елизаветы.", image: UIImage(named: "ozero")!, likes: 5868, views: 58243))
        model.append(Post(author: "Рушка - 50 лучших постов ВКонтакте за сутки", description: "Французский канатоходец Филипп Пети совершает переход по канату между башнями Всемирного Торгового Центра. Нью-Йорк, 7 августа 1974 года", image: UIImage(named: "walker")!, likes: 6287, views: 4767787))
        model.append(Post(author: "Рушка - 50 лучших постов ВКонтакте за сутки", description: "Слишком часто в наше время...", image: UIImage(named: "people")!, likes: 58568, views: 5353443))
        model.append(Post(author: "Рушка - 50 лучших постов ВКонтакте за сутки", description: "Невозможно «пить мало», «курить редко», «изменять жене в пределах разумного». Нет «золотой середины» при определении степени порочности.Нельзя деградировать в меру...(с)", image: UIImage(named: "monk")!, likes: 75868, views: 458243))
        return model
    }
}

