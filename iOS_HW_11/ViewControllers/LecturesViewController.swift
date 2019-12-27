//
//  ViewController.swift
//  iOS_HW_11
//
//  Created by Pavel Bondar on 27.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

class LecturesViewController: UIViewController {
    @IBOutlet private weak var lecturesTable: UITableView!
    @IBAction private func addLecturesButtonAction(_ sender: UIBarButtonItem) {
        createAlert()
    }
    
    private func createAlert() {
        let alert = UIAlertController(title: "Add new", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Theme"
        }
        alert.addTextField { (textField) in
            //picker view || alert
            textField.placeholder = "Select lector"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            if let name = alert.textFields?.first?.text {
                print("You name is \(name)")
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

