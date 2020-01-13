//
//  StudentViewController.swift
//  home_work_11
//
//  Created by Pavel Bondar on 04.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UITableViewController
import CoreData.NSFetchRequest

class StudentViewController: UITableViewController {
    private let reuseIdentifier = "cell"
    private let context = CoreDataStack.shared.persistentContainer.viewContext
    // MARK: - NSFetchedResultsController
    private lazy var fetchedResultControllerDelegate = FetchedResultControllerDelegate(tableView: tableView)
    private lazy var fetchedResultController: NSFetchedResultsController<Students> = {
        let fetchRequest: NSFetchRequest<Students> = Students.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let controller = NSFetchedResultsController<Students>(fetchRequest: fetchRequest,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        try? controller.performFetch()
        controller.delegate = fetchedResultControllerDelegate
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    // MARK: - Table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections![section].numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let students = fetchedResultController.object(at: indexPath)
        cell.textLabel?.text = students.name! + " " + students.surname!
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        context.delete(fetchedResultController.object(at: indexPath))
        try? context.save()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let makrController = MarkViewController()
//        makrController.students = fetchedResultController.object(at: indexPath)
//        self.navigationController?.pushViewController(MarkViewController(), animated: true)
        let makrController = MarkViewController()
        makrController.students = fetchedResultController.object(at: indexPath)
        navigationController?.pushViewController(makrController, animated: true)
    }
}
