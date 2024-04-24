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
    @State private var selectedDate: Date = Date()

    var body: some View {
        NavigationView { // 包裹在NavigationView内
            ScrollView {
                VStack {
                    HorizontalCalendarView(selectedDate: $selectedDate).onAppear{
                        selectedDate = Date()
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(TaskStatus.allCases, id: \.self) { status in
                                                Button(action: {
                                                    viewModel.selectedStatus = status
                                                    viewModel.filterTasks(by: status)
                                                }) {
                                                    Text(status.rawValue)
                                                        .padding(.vertical, 8).padding(.horizontal, 16)
                                                        .font(.system(size: 14, weight: .semibold))
                                                        .background(viewModel.selectedStatus == status ? AppColors.primaryColor : AppColors.secondaryColor)
                                                        .foregroundColor(viewModel.selectedStatus == status ? .white : AppColors.primaryColor)
                                                        .cornerRadius(8)
                                                }
                                            }
                                        }
                                        .padding()
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
            }.background(
                Image("background")  // 替换 "backgroundImageName" 为您的图片资源名
                    .resizable()  // 确保图片可以调整大小以适应容器
                    .scaledToFill()  // 填充整个可用空间，可能会裁剪图片
                    .edgesIgnoringSafeArea(.all)  // 让背景图片延伸到安全区域之外
            )
            .navigationBarTitle("\(selectedDate.monthDayFormatted())'s Tasks", displayMode: .inline)
.navigationBarBackButtonHidden().navigationBarItems(trailing: Button(action: {
    showingCreateTaskView = true
}, label: {
                Image(systemName: "plus").foregroundColor(.black)
            }))
        }
        .onAppear {
            loadTasks()
        }
    }
    
    private func loadTasks() {
        // 加载或刷新任务数据
    }
    
}
