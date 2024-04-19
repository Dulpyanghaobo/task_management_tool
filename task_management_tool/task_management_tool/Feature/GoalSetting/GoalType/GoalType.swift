//
//  GoalType.swift
//  task_management_tool
//
//  Created by i564407 on 4/3/24.
//

import Foundation

enum GoalType: String, CaseIterable {
    case health = "健康"
    case cognition = "认知"
    case asset = "资产"
    case character = "品格"
    case ability = "能力"

    // 每个case关联的常见目标
    var commonGoals: [String] {
        switch self {
        case .health:
            return ["Weight Loss", "Muscle Gain", "Improved Endurance", "Better Sleep"]
        case .cognition:
            return ["Enhance Memory", "Improve Focus", "Learn a New Skill", "Read More Books"]
        case .asset:
            return ["Increase Savings", "Invest in Stocks", "Buy Real Estate", "Reduce Debts"]
        case .character:
            return ["Be More Empathetic", "Improve Patience", "Enhance Communication Skills", "Practice Gratitude"]
        case .ability:
            return ["Learn a New Language", "Master a Musical Instrument", "Improve Public Speaking", "Develop Coding Skills"]
        }
    }
}

