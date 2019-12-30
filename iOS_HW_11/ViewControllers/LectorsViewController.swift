//
//  LectorsViewController.swift
//  iOS_HW_11
//
//  Created by Pavel Bondar on 27.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit
import CoreData

class LectorsViewController: UIViewController {
    @IBOutlet private weak var lectorsTable: UITableView!
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private lazy var fetchedResultControllerDelegate = FetchedResultControllerDelegate(tableView: lectorsTable)
    private lazy var fetchedResultController: NSFetchedResultsController<Lector> = {
        let fetchRequest: NSFetchRequest<Lector> = Lector.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let controller = NSFetchedResultsController<Lector>(fetchRequest: fetchRequest,
                                                             managedObjectContext: context,
                                                             sectionNameKeyPath: nil,
                                                             cacheName: nil)
        try? controller.performFetch()
        controller.delegate = fetchedResultControllerDelegate
        return controller
    }()
    
    @IBAction private func addStudentButtonAction(_ sender: UIBarButtonItem) {
        createAlert()
    }
    
    private func insertItem(name: String, surname: String) {
        let lector = Lector(context: context)
        lector.name = name
        lector.surname = surname
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
            self.insertItem(name: alert.textFields![0].text!, surname: alert.textFields![1].text!)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource
extension LectorsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultController.sections!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections![section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lectorsCell", for: indexPath)
        let lector = fetchedResultController.object(at: indexPath)
        cell.textLabel?.text = lector.name! + " " + lector.surname!
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        context.delete(fetchedResultController.object(at: indexPath))
        try? context.save()
    }
}
