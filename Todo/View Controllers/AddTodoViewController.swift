//
//  AddTodoViewController.swift
//  Todo
//
//  Created by mani on 2020-05-02.
//  Copyright © 2020 mani. All rights reserved.
//

import UIKit
import CoreData

class AddTodoViewController: UITableViewController {
    @IBOutlet weak var nameCell: TextInputCell!
    var managedObjectContext: NSManagedObjectContext?
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
