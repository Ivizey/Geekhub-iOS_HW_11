//
//  Lectors+CoreDataClass.swift
//  home_work_11
//
//  Created by Pavel Bondar on 03.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Lectors)
public class Lectors: NSManagedObject {
    var lecturesArray: [Lectures] {
        lectures?.allObjects as? [Lectures] ?? []
    }
}
