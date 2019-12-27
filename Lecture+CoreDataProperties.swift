//
//  Lecture+CoreDataProperties.swift
//  iOS_HW_11
//
//  Created by Pavel Bondar on 27.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//
//

import Foundation
import CoreData


extension Lecture {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lecture> {
        return NSFetchRequest<Lecture>(entityName: "Lecture")
    }

    @NSManaged public var theme: String?
    @NSManaged public var lector: String?
    @NSManaged public var lectors: Lector?
    @NSManaged public var homework: Homework?

}
