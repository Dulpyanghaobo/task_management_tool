//
//  CreateTaskViewModel.swift
//  task_management_tool
//
//  Created by i564407 on 11/16/23.
//
import Foundation

class TaskViewModel {
    func createTask(id: UUID, title: String, category: TaskCategory, mode: TaskMode, tags: [String], difficulty: Int, urgency: Int, importance: Int, deadline: Date?) {
        // 创建Task对象
        let newTask = Task(id: id,
                           title: title,
                           category: category,
                           mode: mode,
                           tags: tags,
                           difficulty: difficulty,
                           urgency: urgency,
                           status: .created,
                           createAt: .now,
                           updateAt: Date(),
                           deadline: deadline,
                           importance: importance)

        // TODO: 保存任务到数据库或发送到后端
        saveTask(task: newTask)
    }

    private func saveTask(task: Task) {
        // 此处模拟保存任务到数据库或发送到后端服务器
        // 例如，使用URLSession发起网络请求或使用本地数据库
        // 以下是一个简单的网络请求模拟

        let url = URL(string: "https://your-backend-api/task/create")! // 替换为您的后端API
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(task) {
            URLSession.shared.uploadTask(with: request, from: encodedData) { data, response, error in
                if let error = error {
                    print("Failed to save task: \(error.localizedDescription)")
                } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    print("Task saved successfully")
                } else {
                    print("Unexpected response")
                }
            }.resume()
        }
    }
}


