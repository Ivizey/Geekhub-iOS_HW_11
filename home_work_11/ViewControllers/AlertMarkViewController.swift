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
            guard var textField = alert.textFields else { return }
            var fieldText = [String]()
            let dataControl = DataControl()
            textField.forEach { field in fieldText.append(field.text ?? "?") }
            dataControl.insertMark(fiedsText: fieldText, student)
            clearFields()
         }))
         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in clearFields() }))
         return alert
     }()

    static func showBasicAlert(viewController: UIViewController, student: Students) {
        self.student = student
        DispatchQueue.main.async { viewController.present(alert, animated: true) }
    }

    private static func clearFields() {
        alert.textFields?.forEach({ field in field.text = "" })
    }

    static func dismiss() {
        alert.textFields?.last?.endEditing(true)
    }

    static func passItem(item: String) {
        alert.textFields?.last?.text = item
    }
}
