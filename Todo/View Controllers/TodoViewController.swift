//
//  ViewController.swift
//  Todo
//
//  Created by mani on 2020-04-27.
//  Copyright © 2020 mani. All rights reserved.
//

import UIKit
import CoreData

class TodoViewController: UIViewController, NoContentBackgroundView {
    private let reuseIdentifier = "TodoItemCell"

    @IBOutlet weak var tableView: UITableView!
    let dataManager = CoreDataManager(modelName: "ToDo")
    lazy var managedObjectContext: NSManagedObjectContext = {
        return self.dataManager.managedObjectContext
    }()
    lazy var fetchedResultsController: NSFetchedResultsController<Item> = {
        let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: self.managedObjectContext,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    lazy var backgroundView: DTTableBackgroundView = {
        let backgroundView = DTTableBackgroundView(frame: self.view.frame)
        backgroundView.messageLabel.text = "Please add a todo"
        backgroundView.buttonTitle = "Add Todo"
        backgroundView.handler = {
            self.performSegue(withIdentifier: "showAddTodo", sender: nil)
        }
        return backgroundView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundView = backgroundView
        hideBackgroundView()
    }

}

extension TodoViewController {
    @objc func save() {
        dataManager.saveContext()
    }

    private func fetchItems() {
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            print("Failed to fetch items: \(error)")
        }
    }
}

extension TodoViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch (type) {
            case .insert:
                if let indexPath = newIndexPath {
                    tableView.insertRows(at: [indexPath], with: .fade)
            }
            case .delete:
                if let indexPath = indexPath {
                    tableView.deleteRows(at: [indexPath], with: .fade)
            }
            default:
                break
        }
    }
}
