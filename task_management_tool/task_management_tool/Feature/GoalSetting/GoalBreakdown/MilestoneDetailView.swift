//
//  MilestoneDetailView.swift
//  task_management_tool
//
//  Created by i564407 on 4/3/24.
//

import SwiftUI

struct MilestoneDetailView: View {
    @Binding var milestone: Milestone?
//    @Environment(\.presentationMode) var presentationMode
    @State private var localTitle: String = ""

    var body: some View {
        Form {
            TextField("Title", text: $localTitle)
        }
        .navigationBarItems(trailing: Button("Save") {
            if var unwrappedMilestone = milestone {
                // If editing an existing milestone, update its title
                unwrappedMilestone.title = localTitle
            } else {
                // If creating a new milestone, update the binding with a new Milestone
                milestone = Milestone(title: localTitle)
            }
//            presentationMode.wrappedValue.dismiss()
        })
        .onAppear {
            // Initialize the localTitle with the Milestone's title if it exists
            if let milestoneTitle = milestone?.title {
                localTitle = milestoneTitle
            }
        }
    }
}


