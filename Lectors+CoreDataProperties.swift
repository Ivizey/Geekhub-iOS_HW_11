//
//  Lectors+CoreDataProperties.swift
//  home_work_11
//
//  Created by Pavel Bondar on 03.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//
//

import Foundation
import CoreData

extension Lectors {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lectors> {
        return NSFetchRequest<Lectors>(entityName: "Lectors")
    }

    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var lectures: NSSet?
}

// MARK: Generated accessors for lectures
extension Lectors {

    @objc(addLecturesObject:)
    @NSManaged public func addToLectures(_ value: Lectures)

    @objc(removeLecturesObject:)
    @NSManaged public func removeFromLectures(_ value: Lectures)

    @objc(addLectures:)
    @NSManaged public func addToLectures(_ values: NSSet)

    @objc(removeLectures:)
    @NSManaged public func removeFromLectures(_ values: NSSet)
}
