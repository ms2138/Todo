//
//  ViewController.swift
//  Todo
//
//  Created by mani on 2020-04-27.
//  Copyright © 2020 mani. All rights reserved.
//

import UIKit
import CoreData

class TodoViewController: UIViewController {
    private let reuseIdentifier = "TodoItemCell"

    @IBOutlet weak var tableView: UITableView!
    let dataManager = CoreDataManager(modelName: "ToDo")
    lazy var managedObjectContext: NSManagedObjectContext = {
        return self.dataManager.managedObjectContext
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

