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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

