//
//  Homework+CoreDataProperties.swift
//  iOS_HW_11
//
//  Created by Pavel Bondar on 27.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//
//

import Foundation
import CoreData


extension Homework {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Homework> {
        return NSFetchRequest<Homework>(entityName: "Homework")
    }

    @NSManaged public var task: String?
    @NSManaged public var lecture: String?
    @NSManaged public var lectures: Lecture?
    @NSManaged public var marks: Mark?

}
