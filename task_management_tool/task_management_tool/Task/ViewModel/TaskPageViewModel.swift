//
//  TaskPageViewModel.swift
//  task_management_tool
//
//  Created by i564407 on 11/16/23.
//

import Foundation

class TaskPageViewModel: ObservableObject {
    @Published var tasks: [Task] = []

    func updateTaskStatus(taskId: UUID, newStatus: TaskStatus) {
        guard let index = tasks.firstIndex(where: { $0.id == taskId }) else { return }
        var updatedTask = tasks[index]
        updatedTask.status = newStatus

        // 将更新逻辑放在这里
        let url = URL(string: "https://your-backend-api/task/update/\(taskId)")! // 替换为您的后端API
        var request = URLRequest(url: url)
        request.httpMethod = "PUT" // 或者 "PATCH"，取决于您的后端API
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(updatedTask) {
            URLSession.shared.uploadTask(with: request, from: encodedData) { data, response, error in
                if let error = error {
                    print("Failed to update task: \(error.localizedDescription)")
                } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    print("Task updated successfully")
                } else {
                    print("Unexpected response")
                }
            }.resume()
        }
    }

}
