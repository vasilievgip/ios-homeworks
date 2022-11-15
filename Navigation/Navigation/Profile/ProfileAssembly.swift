//
//  ProfileAssembly.swift
//  Navigation
//
//  Created by Андрей Васильев on 13.11.2022.
//

import Foundation
import UIKit


let postArray: [User.Post] = [
    User.Post(author: "Shuriban", description: "Вчера вечером решил отметить профессиональный праздник небольшим скриптом. Всех коллег с праздником!", image: UIImage(named: "programmerday") ?? UIImage(named: "nophoto")!, likes: 658, views: 47687),
    User.Post(author: "Рушка - 50 лучших постов ВКонтакте за сутки", description: "Бездонное озеро в кратере потухшего вулкана. Этот кратер с одним из самых глубоких в мире озер - до 1500 метров в глубину находится в Уганде, на территории Национального парка королевы Елизаветы.", image: UIImage(named: "ozero") ?? UIImage(named: "nophoto")!, likes: 5868, views: 58243),
    User.Post(author: "Рушка - 50 лучших постов ВКонтакте за сутки", description: "Французский канатоходец Филипп Пети совершает переход по канату между башнями Всемирного Торгового Центра. Нью-Йорк, 7 августа 1974 года", image: UIImage(named: "walker") ?? UIImage(named: "nophoto")!, likes: 6287, views: 4767787),
    User.Post(author: "Рушка - 50 лучших постов ВКонтакте за сутки", description: "Слишком часто в наше время...", image: UIImage(named: "people") ?? UIImage(named: "nophoto")!, likes: 58568, views: 5353443),
    User.Post(author: "Рушка - 50 лучших постов ВКонтакте за сутки", description: "Невозможно «пить мало», «курить редко», «изменять жене в пределах разумного». Нет «золотой середины» при определении степени порочности.Нельзя деградировать в меру...(с)", image: UIImage(named: "monk") ?? UIImage(named: "nophoto")!, likes: 75868, views: 458243)
]

var photosArray = [User.PhotosArray]()

#if DEBUG
let user = User(login: "test@yandex.ru", fullName: "Test Test Test", avatar: UIImage(systemName: "eyes") ?? UIImage(named: "nophoto")!, status: "Waiting for Test...")
#else
let user = User(login: "vasilievgip@yandex.ru", fullName: "Андрей Александрович Васильев", avatar: UIImage(named: "avatar") ?? UIImage(named: "nophoto")!, status: "Waiting for something...")
#endif
