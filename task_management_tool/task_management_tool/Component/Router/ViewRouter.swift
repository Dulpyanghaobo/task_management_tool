//
//  ViewRouter.swift
//  task_management_tool
//
//  Created by i564407 on 4/19/24.
//

import SwiftUI

class ViewRouter: ObservableObject {
    @Published var currentPage: String

    init(startPage: String) {
        self.currentPage = startPage
    }
}
