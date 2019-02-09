//
//  ViewController.swift
//  Todoey
//
//  Created by Michael Agee on 2/3/19.
//  Copyright © 2019 Ajira LLC. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = [TodoListItem]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let item1 = TodoListItem(userTitle: "Help the kids with their project")
        itemArray.append(item1)
        getStoredList()
    }
    
    func getStoredList() {
        if let items = defaults.value(forKey: "TodoListArray") as? [TodoListItem] {
            itemArray = items
        }
    }
    
    //MARK: - Tableview DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        let item = itemArray[indexPath.row]
        let cellItem = tableView.cellForRow(at: indexPath)
        item.isChecked = !item.isChecked

        cellItem?.accessoryType = item.isChecked ? .checkmark : .none
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        var newItemText = UITextField()
        
        let alert = UIAlertController(title: "Add a new Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what's going to happen when the add button is pressed
            print("Success")
            let newTodoItem = TodoListItem(userTitle: newItemText.text!)
            self.itemArray.append(newTodoItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder  = "Create new item"
            newItemText = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

