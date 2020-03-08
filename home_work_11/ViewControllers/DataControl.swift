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

    func insertItem(_ firstField: String, _ secondField: String, _ view: String) {
        switch view {
        case "Lector":
            let lector = Lectors(context: context)
            lector.name = firstField
            lector.surname = secondField
        case "Student":
            let student = Students(context: context)
            student.name = firstField
            student.surname = secondField
        case "Home work":
            let homeWork = HomeWorks(context: context)
            homeWork.task = firstField
            homeWork.lecture = secondField
        case "Lecture":
            let lecture = Lectures(context: context)
            lecture.theme = firstField
            lecture.lector = secondField
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

    func insertMark(fiedsText: [String], _ student: Students?) {
        let mark = Marks(context: context)
            mark.mark = fiedsText[0]
            mark.clarification = fiedsText[1]
            mark.homework = fiedsText[2]
            mark.students = student!
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
