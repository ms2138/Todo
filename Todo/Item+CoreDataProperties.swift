//
//  Item+CoreDataProperties.swift
//  Todo
//
//  Created by mani on 2020-04-29.
//  Copyright © 2020 home. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var createdAt: Date
    @NSManaged public var finished: Bool
    @NSManaged public var name: String

}
