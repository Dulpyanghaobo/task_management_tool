//
//  AddTaskOKRView.swift
//  task_management_tool
//
//  Created by i564407 on 4/23/24.
//

import SwiftUI

struct AddTaskOKRView: View {
    @State private var showingActionSheet: Bool = false // 控制ActionSheet的显示
    @State private var taskName: String = ""
    @State private var taskDescription: String = ""
    @State private var tags: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var difficulty: Int = 1
    @State private var urgency: Int = 1
    @State private var importance: Int = 1
    @State private var selectedCategory: TaskCategory = .study
    @State private var selectedMode: TaskMode = .once
    @State private var logoImage: UIImage? = nil
    
    var onSave: (Task) -> Void  // 添加一个新的闭包属性

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "star.fill").frame(width: 32, height: 32).background(AppColors.homePageProgress2Color).foregroundColor(AppColors.homePageProgress2TintIconColor).cornerRadius(8)
                    VStack {
                        Text("Task Group").foregroundColor(AppColors.projectTitleColor).font(.system(size: 9, weight: .regular))
                        Text(selectedCategory.rawValue).foregroundColor(.black).font(.system(size: 14, weight: .semibold))
                    }
                    Spacer()
                    Button(action: {
                        showingActionSheet = true
                    }, label: {
                        Image(systemName: "arrowtriangle.down.fill").font(.caption2).foregroundColor(.black)
                            .padding()
                    })
                    .actionSheet(isPresented: $showingActionSheet) {
                        actionSheet()
                    }
                }.padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 4)

                VStack(alignment: .leading) {
                    Text("Task Name").foregroundColor(AppColors.projectTitleColor).font(.system(size: 9, weight: .regular))
                    // 任务名称
                    TextField("Input the Name", text: $taskName)  // 去除 TextField 的标签
                        .font(.system(size: 14))  // 输入框字体大小
                }.padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color.white)  // 输入框背景颜色
                    .cornerRadius(16)  // 输入框圆角
                    .shadow(radius: 4)  // 输入框阴影
                
                VStack(alignment: .leading) {
                    Text("Task Description").foregroundColor(AppColors.projectTitleColor).font(.system(size: 9, weight: .regular))
                    // 任务名称
                    TextEditor(text: $taskDescription)
                        .font(.system(size: 14))  // 输入框字体大小
                        .frame(minHeight: 36, idealHeight: 100, maxHeight: .infinity)  // 最小、理想和最大高度
                }.padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color.white)  // 输入框背景颜色
                    .cornerRadius(16)  // 输入框圆角
                    .shadow(radius: 4)  // 输入框阴影
                
                HStack {
                    Image("calendar")
                        .frame(width: 32, height: 32)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Start Date").foregroundColor(AppColors.projectTitleColor).font(.system(size: 9, weight: .regular))
                        Text("01 May, 2024").foregroundColor(.black).font(.system(size: 14, weight: .semibold))
                    }
                    Spacer()
                    DatePicker("Select Date",
                                   selection: $startDate,
                                   displayedComponents: .date)
                            .labelsHidden()  // 隐藏内部标签，只显示日期选择器
                }.padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 4)
                HStack {
                    Stepper("difficulty: \(difficulty)", value: $difficulty, in: 1...5).foregroundColor(.black).font(.system(size: 14, weight: .semibold))
                }.padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 4)
                HStack {
                    Stepper("Urgency: \(urgency)", value: $urgency, in: 1...5).foregroundColor(.black).font(.system(size: 14, weight: .semibold))
                }.padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 4)
                HStack {
                    Stepper("Importance: \(importance)", value: $importance, in: 1...5).foregroundColor(.black).font(.system(size: 14, weight: .semibold))
                }.padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 4)
                HStack {
                    Image("calendar")
                        .frame(width: 32, height: 32)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("End Date").foregroundColor(AppColors.projectTitleColor).font(.system(size: 9, weight: .regular))
                        Text("01 May, 2024").foregroundColor(.black).font(.system(size: 14, weight: .semibold))
                    }
                    Spacer()
                    DatePicker("Select Date",
                                   selection: $startDate,
                                   displayedComponents: .date)
                            .labelsHidden()  // 隐藏内部标签，只显示日期选择器
                }.padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 4)
                
                HStack {
                    Image("Welcome_Image")
                        .resizable()  // 确保图片可以调整大小以适应容器
                        .scaledToFill()  // 填充整个可用空间，可能会裁剪图片
                        .frame(width: 44, height: 44)
                    Spacer()
                    // 生成logo
                    Button(action: {
                        // Logo生成逻辑
                    }) {
                        Text("Generate Logo")
                            .font(.system(size: 11, weight: .regular))
                            .foregroundColor(AppColors.tabbarTintColor)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(AppColors.tabbarBackgroundColor)
                            .cornerRadius(8)
                    }
                }.padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 4)

                
                Spacer()
            }.padding(.all, 24)
            
            Button("Add Task") {
                addTask()
            }
            .foregroundColor(.white)
            .padding()
            .font(AppFonts.primaryButtonFont)
            .background(AppColors.primaryColor)
            .cornerRadius(8)
            .padding(.bottom, 16)

        }.background(
            Image("background")  // 替换 "backgroundImageName" 为您的图片资源名
                .resizable()  // 确保图片可以调整大小以适应容器
                .scaledToFill()  // 填充整个可用空间，可能会裁剪图片
                .edgesIgnoringSafeArea(.all)  // 让背景图片延伸到安全区域之外
        )
        .navigationBarTitle("Add Goal", displayMode: .inline).navigationBarBackButtonHidden().navigationBarItems(leading: BackButton())
    }
    
    func actionSheet() -> ActionSheet {
        ActionSheet(title: Text("Select Task Type"), buttons: TaskCategory.allCases.map { category in
            .default(Text(category.rawValue)) {
                selectedCategory = category
            }
        } + [.cancel()])
    }
    
    private func addTask() {
        let newTaskTags = tags.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
        let newTask = Task(
            id: UUID(), title: taskName,
            category: selectedCategory,
            mode: selectedMode,
            tags: newTaskTags,
            difficulty: difficulty,
            urgency: urgency,
            status: .created,
            createAt: startDate,
            updateAt: endDate,
            deadline: endDate,
            importance: importance
        )
        // 在这里处理新任务的保存逻辑，比如更新到一个任务数组或发送到后端
        onSave(newTask) // 调用闭包来传递新创建的任务
        
        // 关闭当前视图
        // presentationMode.wrappedValue.dismiss()
    }
}
