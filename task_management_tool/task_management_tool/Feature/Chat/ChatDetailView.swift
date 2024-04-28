//
//  ChatDetailView.swift
//  task_management_tool
//
//  Created by i564407 on 4/28/24.
//

import SwiftUI

struct ChatDetailView: View {
    let friend: Friend
    @State private var messageText = ""
    @State private var messages: [Message] = [
        Message(id: UUID(), content: "嗨,最近怎么样?我刚完成了一个新的iOS项目,你有时间的话可以看看哦", isFromUser: false),
        Message(id: UUID(), content: "听起来不错,我最近也在学习SwiftUI,过几天准备做个小Demo", isFromUser: true),
        Message(id: UUID(), content: "那太好了!有什么问题随时问我,保持联系", isFromUser: false),
        Message(id: UUID(), content: "好的,一定!对了,周末有个技术分享会,你去吗?", isFromUser: true),
        Message(id: UUID(), content: "当然,到时候现场见", isFromUser: false),
        Message(id: UUID(), content: "OK,到时见!", isFromUser: true),
    ]

    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(messages) { message in
                            MessageView(message: message, friend: friend)
                        }
                    }
                } .onChange(of: messages.count) { _ in
                    scrollToBottom(proxy: proxy)
                }
            }
            HStack {
                Button(action: {
                    // 处理"+"按钮点击事件,展示更多功能
                }) {
                    Image(systemName: "plus")
                }
                
                TextField("Enter message", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    sendMessage()
                }) {
                    Text("Send")
                }
            }
            .padding()
        }
        .navigationBarTitle(friend.name)
        .navigationBarItems(trailing: Menu {
            Button("修改昵称", action: editNickname)
            Button("删除聊天记录", action: deleteFriend)
            Button("拉黑好友", action: deleteFriend)
            Button("删除好友", action: deleteFriend)

        } label: {
            Image(systemName: "ellipsis")
        })
    }
    
    private func sendMessage() {
        let message = Message(id: UUID(), content: messageText, isFromUser: true)
        messages.append(message)
        messageText = ""
    }
    
    private func editNickname() {
        // 处理修改昵称的逻辑
    }
    
    private func deleteFriend() {
        // 处理删除好友的逻辑
    }
    
    private func scrollToBottom(proxy: ScrollViewProxy) {
        guard let lastMessage = messages.last else { return }
        proxy.scrollTo(lastMessage.id, anchor: .bottom)
    }
}

struct MessageView: View {
    let message: Message
    
    let friend: Friend

    
    var body: some View {
        HStack {
            if message.isFromUser {
                Spacer()
                Text(message.content)
                    .font(.system(size: 14, weight: .regular))
                    .padding(.leading, 8).padding(.trailing, 16).padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(ChatBubble(isFromUser: true))
                Image(friend.avatar)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            } else {
                Image(friend.avatar)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text(message.content)
                    .font(.system(size: 14, weight: .regular))
                    .padding(.leading, 16).padding(.trailing, 8).padding(.vertical, 8)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .clipShape(ChatBubble(isFromUser: false))
                
                Spacer()
            }
        }.padding(.horizontal, 16)
    }
}
struct ChatBubble: Shape {
    let isFromUser: Bool
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let cornerRadius: CGFloat = 8
        let arrowSize: CGFloat = 10
        let arrowPosition = height / 2
        
        let path = Path { p in
            if isFromUser {
                p.move(to: CGPoint(x: cornerRadius, y: 0))
                p.addLine(to: CGPoint(x: width - cornerRadius - arrowSize, y: 0))
                p.addArc(center: CGPoint(x: width - cornerRadius - arrowSize, y: cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                
                p.addLine(to: CGPoint(x: width - arrowSize, y: arrowPosition - arrowSize / 2))
                p.addLine(to: CGPoint(x: width, y: arrowPosition))
                p.addLine(to: CGPoint(x: width - arrowSize, y: arrowPosition + arrowSize / 2))
                p.addArc(center: CGPoint(x: width - cornerRadius - arrowSize, y: height - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                
                p.addLine(to: CGPoint(x: cornerRadius, y: height))
                p.addArc(center: CGPoint(x: cornerRadius, y: height - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                p.addLine(to: CGPoint(x: 0, y: cornerRadius))
                p.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            } else {
                p.move(to: CGPoint(x: width - cornerRadius, y: 0))
                p.addLine(to: CGPoint(x: cornerRadius + arrowSize, y: 0))
                p.addArc(center: CGPoint(x: cornerRadius + arrowSize, y: cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 180), clockwise: true)
                
                p.addLine(to: CGPoint(x: arrowSize, y: arrowPosition - arrowSize / 2))
                p.addLine(to: CGPoint(x: 0, y: arrowPosition))
                p.addLine(to: CGPoint(x: arrowSize, y: arrowPosition + arrowSize / 2))
                p.addArc(center: CGPoint(x: cornerRadius + arrowSize, y: height - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 90), clockwise: true)
                
                p.addLine(to: CGPoint(x: width - cornerRadius, y: height))
                p.addArc(center: CGPoint(x: width - cornerRadius, y: height - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 0), clockwise: true)
                p.addLine(to: CGPoint(x: width, y: cornerRadius))
                p.addArc(center: CGPoint(x: width - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: -90), clockwise: true)
            }


            
            p.closeSubpath()
        }
        
        return path
    }
}
