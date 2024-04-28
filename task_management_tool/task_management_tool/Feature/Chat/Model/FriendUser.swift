//
//  FriendUser.swift
//  task_management_tool
//
//  Created by i564407 on 4/28/24.
//

import Foundation

struct Friend: Identifiable {
    let id: Int
    let name: String
    let description: String
    let avatar: String
    let isOnline: Bool
    let lastChatTime: String
    let unreadCount: Int
}
