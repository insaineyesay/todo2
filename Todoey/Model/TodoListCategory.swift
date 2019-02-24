//
//  Category.swift
//  Todoey
//
//  Created by Michael Agee on 2/17/19.
//  Copyright © 2019 Ajira LLC. All rights reserved.
//

import Foundation
import RealmSwift
import Chameleon

class TodoListCategory: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var categoryBgColor: String = UIColor.randomFlat().hexValue()
    let items = List<TodoListItem>()
    
}
