//
//  ToDoListModel.swift
//  ToDoApp
//
//  Created by chihoooon on 2021/12/23.
//

import Foundation

struct ToDoListModel: Codable {
    let title: String
    var checked: Bool = false
}
