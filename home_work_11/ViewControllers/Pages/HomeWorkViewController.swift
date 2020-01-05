//
//  HomeWorkViewController.swift
//  home_work_11
//
//  Created by Pavel Bondar on 04.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UITableViewController
import CoreData.NSFetchRequest

class HomeWorkViewController: UITableViewController {
    private let reuseIdentifier = "cell"
    private let context = CoreDataStack.shared.persistentContainer.viewContext
    // MARK: - NSFetchedResultsController
    private lazy var fetchedResultControllerDelegate = FetchedResultControllerDelegate(tableView: tableView)
    private lazy var fetchedResultController: NSFetchedResultsController<HomeWorks> = {
        let fetchRequest: NSFetchRequest<HomeWorks> = HomeWorks.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "task", ascending: true)]
        let controller = NSFetchedResultsController<HomeWorks>(fetchRequest: fetchRequest,
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
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        let homeWorks = fetchedResultController.object(at: indexPath)
        cell.textLabel?.text = homeWorks.task
        cell.detailTextLabel?.text = homeWorks.task
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        context.delete(fetchedResultController.object(at: indexPath))
        try? context.save()
    }
}
