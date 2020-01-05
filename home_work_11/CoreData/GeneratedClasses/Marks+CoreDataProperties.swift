//
//  Marks+CoreDataProperties.swift
//  home_work_11
//
//  Created by Pavel Bondar on 03.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//
//

import Foundation
import CoreData

extension Marks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Marks> {
        return NSFetchRequest<Marks>(entityName: "Marks")
    }

    @NSManaged public var clarification: String?
    @NSManaged public var homework: String?
    @NSManaged public var mark: String?
    @NSManaged public var homeworks: HomeWorks?
    @NSManaged public var students: Students?
}
