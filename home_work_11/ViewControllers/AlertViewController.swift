//
//  AlertViewController.swift
//  home_work_11
//
//  Created by Pavel Bondar on 10.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UIAlertController

struct AlertViewController {
    private static var currentView: UIViewController?
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
            var fieldText = [String]()
            alert.textFields?.forEach({ field in
                fieldText.append(field.text ?? "-")
            })
            let dataControl = DataControl()
            dataControl.insertItem(fiedsText: fieldText, view: "")
            clearFields()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            clearFields()
        }))
        return alert
    }()

    static private func openPicker() {
        guard let fieldInput = alert.textFields?.last else { return }
        switch currentView?.title {
        case "Lecture":
            fieldInput.inputView = picker
        case "Home work":
            fieldInput.inputView = pickerHW
        default:
            fieldInput.inputView = nil
            fieldInput.inputAccessoryView = nil
        }
        alert.textFields?.last?.inputAccessoryView = picker.showToolBar()
    }

    static func showBasicAlert(viewController: UIViewController) {
        currentView = viewController
        openPicker()
        alert.textFields?.first?.placeholder = selectPlaceholder().first
        alert.textFields?.last?.placeholder = selectPlaceholder().last
        DispatchQueue.main.async { viewController.present(alert, animated: true) }
    }

    private static func selectPlaceholder() -> [String] {
        switch currentView?.title {
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

    static private func clearFields() {
        alert.textFields?.forEach({ field in field.text = "" })
    }

    static func dismiss() {
        alert.textFields?.last?.endEditing(true)
    }

    static func passItem(item: String) {
        alert.textFields?.last?.text = item
    }
}
