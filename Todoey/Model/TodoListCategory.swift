//
//  Category.swift
//  Todoey
//
//  Created by Michael Agee on 2/17/19.
//  Copyright © 2019 Ajira LLC. All rights reserved.
//

import Foundation
import RealmSwift

class TodoListCategory: Object {
    @objc dynamic var name: String = ""
    let items = List<TodoListItem>()
}
