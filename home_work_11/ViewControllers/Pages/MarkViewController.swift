//
//  MarkViewController.swift
//  home_work_11
//
//  Created by Pavel Bondar on 08.01.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UITableViewController
import CoreData.NSFetchRequest

class MarkViewController: UITableViewController {
    var students: Students?
    private let reuseIdentifier = "cell"
    private let context = CoreDataStack.shared.persistentContainer.viewContext
    // MARK: - NSFetchedResultsController
    private lazy var fetchedResultControllerDelegate = FetchedResultControllerDelegate(tableView: tableView)
    private lazy var fetchedResultController: NSFetchedResultsController<Marks> = {
        let fetchRequest: NSFetchRequest<Marks> = Marks.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "mark", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "students == %@", self.students!)
        let controller = NSFetchedResultsController<Marks>(fetchRequest: fetchRequest,
                                                           managedObjectContext: context,
                                                           sectionNameKeyPath: nil,
                                                           cacheName: nil)
        try? controller.performFetch()
        controller.delegate = fetchedResultControllerDelegate
        return controller
    }()

    private func setupView() {
        let buttonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddAlert))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.navigationItem.rightBarButtonItem = buttonItem
        self.title = "Mark"
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @objc private func handleAddAlert() {
        AlertMarkViewController.showBasicAlert(viewController: self, student: students!)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections![section].numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        let marks = fetchedResultController.object(at: indexPath)
        cell.textLabel?.text = marks.mark
        cell.detailTextLabel?.text = marks.homework
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        context.delete(fetchedResultController.object(at: indexPath))
        try? context.save()
    }
}
