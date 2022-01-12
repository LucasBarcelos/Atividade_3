//
//  UIViewController+Context.swift
//  atividade-3
//
//  Created by Lucas Barcelos on 11/01/22.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
