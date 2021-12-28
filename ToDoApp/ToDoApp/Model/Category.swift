//
//  Category.swift
//  ToDoApp
//
//  Created by chihoooon on 2021/12/28.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
