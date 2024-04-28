//
//  Message.swift
//  task_management_tool
//
//  Created by i564407 on 4/28/24.
//

import Foundation
struct Message: Identifiable {
    let id: UUID
    let content: String
    let isFromUser: Bool
    // 其他消息相关字段，如消息类型(文本、图片等)、已读状态等
}
