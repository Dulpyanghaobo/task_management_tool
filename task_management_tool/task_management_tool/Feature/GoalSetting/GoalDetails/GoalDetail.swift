//
//  GoalDetail.swift
//  task_management_tool
//
//  Created by i564407 on 4/3/24.
//

import Foundation

struct GoalDetail: Identifiable {
    let id = UUID()
    var goal: String = ""
    var milestones: [Milestone] = []
    var deadline: Date = Date()
    var measurement: String = ""
    var description: String = ""
    var implementationDifficulty: Difficulty = .medium
    var goalType: GoalType = .health
}


enum Difficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}
