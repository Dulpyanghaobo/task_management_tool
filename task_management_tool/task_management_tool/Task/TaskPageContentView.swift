//
//  TaskPageContentView.swift
//  task_management_tool
//
//  Created by i564407 on 11/16/23.
//

import SwiftUI

struct TaskPageContentView: View {
    
    // 假设这是存储任务的数组，您可以根据实际情况从模型或网络服务中获取数据
    @State private var tasks: [Task] = []
    @State private var showingCreateTaskView = false // 控制CreateTaskContentView的显示
    
    var body: some View {
        List(tasks) { task in
            TaskRow(task: task)
        }
        .navigationTitle("Tasks")
        .navigationBarItems(trailing: Button(action: {
            showingCreateTaskView = true
        }) {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $showingCreateTaskView, content: {
            CreateTaskContentView()
        })
        .onAppear {
            loadTasks()
        }
    }

    private func loadTasks() {
        // 加载或刷新任务数据
    }
    
}

struct TaskRow: View {
    let task: Task

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
            // 可以添加更多任务相关的信息
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
