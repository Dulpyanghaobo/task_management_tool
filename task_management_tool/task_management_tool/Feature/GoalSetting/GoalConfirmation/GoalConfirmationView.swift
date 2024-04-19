//
//  GoalConfirmationView.swift
//  task_management_tool
//
//  Created by i564407 on 4/3/24.
//

import SwiftUI

struct GoalConfirmationView: View {
    let goalDetail: GoalDetail

    var body: some View {
        List {
            Section(header: Text("Goal Overview")) {
                RowView(title: "Goal Type", value: goalDetail.goalType.rawValue)
                RowView(title: "Goal", value: goalDetail.goal)
                RowView(title: "Measurement", value: goalDetail.measurement)
                RowView(title: "Deadline", value: DateFormatter.localizedString(from: goalDetail.deadline, dateStyle: .medium, timeStyle: .none))
                RowView(title: "Implementation Difficulty", value: goalDetail.implementationDifficulty.rawValue)
            }
            
            if !goalDetail.description.isEmpty {
                Section(header: Text("Description")) {
                    Text(goalDetail.description)
                }
            }

            if !goalDetail.milestones.isEmpty {
                Section(header: Text("Milestones")) {
                    ForEach(goalDetail.milestones, id: \.id) { milestone in
                        Text(milestone.title)
                    }
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .listStyle(GroupedListStyle())
    }
}

struct RowView: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
    }
}


