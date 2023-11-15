//
//  CreateTaskContentView.swift
//  task_management_tool
//
//  Created by i564407 on 11/16/23.
//

import SwiftUI

struct CreateTaskContentView: View {

    @State private var title: String = ""
    @State private var selectedCategory: TaskCategory = .study
    @State private var selectedMode: TaskMode = .once
    @State private var tags: String = ""
    @State private var difficulty: Int = 1
    @State private var urgency: Int = 1
    @State private var importance: Int = 1
    @State private var deadline: Date = Date()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $title)
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(TaskCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    Picker("Mode", selection: $selectedMode) {
                        ForEach(TaskMode.allCases, id: \.self) { mode in
                            Text(mode.rawValue).tag(mode)
                        }
                    }
                    TextField("Tags (comma separated)", text: $tags)
                    Stepper("Difficulty: \(difficulty)", value: $difficulty, in: 1...5)
                    Stepper("Urgency: \(urgency)", value: $urgency, in: 1...5)
                    Stepper("Importance: \(importance)", value: $importance, in: 1...5)
                    DatePicker("Deadline", selection: $deadline, displayedComponents: .date)
                }
                Button("Create Task") {
                    addTask()
                }
            }
            .navigationBarTitle("Create Task", displayMode: .inline)
        }
    }

    private func addTask() {
        let newTaskTags = tags.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
        _ = Task(
            id: UUID(), title: title,
            category: selectedCategory,
            mode: selectedMode,
            tags: newTaskTags,
            difficulty: difficulty,
            urgency: urgency,
            status: .created,
            createAt: Date(),
            updateAt: Date(),
            deadline: deadline,
            importance: importance
        )
        // 在这里处理新任务的保存逻辑，比如更新到一个任务数组或发送到后端
    }
}

