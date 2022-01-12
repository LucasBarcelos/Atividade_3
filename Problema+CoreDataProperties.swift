//
//  Problema+CoreDataProperties.swift
//  atividade-3
//
//  Created by Lucas Barcelos on 11/01/22.
//
//

import Foundation
import CoreData


extension Problema {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Problema> {
        return NSFetchRequest<Problema>(entityName: "Problema")
    }

    @NSManaged public var nome: String?
    @NSManaged public var endereco: String?
    @NSManaged public var descricao: String?
    @NSManaged public var imagem: NSObject?

}

extension Problema : Identifiable {

}
