//
//  Lectures+CoreDataProperties.swift
//  home_work_11
//
//  Created by Pavel Bondar on 03.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//
//

import Foundation
import CoreData

extension Lectures {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lectures> {
        return NSFetchRequest<Lectures>(entityName: "Lectures")
    }

    @NSManaged public var lector: String?
    @NSManaged public var theme: String?
    @NSManaged public var homeworks: HomeWorks?
    @NSManaged public var lectors: Lectors?
}
