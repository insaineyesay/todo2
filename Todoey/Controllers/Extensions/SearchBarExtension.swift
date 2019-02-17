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

//        NSPredicate(format: "(parentCategory.name MATCHES %@) AND (title CONTAINS[cd] %@)", selectedTodoList!.name!, searchText)
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        getStoredList(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            getStoredList()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}
