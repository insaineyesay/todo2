//
//  TodoListItemModel.swift
//  Todoey
//
//  Created by Michael Agee on 2/9/19.
//  Copyright © 2019 Ajira LLC. All rights reserved.
//

import Foundation

class TodoListItem {
    var title: String = ""
    var isChecked: Bool = false
    
    init(userTitle: String) {
        title = userTitle
    }
}
