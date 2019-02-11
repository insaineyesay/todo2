//
//  SearchBarExtension.swift
//  Todoey
//
//  Created by Michael Agee on 2/10/19.
//  Copyright © 2019 Ajira LLC. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<TodoListItem> = TodoListItem.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("ERROR DURING FETCH REQUEST FROM CONTEXT, \(error)")
        }
        
        tableView.reloadData()
    }
}
