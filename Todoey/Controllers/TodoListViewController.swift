//
//  ViewController.swift
//  Todoey
//
//  Created by Michael Agee on 2/3/19.
//  Copyright © 2019 Ajira LLC. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    var todoItems: Results<TodoListItem>?
    let realm = try! Realm()
    var selectedTodoList : TodoListCategory? {
        didSet{
            getStoredList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStoredList()
    }
    
    //MARK: - Tableview DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.isChecked ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    // deleting would be something like
                    // realm.delete(item)
                    item.isChecked = !item.isChecked
                    tableView.deselectRow(at: indexPath, animated: true)
                }
            } catch {
                print("***ERROR SAVING TO 'isChecked' status to REALM***, \(error)")
            }
        }
        self.tableView.reloadData()
    }
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        var newItemText = UITextField()
        
        let alert = UIAlertController(title: "Add a new Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what's going to happen when the add button is pressed
            if let currentCategory = self.selectedTodoList {
                do {
                    try self.realm.write {
                        let newTodoItem = TodoListItem()
                        newTodoItem.title = newItemText.text!
                        currentCategory.items.append(newTodoItem)
                    }
                } catch {
                    // something will go here to catch errors
                    print("**ERROR SAVING CONTEXT**, \(error)")
                }
            }
            
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder  = "Create new item"
            newItemText = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Data Manipulation
    
    func getStoredList() {
        // Always supply the entity for the fetch request
        todoItems = selectedTodoList?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    
    
}
