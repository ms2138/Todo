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

        title = "Add Todo"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupTextInputCell()

        nameCell.textField.becomeFirstResponder()
    }
}

extension AddTodoViewController {
    // MARK: - IBAction methods

    @IBAction func cancel(_ sender: UIBarButtonItem?) {
        dismiss(animated: true)
    }

    @IBAction func save(_ sender: UIBarButtonItem?) {
        guard let managedObjectContext = managedObjectContext else { return }
        guard let name = nameCell.textField.text, !name.isEmpty else {
            showAlert(title: "Error", message: "Please enter the required information")
            return
        }

        let entity = NSEntityDescription.entity(forEntityName: "Item",
                                                in: managedObjectContext)!

        let item = Item(entity: entity,
                        insertInto: managedObjectContext)

        item.name = name
        item.createdAt = Date()
        item.finished = false

        dismiss(animated: true)
    }
}

extension AddTodoViewController {
    // MARK: - View setup methods

    private func setupTextInputCell() {
        nameCell.textField.delegate = self
        nameCell.textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        nameCell.textField.autocapitalizationType = .none
        nameCell.textField.returnKeyType = .done
    }

    @objc func textDidChange(sender: UITextField) {
        saveBarButtonItem.isEnabled = !nameCell.textField.text!.isEmpty
    }
}

extension AddTodoViewController: UITextFieldDelegate {

}
