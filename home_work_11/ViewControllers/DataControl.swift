//
//  DataControl.swift
//  home_work_11
//
//  Created by Pavel Bondar on 11.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import CoreData

class DataControl {
    private let context = CoreDataStack.shared.persistentContainer.viewContext

    func insertItem(fiedsText: [String], view: String?) {
        switch view {
        case "Lector":
            let lector = Lectors(context: context)
            lector.name = fiedsText[0]
            lector.surname = fiedsText[1]
        case "Student":
            let student = Students(context: context)
            student.name = fiedsText[0]
            student.surname = fiedsText[1]
        case "Home work":
            let homeWork = HomeWorks(context: context)
            homeWork.task = fiedsText[0]
            homeWork.lecture = fiedsText[1]
        case "Lecture":
            let lecture = Lectures(context: context)
            lecture.theme = fiedsText[0]
            lecture.lector = fiedsText[1]
        default:
            return
        }
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    func insertMark(fiedsText: [String], student: Students?) {
        let mark = Marks(context: context)
            mark.mark = fiedsText[0]
            mark.clarification = fiedsText[1]
            mark.homework = fiedsText[2]
            mark.students = student ?? Students()
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
