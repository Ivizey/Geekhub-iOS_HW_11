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
    private let reuseIdentifier = "cell"
    private let context = CoreDataStack.shared.persistentContainer.viewContext
    // MARK: - NSFetchedResultsController
    private lazy var fetchedResultControllerDelegate = FetchedResultControllerDelegate(tableView: tableView)
    private lazy var fetchedResultController: NSFetchedResultsController<Marks> = {
        let fetchRequest: NSFetchRequest<Marks> = Marks.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "mark", ascending: true)]
        let controller = NSFetchedResultsController<Marks>(fetchRequest: fetchRequest,
                                                           managedObjectContext: context,
                                                           sectionNameKeyPath: nil,
                                                           cacheName: nil)
        try? controller.performFetch()
        controller.delegate = fetchedResultControllerDelegate
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        let buttonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddAlert))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.navigationItem.rightBarButtonItem = buttonItem
        self.title = "Mark"
        view.backgroundColor = .white
    }

    private func insertItem(_ mark: String, _ homework: String, _ clarification: String) {
        let marks = Marks(context: context)
        marks.clarification = clarification
        marks.homework = homework
        marks.mark = mark
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    @objc private func handleAddAlert() {
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections![section].numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        let marks = fetchedResultController.object(at: indexPath)
        cell.textLabel?.text = String(indexPath.row)
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
