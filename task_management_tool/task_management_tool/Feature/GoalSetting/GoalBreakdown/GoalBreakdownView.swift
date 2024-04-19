//
//  HealthGoalBreakdownView.swift
//  task_management_tool
//
//  Created by i564407 on 4/3/24.
//

import SwiftUI

struct GoalBreakdownView: View {
    @Binding var goalDetail: GoalDetail // Now expects the whole GoalDetail as binding
    @State private var showingDetail = false
    @State private var tempMilestone: Milestone?
    @State private var navigateToConfirmation = false // Navigation trigger

    var body: some View {
        List {
            ForEach($goalDetail.milestones) { $milestone in
                Text(milestone.title)
                    .onTapGesture {
                        self.tempMilestone = milestone
                        self.showingDetail = true
                    }
            }
            .onDelete(perform: delete)
            
            Button("Add Milestone") {
                self.tempMilestone = Milestone(title: "")
                self.showingDetail = true
            }
        }
        .sheet(isPresented: $showingDetail) {
            NavigationView {
                MilestoneDetailView(milestone: $tempMilestone)
            }
        }
        .navigationBarItems(trailing: Button("Confirm") {
            self.navigateToConfirmation = true
        })
        .background(NavigationLink(destination: GoalConfirmationView(goalDetail: goalDetail), isActive: $navigateToConfirmation) { EmptyView() }.hidden())
    }
    
    func delete(at offsets: IndexSet) {
        goalDetail.milestones.remove(atOffsets: offsets)
    }
}
