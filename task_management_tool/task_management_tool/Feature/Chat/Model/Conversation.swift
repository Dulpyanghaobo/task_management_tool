//
//  Conversation.swift
//  task_management_tool
//
//  Created by i564407 on 4/28/24.
//

import Foundation

struct Conversation {
    let id: String
    let participantIds: [String]
    let latestMessage: Message
    let unreadCount: Int
    // 会话的其他元数据，如会话名称、群聊头像等
}
