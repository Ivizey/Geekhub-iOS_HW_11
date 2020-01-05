//
//  HomeWorks+CoreDataProperties.swift
//  home_work_11
//
//  Created by Pavel Bondar on 03.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//
//

import Foundation
import CoreData

extension HomeWorks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HomeWorks> {
        return NSFetchRequest<HomeWorks>(entityName: "HomeWorks")
    }

    @NSManaged public var lecture: String?
    @NSManaged public var task: String?
    @NSManaged public var lectures: Lectures?
    @NSManaged public var marks: Marks?
}
