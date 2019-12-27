//
//  Lector+CoreDataClass.swift
//  iOS_HW_11
//
//  Created by Pavel Bondar on 27.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Lector)
public class Lector: NSManagedObject {
    var lecturesArray: [Lecture] {
        lectures?.allObjects as? [Lecture] ?? []
    }
}
