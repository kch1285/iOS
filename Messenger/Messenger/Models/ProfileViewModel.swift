//
//  ProfileViewModel.swift
//  Messenger
//
//  Created by chihoooon on 2021/07/31.
//

import Foundation

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}

enum ProfileViewModelType {
    case info, logout
}
