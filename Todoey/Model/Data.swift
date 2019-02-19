//
//  Data.swift
//  Todoey
//
//  Created by Michael Agee on 2/16/19.
//  Copyright © 2019 Ajira LLC. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var isChecked: Bool = false
}
