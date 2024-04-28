//
//  ChatPageView.swift
//  task_management_tool
//
//  Created by i564407 on 4/23/24.
//

import SwiftUI

struct ChatPageView: View {
    @State private var searchText = ""
    
    var body: some View {
        // 动态查看模块
        NavigationView {
                // 好友列表模块
                FriendListView(searchText: $searchText)
            .navigationBarTitle("Conversations", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    // 处理新增好友按钮点击事件
                }) {
                    Image(systemName: "person.badge.plus")
                }
            )
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search friends")
    }
}

struct FriendListView: View {
    @Binding var searchText: String
    
    var body: some View {
            List(friends.filter { $0.name.contains(searchText) || searchText.isEmpty }, id: \.id) { friend in
                NavigationLink(destination: ChatDetailView(friend: friend)) {
                    HStack(spacing: 12) {
                        // 好友头像
                        AvatarView(friend: friend)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            // 好友姓名
                            Text(friend.name)
                                .font(.headline)
                            
                            // 好友描述
                            Text(friend.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 4) {
                            // 聊天时间
                            Text(friend.lastChatTime)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            // 未读消息数
                            if friend.unreadCount > 0 {
                                Text("\(friend.unreadCount)")
                                    .font(.caption)
                                    .padding(4)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
            }.offset(y:-4).listStyle(.plain)
    }
}
struct AvatarView: View {
    let friend: Friend
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            // 好友头像图片
            Image(friend.avatar)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            // 在线状态标识
            Circle()
                .fill(friend.isOnline ? Color.green : Color.red)
                .frame(width: 12, height: 12)
                .offset(x: 2, y: -2)
        }
    }
}

    let friends = [
        Friend(id: 1, name: "张伟", description: "iOS Developer", avatar: "Welcome_Image", isOnline: true, lastChatTime: "10:30 AM", unreadCount: 2),
        Friend(id: 2, name: "李娜", description: "UI Designer", avatar: "Welcome_Image", isOnline: false, lastChatTime: "Yesterday", unreadCount: 0),
        Friend(id: 3, name: "王强", description: "Backend Engineer", avatar: "Welcome_Image", isOnline: true, lastChatTime: "12:45 PM", unreadCount: 5),
        Friend(id: 4, name: "赵红", description: "Product Manager", avatar: "Welcome_Image", isOnline: false, lastChatTime: "Monday", unreadCount: 0),
        Friend(id: 5, name: "刘军", description: "Android Developer", avatar: "Welcome_Image", isOnline: true, lastChatTime: "09:20 AM", unreadCount: 1),
        Friend(id: 6, name: "孙丽", description: "UX Researcher", avatar: "Welcome_Image", isOnline: false, lastChatTime: "Last Friday", unreadCount: 0),
        Friend(id: 7, name: "周勇", description: "QA Engineer", avatar: "Welcome_Image", isOnline: true, lastChatTime: "11:08 AM", unreadCount: 3),
        Friend(id: 8, name: "吴超", description: "Marketing", avatar: "Welcome_Image", isOnline: false, lastChatTime: "Yesterday", unreadCount: 0),
        Friend(id: 9, name: "郑艳", description: "Sales", avatar: "Welcome_Image", isOnline: true, lastChatTime: "08:41 AM", unreadCount: 1),
        Friend(id: 10, name: "王涛", description: "Operation", avatar: "Welcome_Image", isOnline: false, lastChatTime: "Wednesday", unreadCount: 0),
        Friend(id: 11, name: "冯静", description: "Secretary", avatar: "Welcome_Image", isOnline: true, lastChatTime: "09:58 AM", unreadCount: 2),
        Friend(id: 12, name: "陈明", description: "HR", avatar: "Welcome_Image", isOnline: false, lastChatTime: "Last Thursday", unreadCount: 0),
        Friend(id: 13, name: "褚磊", description: "Accountant", avatar: "Welcome_Image", isOnline: true, lastChatTime: "13:27 PM", unreadCount: 4),
        Friend(id: 14, name: "蒋艳", description: "Data Analyst", avatar: "Welcome_Image", isOnline: false, lastChatTime: "Tuesday", unreadCount: 0),
        Friend(id: 15, name: "沈刚", description: "Art Designer", avatar: "Welcome_Image", isOnline: true, lastChatTime: "14:34 PM", unreadCount: 6),
        Friend(id: 16, name: "韩芳", description: "Copywriter", avatar: "Welcome_Image", isOnline: false, lastChatTime: "Last Saturday", unreadCount: 0),
        Friend(id: 17, name: "杨鹏", description: "Growth Hacker", avatar: "Welcome_Image", isOnline: true, lastChatTime: "10:13 AM", unreadCount: 1),
        Friend(id: 18, name: "朱莉", description: "Consultant", avatar: "Welcome_Image", isOnline: false, lastChatTime: "Last Wednesday", unreadCount: 0),
        Friend(id: 19, name: "黄海", description: "Maintenance", avatar: "Welcome_Image", isOnline: true, lastChatTime: "11:46 AM", unreadCount: 3),
        Friend(id: 20, name: "龚欣", description: "Receptionist", avatar: "Welcome_Image", isOnline: false, lastChatTime: "Last Monday", unreadCount: 0),
    ]
