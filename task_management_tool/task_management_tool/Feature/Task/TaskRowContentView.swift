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
        HStack(alignment: .top, spacing: 4) {
            VStack(alignment: .leading, spacing: 8) {
                HStack (alignment: .center) {
                    Text(task.category.rawValue).font(.system(size: 14, weight: .regular)).foregroundColor(AppColors.projectTitleColor)
                    Spacer()
                    Image(systemName: "star.fill").frame(width: 32, height: 32).foregroundColor(AppColors.primaryColor).background(AppColors.secondaryColor).cornerRadius(8)
                }
                Text(task.title).font(.system(size: 16, weight: .regular)).foregroundColor(.black)
                HStack {
                    HStack (alignment: .top) {
                        Image(systemName: "star").font(.system(size: 12, weight: .medium)).foregroundColor(AppColors.primaryColor)
                        if let deadline = task.deadline {
                            Text("\(deadline, formatter: itemFormatter)")
                                .font(.system(size: 12, weight: .medium)).foregroundColor(AppColors.primaryColor)
                        }
                    }
                    Spacer()
                    Button(action: {
                        showingSheet = true
                    }) {
                        Text(buttonTitle(for: task.status)).font(.system(size: 12, weight: .regular)).padding(.horizontal, 8).padding(.vertical, 4).background(statusBackgroundColor(for: task.status)).foregroundColor(statusForegroundColor(for: task.status)).cornerRadius(12)
                    }
                    .actionSheet(isPresented: $showingSheet) {
                        actionSheet()
                    }
                }
            }
        }
        .padding(.horizontal, 4)
        .cornerRadius(24)
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
    
    private func statusBackgroundColor(for status: TaskStatus) -> Color {
        switch status {
        case .created:
            return AppColors.secondaryColor
        case .inProgress:
            return AppColors.secondary2Color
        case .isBlock:
            return AppColors.secondary3Color
        case .waiting:
            return AppColors.secondary4Color
        case .completed:
            return AppColors.secondary5Color
        case .Settlement:
            return AppColors.secondary6Color
        }
    }
    
    private func statusForegroundColor(for status: TaskStatus) -> Color {
        switch status {
        case .created:
            return AppColors.primaryColor
        case .inProgress:
            return AppColors.primary2Color
        case .isBlock:
            return AppColors.primary3Color
        case .waiting:
            return AppColors.primary4Color
        case .completed:
            return AppColors.primary5Color
        case .Settlement:
            return AppColors.primary6Color
        }
    }
    
    private func foregroundColor(for category: TaskCategory) -> Color {
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
