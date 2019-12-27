//
//  Mark+CoreDataProperties.swift
//  iOS_HW_11
//
//  Created by Pavel Bondar on 27.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//
//

import Foundation
import CoreData


extension Mark {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mark> {
        return NSFetchRequest<Mark>(entityName: "Mark")
    }

    @NSManaged public var mark: String?
    @NSManaged public var clarification: String?
    @NSManaged public var homework: String?
    @NSManaged public var homeworks: Homework?

}
