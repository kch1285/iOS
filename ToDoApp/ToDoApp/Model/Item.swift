//
//  Item.swift
//  ToDoApp
//
//  Created by chihoooon on 2021/12/28.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var checked: Bool = false
    @objc dynamic var dateCreated: Date?
    var category = LinkingObjects(fromType: Category.self, property: "items")
}
