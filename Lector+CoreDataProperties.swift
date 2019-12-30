//
//  Lector+CoreDataProperties.swift
//  iOS_HW_11
//
//  Created by Pavel Bondar on 30.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//
//

import Foundation
import CoreData


extension Lector {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lector> {
        return NSFetchRequest<Lector>(entityName: "Lector")
    }

    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var lectures: NSSet?

}

// MARK: Generated accessors for lectures
extension Lector {

    @objc(addLecturesObject:)
    @NSManaged public func addToLectures(_ value: Lecture)

    @objc(removeLecturesObject:)
    @NSManaged public func removeFromLectures(_ value: Lecture)

    @objc(addLectures:)
    @NSManaged public func addToLectures(_ values: NSSet)

    @objc(removeLectures:)
    @NSManaged public func removeFromLectures(_ values: NSSet)

}
