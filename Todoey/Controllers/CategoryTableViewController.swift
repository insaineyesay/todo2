//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Michael Agee on 2/11/19.
//  Copyright © 2019 Ajira LLC. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: SwipeTableViewController  {

    let realm = try! Realm()
    var todoListCategoryArray: Results<TodoListCategory>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategoryLists()
        tableView.rowHeight = 80
    }

 

    @IBAction func addCategoryButtonPressed(_ sender: UIBarButtonItem) {
        var newItemTextField = UITextField()
        
        let alert = UIAlertController(title: "Add a List", message: "Dude, get a move on...", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add something", style: .default) { (action) in
            let newTodoList = TodoListCategory()
            newTodoList.name = newItemTextField.text!
            
            self.save(todoListCategory: newTodoList)
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder  = "Create new item"
            newItemTextField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListCategoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = todoListCategoryArray?[indexPath.row].name ?? "No Caetgories yet available"
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = todoListCategoryArray[indexPath.row]
        performSegue(withIdentifier: "goToList", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedTodoList = todoListCategoryArray?[indexPath.row]
        }
    }

    //MARK: - Data Manipulation methods
    
    func getCategoryLists() {
        todoListCategoryArray = realm.objects(TodoListCategory.self)
        tableView.reloadData()
    }
    
    
    func save(todoListCategory: TodoListCategory) {
        do {
            try realm.write {
                realm.add(todoListCategory)
            }
        } catch {
           print("***ERROR SAVING CONTEXT!!***, \(error)")
        }
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let todoCategoryToBeDeleted = self.todoListCategoryArray?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(todoCategoryToBeDeleted)
                }
            } catch {
                print("***ERROR DURING ITEM DELETE***, \(error)")
            }
        }
    }
    
}
