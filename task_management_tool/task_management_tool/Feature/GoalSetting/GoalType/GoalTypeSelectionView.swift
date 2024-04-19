//
//  GoalTypeSelectionView.swift
//  task_management_tool
//
//  Created by i564407 on 4/3/24.
//

import SwiftUI

struct GoalTypeSelectionView: View {
    @State private var selectedGoalType: GoalType?

    var body: some View {
        NavigationView {
            List(GoalType.allCases, id: \.self) { goalType in
                HStack {
                    Text(goalType.rawValue)
                    Spacer()
                    if selectedGoalType == goalType {
                        Image(systemName: "checkmark").foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectedGoalType = goalType
                }
            }
            .navigationTitle("选择目标类型")
            .navigationBarItems(trailing: NavigationLink(destination: GoalSelectionView(goalType: selectedGoalType ?? .health), label: {
                Text("下一步")
            }).disabled(selectedGoalType == nil))
        }
    }
}

#Preview {
    GoalTypeSelectionView()
}
