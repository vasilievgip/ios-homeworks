//
//  DataBaseHelper.swift
//  Navigation
//
//  Created by Андрей Васильев on 28.12.2022.
//

import Foundation
import UIKit


class DataBaseHelper {
static let shareInstance = DataBaseHelper()
let context = CoreDataManager().persistentContainer.viewContext
func saveImage(data: Data) {
let imageInstance = UIImage(data: context)
imageInstance.img = data
do {
try context.save()
print("Image is saved")
} catch {
print(error.localizedDescription)
      }
   }
}
