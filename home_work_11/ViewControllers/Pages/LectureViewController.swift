//
//  LectureViewController.swift
//  home_work_11
//
//  Created by Pavel Bondar on 03.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UITableViewController
import CoreData.NSFetchRequest

class LectureViewController: UITableViewController {
    private let reuseIdentifier = "cell"
    private let context = CoreDataStack.shared.persistentContainer.viewContext
    // MARK: - NSFetchedResultsController
    private lazy var fetchedResultControllerDelegate = FetchedResultControllerDelegate(tableView: tableView)
    private lazy var fetchedResultController: NSFetchedResultsController<Lectures> = {
        let fetchRequest: NSFetchRequest<Lectures> = Lectures.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "theme", ascending: true)]
        let controller = NSFetchedResultsController<Lectures>(fetchRequest: fetchRequest,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        try? controller.performFetch()
        controller.delegate = fetchedResultControllerDelegate
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lecture"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    // MARK: - UITableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections![section].numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        let lecture = fetchedResultController.object(at: indexPath)
        cell.textLabel?.text = lecture.theme
        cell.detailTextLabel?.text = lecture.theme
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        context.delete(fetchedResultController.object(at: indexPath))
        try? context.save()
    }
}
