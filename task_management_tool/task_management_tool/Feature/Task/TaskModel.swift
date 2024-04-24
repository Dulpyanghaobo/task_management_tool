//
//  TaskModel.swift
//  task_management_tool
//
//  Created by i564407 on 11/16/23.
//

import Foundation

// 定义任务分类的枚举
enum TaskCategory: String, CaseIterable {
    case study = "学习"
    case work = "工作"
    case life = "生活"
    case technology = "技术"
    case thinking = "思考"
}

// 定义任务模式的枚举
enum TaskMode: String, CaseIterable {
    case permanent = "常驻任务"
    case repetitive = "重复性任务"
    case once = "一次性任务"
}

// 定义任务状态的枚举
enum TaskStatus: String, CaseIterable {
    case all = "All"
    case created = "To do"
    case inProgress = "In progress"
    case isBlock = "Blocked"
    case waiting = "Waiting"
    case completed = "Completed"
    case Settlement = "Settlement"
    // 这里可以根据需要添加更多状态
}
// 定义任务模型
struct Task {
    let id: UUID                 // 唯一标识符
    var title: String            // 任务标题
    var category: TaskCategory   // 任务分类
    var mode: TaskMode           // 任务模式
    var tags: [String]           // 任务标签
    var difficulty: Int          // 任务难度，可以是1到5之间的值
    var urgency: Int             // 紧急程度，可以是1到5之间的值
    var status: TaskStatus       // 任务状态
    var createAt: Date           // 任务创建时间
    var updateAt: Date           // 任务最后修改时间
    var deadline: Date?          // 截止时间
    var importance: Int          // 重要程度，可以是1到5之间的值
    // 计算属性：动态计算任务优先级
    var priority: Int {
        // 计算逻辑可以根据实际需求定制
        // 示例：使用简单的算法基于紧急程度、重要程度和时间因素计算优先级
        let urgencyFactor = urgency
        let importanceFactor = importance
        let difficultyFactor = Double(difficulty) * 0.3
        let timeFactor = deadline != nil ? min(daysTillDeadline(), 5) : 5 // 以天数计，最多5天，无截止日期则默认为5
        let totalFactor = Double(urgencyFactor + importanceFactor + timeFactor)
        
        // 最后计算优先级
        
        let priorityFactor = (totalFactor - difficultyFactor) / 4.0
        return Int(priorityFactor.rounded())
    }
    
    // 辅助函数：计算距离截止日期的天数
    private func daysTillDeadline() -> Int {
        guard let deadline = deadline else { return 0 }
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let endOfDay = calendar.startOfDay(for: deadline)
        let components = calendar.dateComponents([.day], from: startOfDay, to: endOfDay)
        return components.day ?? 0
    }

    // 你可以根据需要添加更多的属性，如创建时间、截止日期等
}

// 确保Task符合Codable协议，以便进行JSON编码
extension Task: Identifiable, Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case category
        case mode
        case tags
        case difficulty
        case urgency
        case importance
        case status
        case createAt
        case updateAt
        case deadline
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(category.rawValue, forKey: .category)
        try container.encode(mode.rawValue, forKey: .mode)
        try container.encode(tags, forKey: .tags)
        try container.encode(difficulty, forKey: .difficulty)
        try container.encode(urgency, forKey: .urgency)
        try container.encode(importance, forKey: .importance)
        try container.encode(status.rawValue, forKey: .status)
        try container.encode(createAt, forKey: .createAt)
        try container.encode(updateAt, forKey: .updateAt)
        try container.encodeIfPresent(deadline, forKey: .deadline)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        let categoryString = try container.decode(String.self, forKey: .category)
        category = TaskCategory(rawValue: categoryString) ?? .study
        let modeString = try container.decode(String.self, forKey: .mode)
        mode = TaskMode(rawValue: modeString) ?? .once
        tags = try container.decode([String].self, forKey: .tags)
        difficulty = try container.decode(Int.self, forKey: .difficulty)
        urgency = try container.decode(Int.self, forKey: .urgency)
        importance = try container.decode(Int.self, forKey: .importance)
        let statusString = try container.decode(String.self, forKey: .status)
        status = TaskStatus(rawValue: statusString) ?? .created
        createAt = try container.decode(Date.self, forKey: .createAt)
        updateAt = try container.decode(Date.self, forKey: .updateAt)
        deadline = try container.decodeIfPresent(Date.self, forKey: .deadline)
    }
}

