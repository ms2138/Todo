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
    let dataManager = CoreDataManager(modelName: "Todo")
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

        title = "Todo"

        fetchItems()

        tableView.backgroundView = backgroundView
        hideBackgroundView()
    }

}

extension TodoViewController {
    // MARK: Core Data management methods

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

extension TodoViewController: UITableViewDataSource {
    // MARK: Table View data source methods

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }

        let sectionInfo = sections[section]
        if sectionInfo.numberOfObjects == 0 {
            showBackgroundView()
            return 0
        }

        hideBackgroundView()
        return sectionInfo.numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        let item = fetchedResultsController.object(at: indexPath)

        managedObjectContext.delete(item)
    }
}

extension TodoViewController: NSFetchedResultsControllerDelegate {
    // MARK: NSFetchedResultsController delegate methods

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

extension TodoViewController {
    // MARK: - Segue methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "showAddTodo":
                let navController = segue.destination as! UINavigationController
                guard let viewController = navController.topViewController else { return }
                let vc = viewController as! AddTodoViewController
                vc.managedObjectContext = self.managedObjectContext
            default:
                preconditionFailure("Segue identifier did not match")
        }
    }
}
