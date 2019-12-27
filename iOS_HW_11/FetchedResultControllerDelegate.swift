//
//  FetchedResultControllerDelegate.swift
//  iOS_HW_11
//
//  Created by Pavel Bondar on 27.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//
import UIKit
import CoreData

final class FetchedResultControllerDelegate: NSObject, NSFetchedResultsControllerDelegate {
    
    weak var tableView: UITableView?
    
    convenience init(tableView: UITableView) {
        self.init()
        self.tableView = tableView
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView?.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        switch type {
        case .insert:
            tableView?.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView?.deleteRows(at: [indexPath], with: .fade)
        case .update:
            tableView?.reloadRows(at: [indexPath], with: .fade)
        case .move:
            tableView?.reloadRows(at: [indexPath], with: .fade)
            tableView?.moveRow(at: indexPath, to: newIndexPath!)
        default:
            return
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView?.endUpdates()
    }
}
