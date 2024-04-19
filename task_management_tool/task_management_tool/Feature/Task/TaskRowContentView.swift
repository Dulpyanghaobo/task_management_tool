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
        .padding()
        .background(backgroundColor(for: task.category))
        .cornerRadius(10)
    }
    
    private func handleStatusChange(newStatus: TaskStatus) {
        viewModel.updateTaskStatus(taskId: task.id, newStatus: newStatus)
        viewModel.filterTasks(by: viewModel.selectedStatus)
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
    
    // 根据任务类别返回相应的背景颜色
    private func backgroundColor(for category: TaskCategory) -> Color {
        switch category {
        case .study:
            return Color.blue.opacity(0.2) // 淡蓝色
        case .work:
            return Color.green.opacity(0.2) // 淡绿色
        case .life:
            return Color.orange.opacity(0.2) // 淡橘色
        // 添加其他类别的颜色
        default:
            return Color.gray.opacity(0.2) // 默认颜色
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
