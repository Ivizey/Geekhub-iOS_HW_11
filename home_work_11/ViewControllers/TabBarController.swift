//
//  ViewController.swift
//  home_work_11
//
//  Created by Pavel Bondar on 03.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UITabBarController
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

    private let fetchRequest: NSFetchRequest<Lectors> = {
        var fetchRequest: NSFetchRequest<Lectors> = Lectors.fetchRequest()
        return fetchRequest
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        createTabs()
        setupView()
        picker.delegate = self
    }

    private func createAlert() {
        let alert = UIAlertController(title: "Add new", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Theme"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Select lector"
            textField.inputView = self.picker
            textField.inputAccessoryView = self.toolBar
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            if let theme = alert.textFields?.first?.text {
                self.insertItem(theme)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func insertItem(_ theme: String) {
        let lecture = Lectures(context: context)
        lecture.theme = theme
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    private func createTabs() {
        let lectureViewController = LectureViewController()
        let imageLecture = UIImage(systemName: "doc")
        lectureViewController.tabBarItem = UITabBarItem(title: nameView[0], image: imageLecture, tag: 0)

        let lectorViewController = LectorViewController()
        let imagePerson = UIImage(systemName: "person")
        lectorViewController.tabBarItem = UITabBarItem(title: nameView[1], image: imagePerson, tag: 1)

        let studentViewController = StudentViewController()
        let imageStudent = UIImage(systemName: "person.2")
        studentViewController.tabBarItem = UITabBarItem(title: nameView[2], image: imageStudent, tag: 2)

        let homeWorkViewController = HomeWorkViewController()
        let imageHomeWork = UIImage(systemName: "book")
        homeWorkViewController.tabBarItem = UITabBarItem(title: nameView[3], image: imageHomeWork, tag: 3)

        viewControllers = [lectureViewController,
                           studentViewController,
                           homeWorkViewController,
                           lectorViewController
        ]
    }

    private func setupView() {
        let buttonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddAlert))
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = buttonItem
        view.backgroundColor = .white
    }

    @objc private func handleAddAlert() {
        createAlert()
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
}
