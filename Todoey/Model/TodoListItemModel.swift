//
//  TodoListItemModel.swift
//  Todoey
//
//  Created by Michael Agee on 2/9/19.
//  Copyright © 2019 Ajira LLC. All rights reserved.
//

import Foundation
import CoreData

class TodoListItem: Codable {
    var title: String = ""
    var isChecked: Bool = false
    
    init(userTitle: String) {
        title = userTitle
    }
}
