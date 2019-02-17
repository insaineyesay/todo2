//
//  ViewController.swift
//  Todoey
//
//  Created by Michael Agee on 2/3/19.
//  Copyright © 2019 Ajira LLC. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    var itemArray = [TodoListItem]()
    var selectedTodoList : TodoListCategory? {
        didSet{
            getStoredList()
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // Do any additional setup after loading the view, typically from a nib.
//        getStoredList()
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
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isChecked ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemArray[indexPath.row]
        
        item.isChecked = !item.isChecked
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        var newItemText = UITextField()
        
        let alert = UIAlertController(title: "Add a new Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what's going to happen when the add button is pressed
            
            let newTodoItem = TodoListItem(context: self.context)
            newTodoItem.title = newItemText.text!
            newTodoItem.isChecked = false
            newTodoItem.parentCategory = self.selectedTodoList
            self.itemArray.append(newTodoItem)
            
            self.saveItems()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder  = "Create new item"
            newItemText = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Data Manipulation
    
    func saveItems() {
        
        do {
            try self.context.save()
        } catch {
            // something will go here to catch errors
            print("**ERROR SAVING CONTEXT**, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func getStoredList(with request: NSFetchRequest<TodoListItem> = TodoListItem.fetchRequest()) {
        // Always supply the entity for the fetch request
        if request.predicate != nil {
            let searchPredicate = request.predicate
            let parentCategoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedTodoList!.name!)
            let compoundPredicate = NSCompoundPredicate(
                type: .and,
                subpredicates: [parentCategoryPredicate, searchPredicate!]
            )
            
            request.predicate = compoundPredicate
            
        } else {
            let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedTodoList!.name!)
            request.predicate = predicate
        }
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("ERROR DURING FETCH REQUEST FROM CONTEXT, \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    
}
