//
//  TaskPageContentView.swift
//  task_management_tool
//
//  Created by i564407 on 11/16/23.
//

import SwiftUI

struct TaskPageContentView: View {
    
    @StateObject var viewModel = TaskPageViewModel() // 创建ViewModel实例
    
    // 假设这是存储任务的数组，您可以根据实际情况从模型或网络服务中获取数据
    @State private var showingCreateTaskView = false // 控制CreateTaskContentView的显示
    
    var body: some View {
        NavigationView { // 包裹在NavigationView内
            VStack {
                // 状态过滤栏
                Picker("Status", selection: $viewModel.selectedStatus) {
                    Text("All").tag(TaskStatus?.none)
                    ForEach(TaskStatus.allCases, id: \.self) { status in
                        Text(status.rawValue).tag(TaskStatus?.some(status))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: viewModel.selectedStatus) { newStatus in
                    viewModel.filterTasks(by: newStatus)
                }
                // 显示过滤后的任务列表
                
                List(viewModel.filteredTasks) { task in
                    TaskRowContentView(viewModel: viewModel, task: task)
                }
                .sheet(isPresented: $showingCreateTaskView, content: {
                    CreateTaskContentView { newTask in
                        viewModel.tasks.append(newTask) // 添加新任务到任务列表
                        viewModel.filterTasks(by: viewModel.selectedStatus) // 更新过滤后的任务列表
                        showingCreateTaskView = false // 关闭CreateTaskContentView
                    }
                })
            }
        .navigationTitle("Tasks")
        .navigationBarItems(trailing: Button(action: {
            showingCreateTaskView = true
        }) {
            Image(systemName: "plus")
        })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            loadTasks()
        }
    }
    
    private func loadTasks() {
        // 加载或刷新任务数据
    }
    
}
