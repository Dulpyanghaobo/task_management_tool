//
//  MileStone.swift
//  task_management_tool
//
//  Created by i564407 on 4/3/24.
//

import Foundation

struct Milestone: Identifiable {
    let id: UUID = UUID()
    var title: String = ""
    // You can add more details here, like targetDate, progress, etc.
}
