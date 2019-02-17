//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Michael Agee on 2/11/19.
//  Copyright © 2019 Ajira LLC. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var todoListCategoryArray = [TodoListCategory]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategoryLists()
    }

 

    @IBAction func addCategoryButtonPressed(_ sender: UIBarButtonItem) {
        var newItemTextField = UITextField()
        
        let alert = UIAlertController(title: "Add a List", message: "Dude, get a move on...", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add something", style: .default) { (action) in
            let newTodoList = TodoListCategory(context: self.context)
            newTodoList.name = newItemTextField.text!
            self.todoListCategoryArray.append(newTodoList)
            
            self.saveTodoLists()
            
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
        return todoListCategoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let item = todoListCategoryArray[indexPath.row]
        cell.textLabel?.text = item.name
        
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
            destinationVC.selectedTodoList = todoListCategoryArray[indexPath.row]
        }
    }

    //MARK: - Data Manipulation methods
    
    func getCategoryLists(request: NSFetchRequest<TodoListCategory> = TodoListCategory.fetchRequest()) {
        do {
            todoListCategoryArray = try context.fetch(request)
        } catch {
            print("***ERROR FETCHING THE CATEGORY LIST!!***, \(error)")
        }
    }
    
    
    func saveTodoLists() {
        do {
            try self.context.save()
        } catch {
           print("***ERROR SAVING CONTEXT!!***, \(error)")
        }
        tableView.reloadData()
    }
    
    
    
}
