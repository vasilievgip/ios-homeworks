//
//  photosArray.swift
//  Navigation
//
//  Created by Андрей Васильев on 09.08.2022.
//

import Foundation
import UIKit


struct PhotosArray {
    var image: UIImage

    static func makeMockPhotosModel() -> [PhotosArray] {
        var model = [PhotosArray]()
        model.append(PhotosArray(image: UIImage(named: "photo1") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo2") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo3") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo4") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo5") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo6") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo7") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo8") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo9") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo10") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo11") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo12") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo13") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo14") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo15") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo16") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo17") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo18") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo19") ?? UIImage(named: "nophoto")!))
        model.append(PhotosArray(image: UIImage(named: "photo20") ?? UIImage(named: "nophoto")!))
        return model
    }
}
