//
//  HealthGoalSelectionView.swift
//  task_management_tool
//
//  Created by i564407 on 4/3/24.
//

import SwiftUI

struct GoalSelectionView: View {
    var goalType: GoalType
    @State private var selectedGoal: String? // Now tracking a single selected goal
    @State private var goalDetail = GoalDetail() // Initialize with default values or fetch existing data
    
    var body: some View {
        List(goalType.commonGoals, id: \.self) { goal in
            MultipleSelectionRow(title: goal, isSelected: selectedGoal == goal) {
                // 更新selectedGoal为当前选中的目标，如果当前目标已选中，则取消选中
                selectedGoal = selectedGoal == goal ? nil : goal
                // 更新goalDetail的相关信息
                goalDetail.goal = selectedGoal ?? ""
                goalDetail.goalType = goalType
            }
        }
        .navigationTitle("选择目标")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink("下一步", destination: GoalDetailsView(goalDetail: $goalDetail))
                    .disabled(selectedGoal == nil)
            }
        }
    }
}




struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            action()
        }
    }
}
#Preview {
    GoalSelectionView(goalType: .ability)
}
