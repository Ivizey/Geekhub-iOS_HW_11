//
//  AlertMarkViewController.swift
//  home_work_11
//
//  Created by Pavel Bondar on 13.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UIAlertController

struct AlertMarkViewController {
    private static var student: Students?
    private static let picker: HomeWorksPicker = {
        let picker = HomeWorksPicker()
        picker.delegate = picker
        picker.backgroundColor = .white
        return picker
    }()

    private static let alert: UIAlertController = {
         let alert = UIAlertController(title: "Add new", message: nil, preferredStyle: .alert)
         alert.addTextField { field in
             field.placeholder = "Mark"
         }
         alert.addTextField { field in
             field.placeholder = "Clarification"
         }
         alert.addTextField { field in
            field.inputView = picker
             field.placeholder = "Home work"
             field.inputAccessoryView = picker.showToolBar()
         }
         alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
             let firstField = alert.textFields![0].text!
             let secondField = alert.textFields![1].text!
             let thirdField = alert.textFields![2].text!
             if !firstField.isEmpty && !secondField.isEmpty && !thirdField.isEmpty {
                 let data = DataControl()
                data.insertMark(firstField, secondField, thirdField, student!)
             }
             clearFields()
         }))
         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
             clearFields()
         }))
         return alert
     }()

    static func showBasicAlert(viewController: UIViewController, student: Students) {
        self.student = student
        DispatchQueue.main.async { viewController.present(alert, animated: true) }
    }

    private static func clearFields() {
        alert.textFields?.map({ $0.text = "" })
    }

    static func dismiss() {
        alert.textFields?.last?.endEditing(true)
    }

    static func passItem(item: String) {
        alert.textFields?.last?.text = item
    }
}
