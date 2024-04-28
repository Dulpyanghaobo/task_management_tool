//
//  StatusView.swift
//  task_management_tool
//
//  Created by i564407 on 4/28/24.
//

import SwiftUI

struct StatusView: View {
    
    var emotionalStatusInfo: EmotionalStatusInfo
    var userControlState: UserControlState
    var topic: [WeekStatusTopic]
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 16) {
                    StatusItemView(icon: "bolt.fill", value: Double(emotionalStatusInfo.energyLevel), description: "Energy")
                    StatusItemView(icon: "face.smiling", value: emotionalStatusInfo.emotionalState, description: "Emotional State")
                }
                HStack(spacing: 16) {
                    StatusItemView(icon: "checkmark.circle", value: emotionalStatusInfo.goalCompletionState, description: "Goal Completion")
                    StatusItemView(icon: "circle.hexagonpath", value: emotionalStatusInfo.chakraLevel, description: "Chakra Level")
                }
                Text("Status").font(.system(size: 14, weight: .semibold)).foregroundColor(AppColors.sectionTitleColor)
                StatusControlView(statusControlType: .userControl(userControlState))
                Text("WEAKEST TOPICS").font(.system(size: 14, weight: .semibold)).foregroundColor(AppColors.sectionTitleColor)
                StatusControlView(statusControlType: .weekTopic(topic))
            }.padding()
        }.offset(y: -16)
    }
    
}


struct StatusControlView: View {
    var statusControlType: StatusControlType
    
    var body: some View {
        VStack(spacing: 0) {
            switch statusControlType {
            case .userControl(let userControlState):
                StatusControlItem(
                    imageName: "fork.knife",
                    title: "Healthy Diet Control",
                    progress: userControlState.healthyDietControl,
                    progressEvaluation: "Good"
                )
                StatusControlItem(
                    imageName: "dollarsign.circle",
                    title: "Asset Control",
                    progress: userControlState.assetControl,
                    progressEvaluation: "Average"
                )
                StatusControlItem(
                    imageName: "checklist",
                    title: "Task Control",
                    progress: userControlState.taskControl,
                    progressEvaluation: "Excellent"
                )
            case .weekTopic(let weekStatusTopic):
                ForEach(weekStatusTopic) { topic in
                    StatusControlItem(
                        imageName: "book",
                        title: topic.topic,
                        progress: 0.0,
                        progressEvaluation: ""
                    )
                }
            }
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}

struct StatusControlItem: View {
    var imageName: String
    var title: String
    var progress: Double
    var progressEvaluation: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .font(.title)
                .foregroundColor(.blue)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .scaleEffect(x: 1, y: 1.5, anchor: .center)
                
                HStack {
                    Text(String(format: "%.0f%%", progress * 100))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text(progressEvaluation)
                        .font(.subheadline)
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
    }
}

struct StatusItemView: View {
    var icon: String
    var value: Double
    var description: String
    
    var body: some View {
        HStack {
            Button(action: {
                // 按钮点击事件
            }) {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(.blue)
            }
            
            VStack(alignment: .trailing) {
                Text("\(value)")
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .frame(width: (ScreenWidth - 72)/2, height: 84)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(radius: 1)
    }
}
