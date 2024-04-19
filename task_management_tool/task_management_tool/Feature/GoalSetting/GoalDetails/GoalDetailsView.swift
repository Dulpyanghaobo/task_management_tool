//
//  HealthGoalDetailsView.swift
//  task_management_tool
//
//  Created by i564407 on 4/3/24.
//

import SwiftUI

struct GoalDetailsView: View {
    @Binding var goalDetail: GoalDetail
    
    private var isNavigationButtonEnabled: Bool {
        !goalDetail.description.isEmpty && goalDetail.description.count >= 20 && !goalDetail.measurement.isEmpty
    }
    
    var body: some View {
        Form {
            // Goal Type
            Section(header: Text("Goal Type")) {
                Text(goalDetail.goalType.rawValue)
            }

            // Goal Description
            Section(header: Text("Goal")) {
                TextField("Describe your goal", text: $goalDetail.goal)
            }

            // Deadline
            Section(header: Text("Deadline")) {
                DatePicker("Select deadline", selection: $goalDetail.deadline, displayedComponents: .date)
            }

            // Measurement
            Section(header: Text("Measurement")) {
                TextField("Quantify success (e.g., 5km run)", text: $goalDetail.measurement)
            }

            // Description
            Section(header: Text("Details")) {
                TextEditor(text: $goalDetail.description)
                    .frame(height: 200) // Adjust the frame to fit content
            }

            // Implementation Difficulty
            Section(header: Text("Implementation Difficulty")) {
                Picker("Select difficulty", selection: $goalDetail.implementationDifficulty) {
                    ForEach(Difficulty.allCases, id: \.self) { difficulty in
                        Text(difficulty.rawValue).tag(difficulty)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(trailing: NavigationLink(destination: GoalBreakdownView(goalDetail: $goalDetail), label: {
            Text("下一步")
        }).disabled(isNavigationButtonEnabled))
    }
}

