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
    private static let picker: LectorsPicker = {
        let picker = LectorsPicker()
        picker.delegate = picker
        picker.backgroundColor = .white
        return picker
    }()

    private static let pickerHW: LecturesPicker = {
        let picker = LecturesPicker()
        picker.delegate = picker
        picker.backgroundColor = .white
        return picker
    }()

    private static let alert: UIAlertController = {
        let alert = UIAlertController(title: "Add new", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            let firstField = alert.textFields!.first!.text!
            let secondField = alert.textFields!.last!.text!
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

    static private func openPicker() {
        switch currentView {
        case "Lecture":
            alert.textFields?.last?.inputView = picker
        case "Home work":
            alert.textFields?.last?.inputView = pickerHW
        default:
            alert.textFields?.last?.inputView = nil
            alert.textFields?.last?.inputAccessoryView = nil
        }
        alert.textFields?.last?.inputAccessoryView = picker.showToolBar()
    }

    static func showBasicAlert(viewController: UIViewController, view: String) {
        let placeholders = selectPlaceholder(view: view)
        currentView = view
        openPicker()
        alert.textFields?.first?.placeholder = placeholders.first
        alert.textFields?.last?.placeholder = placeholders.last
        DispatchQueue.main.async { viewController.present(alert, animated: true) }
    }

    static private func clearFields() {
        alert.textFields?.map({ $0.text = "" })
    }

    static func dismiss() {
        alert.textFields?.last?.endEditing(true)
    }

    static func passItem(item: String) {
        alert.textFields?.last?.text = item
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
