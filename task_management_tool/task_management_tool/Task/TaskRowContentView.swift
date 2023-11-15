//
//  TaskRow.swift
//  task_management_tool
//
//  Created by i564407 on 11/16/23.
//

import SwiftUI

struct TaskRowContentView: View {
    
    @ObservedObject var viewModel: TaskPageViewModel

    var task: Task
    
    @State private var showingSheet = false


    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title)
                .font(.headline)
            HStack {
                Text(task.category.rawValue)
                    .font(.subheadline)
                Spacer()
                Text("Priority: \(task.priority)")
                    .font(.subheadline)
                Spacer()
                Button(action: {
                    showingSheet = true
                }) {
                    Text(buttonTitle(for: task.status)).foregroundColor(.blue)
                }
                .actionSheet(isPresented: $showingSheet) {
                    actionSheet()
                }
            }
            HStack {
                Text(task.mode.rawValue)
                    .font(.subheadline)
                Spacer()
                if let deadline = task.deadline {
                    Text("Deadline: \(deadline, formatter: itemFormatter)")
                        .font(.subheadline)
                }
            }
        }
    }
    
    private func handleStatusChange(newStatus: TaskStatus) {
        viewModel.updateTaskStatus(taskId: task.id, newStatus: newStatus)
    }

    private func actionSheet() -> ActionSheet {
        switch task.status {
        case .created:
            return ActionSheet(
                title: Text("Start Task"),
                message: Text("Are you sure you want to start this task?"),
                buttons: [
                    .default(Text("Start Now")) {
                        handleStatusChange(newStatus: .inProgress)
                    },
                    .cancel()
                ]
            )
        case .inProgress:
            return ActionSheet(
                title: Text("Update Task Status"),
                message: Text("Select the new status for this task."),
                buttons: [
                    .default(Text("Blocking")) {
                        handleStatusChange(newStatus: .isBlock)
                    },
                    .default(Text("Finish")) {
                        handleStatusChange(newStatus: .completed)
                    },
                    .cancel()
                ]
            )
        // 添加其他状态的处理逻辑
        default:
            return ActionSheet(title: Text("Operation not available"))
        }
    }
    
    private func buttonTitle(for status: TaskStatus) -> String {
        switch status {
        case .created:
            return "Start"
        case .inProgress:
            return "Working"
        // 添加其他状态对应的按钮标题
        default:
            return "Unknown"
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
