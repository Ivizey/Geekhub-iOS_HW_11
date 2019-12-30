//
//  HomeworksViewController.swift
//  iOS_HW_11
//
//  Created by Pavel Bondar on 27.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit
import CoreData

class HomeworksViewController: UIViewController {
    @IBOutlet private weak var homeWorkTable: UITableView!
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private lazy var fetchedResultControllerDelegate = FetchedResultControllerDelegate(tableView: homeWorkTable)
    private lazy var fetchedResultController: NSFetchedResultsController<Homework> = {
        let fetchRequest: NSFetchRequest<Homework> = Homework.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "task", ascending: true)]
        let controller = NSFetchedResultsController<Homework>(fetchRequest: fetchRequest,
                                                             managedObjectContext: context,
                                                             sectionNameKeyPath: nil,
                                                             cacheName: nil)
        try? controller.performFetch()
        controller.delegate = fetchedResultControllerDelegate
        return controller
    }()
    
    @IBAction private func addHomeWorkButtonAction(_ sender: UIBarButtonItem) {
        createAlert()
    }
    
    private func insertItem(name: String) {
        let homework = Homework(context: context)
        homework.task = name
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
            textField.placeholder = "Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Surename"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            if let name = alert.textFields?.first?.text {
                self.insertItem(name: name)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource
extension HomeworksViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultController.sections!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchedResultController.sections![section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeWorkCell", for: indexPath)
        let homework = fetchedResultController.object(at: indexPath)
        cell.textLabel?.text = homework.task
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        context.delete(fetchedResultController.object(at: indexPath))
        try? context.save()
    }
}
