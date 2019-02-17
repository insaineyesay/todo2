//
//  Item.swift
//  Todoey
//
//  Created by Michael Agee on 2/17/19.
//  Copyright © 2019 Ajira LLC. All rights reserved.
//

import Foundation
import RealmSwift

class TodoListItem: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var isChecked: Bool = false
    var parentCategory = LinkingObjects(fromType: TodoListCategory.self, property: "items")
}
