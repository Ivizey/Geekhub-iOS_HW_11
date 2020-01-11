//
//  AlertViewController.swift
//  home_work_11
//
//  Created by Pavel Bondar on 10.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UIAlertController

struct AlertViewController {
    private static var currentView: String?
    private static let picker: PickerViewController = {
        let picker = PickerViewController()
        picker.delegate = picker
        picker.backgroundColor = .white
        return picker
    }()

    private static let alert: UIAlertController = {
        let alert = UIAlertController(title: "Add new", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addTextField { field in
            field.inputView = picker
            field.inputAccessoryView = picker.showToolBar()
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            let firstField = alert.textFields![0].text!
            let secondField = alert.textFields![1].text!
            if !firstField.isEmpty && !secondField.isEmpty {
                let data = DataControl()
                data.insertItem(firstField, secondField, currentView ?? "")
            }
            clearFields()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            clearFields()
        }))
        return alert
    }()

    private static let alertForMark: UIAlertController = {
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
            if !firstField.isEmpty && !secondField.isEmpty {
                let data = DataControl()
                data.insertItem(firstField, secondField, "")
            }
            clearFields()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            clearFields()
        }))
        return alert
    }()

    static private func clearFields() {
        alert.textFields?[0].text = ""
        alert.textFields?[1].text = ""
    }

    static func showBasicAlert(viewController: UIViewController, view: String) {
        let placeholders = selectPlaceholder(view: view)
        currentView = view
        alert.textFields?[0].placeholder = placeholders[0]
        alert.textFields?[1].placeholder = placeholders[1]
        DispatchQueue.main.async { viewController.present(alert, animated: true) }
    }

    static func showMarkAlert(viewController: UIViewController) {
        DispatchQueue.main.async { viewController.present(alertForMark, animated: true) }
    }

    static func dismiss() {
        alert.textFields?[1].endEditing(true)
    }

    static func passItem(item: String) {
        alert.textFields?[1].text = item
    }

    private static func selectPlaceholder(view: String) -> [String] {
        switch view {
        case "Lector", "Student":
            return ["Name", "Surname"]
        case "Home work":
            return ["Task", "Lecture"]
        case "Lecture":
            return ["Theme", "Select lector"]
        default:
            return ["", ""]
        }
    }
}
