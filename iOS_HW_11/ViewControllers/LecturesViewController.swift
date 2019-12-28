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
    
//    private let thePicker = UIPickerView()
//    private let toolBar = UIToolbar()
//    private let myPickerData = [String](arrayLiteral: "Peter", "Jane")

    lazy var fetchedResultControllerDelegate = FetchedResultControllerDelegate(tableView: lecturesTable)
    lazy var fetchedResultController: NSFetchedResultsController<Lecture> = {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        thePicker.delegate = self
//        thePicker.backgroundColor = .white
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.sizeToFit()
//        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)
//        toolBar.setItems([doneButton], animated: false)
    }

    @IBAction private func addLecturesButtonAction(_ sender: UIBarButtonItem) {
        insertNewObject(sender)
    }
    
    func insertNewObject(_ sender: Any) {
        let context = self.fetchedResultController.managedObjectContext
        let lecture = Lecture(context: context)
        lecture.lector = "lector"
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
//            textField.inputView = self.thePicker
//            textField.inputAccessoryView = self.toolBar
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            if let name = alert.textFields?.first?.text {
                print("You name is \(name)")
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func configureCell(_ cell: UITableViewCell, withLecture lecture: Lecture) {
        cell.textLabel!.text = "Lecture"
    }
}

extension LecturesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lecturesCell", for: indexPath)
        let lecture = fetchedResultController.object(at: indexPath)
        configureCell(cell, withLecture: lecture)
        return cell
    }
}
//extension LecturesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return myPickerData.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return myPickerData[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print(myPickerData[row])
//    }
//}
