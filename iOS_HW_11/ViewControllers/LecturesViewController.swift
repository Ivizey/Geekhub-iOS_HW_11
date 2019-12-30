//
//  ViewController.swift
//  iOS_HW_11
//
//  Created by Pavel Bondar on 27.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit
import CoreData

class LecturesViewController: UIViewController {
    @IBOutlet private weak var lecturesTable: UITableView!
    private lazy var fetchedResultControllerDelegate = FetchedResultControllerDelegate(tableView: lecturesTable)
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private lazy var fetchedResultController: NSFetchedResultsController<Lecture> = {
        let fetchRequest: NSFetchRequest<Lecture> = Lecture.fetchRequest()
        fetchRequest.sortDescriptors = []
        
        let controller = NSFetchedResultsController<Lecture>(fetchRequest: fetchRequest,
                                                             managedObjectContext: context,
                                                             sectionNameKeyPath: nil,
                                                             cacheName: nil)
        try? controller.performFetch()
        controller.delegate = fetchedResultControllerDelegate
        return controller
    }()

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

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }

    @IBAction private func addLecturesButtonAction(_ sender: UIBarButtonItem) {
        createAlert()
    }

    private func insertItem(_ theme: String) {
        let lecture = Lecture(context: context)
        lecture.theme = theme
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
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
}

//MARK: - UITableViewDataSource
extension LecturesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultController.sections!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchedResultController.sections![section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lecturesCell", for: indexPath)
        let lecture = fetchedResultController.object(at: indexPath)
        cell.textLabel?.text = lecture.theme
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        context.delete(fetchedResultController.object(at: indexPath))
        try? context.save()
    }
}

//MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension LecturesViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "''"
    }
}
