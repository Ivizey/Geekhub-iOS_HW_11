//
//  Alert.swift
//  home_work_11
//
//  Created by Pavel Bondar on 10.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit
import CoreData.NSFetchRequest

struct Alert {
    private static let alert: UIAlertController = {
        let alert = UIAlertController(title: "Add new", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        return alert
    }()

    static func showBasicAlert(viewController: UIViewController, view: String) {
        let picker = PickerView()
        let placeholders = selectPlaceholder(view: view)
        alert.textFields?[0].placeholder = placeholders[0]
        alert.textFields?[1].placeholder = placeholders[1]
        alert.textFields?[1].inputView = picker.createPicker()
        DispatchQueue.main.async { viewController.present(alert, animated: true) }
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
