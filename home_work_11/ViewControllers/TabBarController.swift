//
//  ViewController.swift
//  home_work_11
//
//  Created by Pavel Bondar on 03.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit
import CoreData

class TabBarController: UITabBarController {

    private let nameView = ["Lecture", "Lector", "Student", "Home work"]
    private let context = CoreDataStack.shared.persistentContainer.viewContext

    private let toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        toolBar.setItems([doneButton], animated: true)
        return toolBar
    }()

    private let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .white
        return picker
    }()

    private let alertDialog: UIAlertController = {
        let alert = UIAlertController(title: "Add new", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Theme"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Select lector"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        return alert
    }()

    private let fetchRequest: NSFetchRequest<Lectors> = {
        var fetchRequest: NSFetchRequest<Lectors> = Lectors.fetchRequest()
        return fetchRequest
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        showTabs()
        setupView()
        alertDialog.textFields![1].inputAccessoryView = toolBar
        alertDialog.textFields![1].inputView = picker
        alertDialog.addAction(UIAlertAction(title: "Add",
                                            style: .default,
                                            handler: { _ in
            let theme = self.alertDialog.textFields![0].text!
            let name = self.alertDialog.textFields![1].text!
            self.insertItem(theme, name)
        }))
        picker.delegate = self
    }

    private func insertItem(_ theme: String, _ lector: String) {
        let lecture = Lectures(context: context)
        lecture.theme = theme
        lecture.lector = lector
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    private func createTab(_ view: UIViewController, _ image: String, _ tag: Int) -> UIViewController {
        let viewController = view
        let image = UIImage(systemName: image)
        viewController.tabBarItem = UITabBarItem(title: nameView[tag], image: image, tag: tag)
        return viewController
    }

    private func showTabs() {
        viewControllers = [createTab(LectureViewController(), "doc", 0),
                           createTab(LectorViewController(), "person", 1),
                           createTab(StudentViewController(), "person.2", 2),
                           createTab(HomeWorkViewController(), "book", 3)
        ]
    }

    private func setupView() {
        let buttonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddAlert))
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = buttonItem
        view.backgroundColor = .white
    }

    @objc private func handleAddAlert() {
        present(alertDialog, animated: true, completion: nil)
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension TabBarController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let lectors = try? context.fetch(fetchRequest)
        return lectors?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let lectors = try? context.fetch(fetchRequest)
        return lectors?[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let lectors = try? context.fetch(fetchRequest)
        alertDialog.textFields![1].text = lectors?[row].name
    }
}
