//
//  ActivityDetailView.swift
//  task_management_tool
//
//  Created by i564407 on 4/28/24.
//

import SwiftUI

struct ActivityDetailView: View {
    var activityDetails: [ActivityDetail]
    
    var body: some View {
        List(activityDetails) { activity in
            HStack {
                Image(systemName: activity.statusImage)
                    .font(.system(size: 32, weight: .regular))
                    .frame(width: 44, height: 44)
                    .foregroundColor(StatusImageForegroundColor(completeStatus: activity.completeStatus))
                    .background(AppColors.secondaryColor).cornerRadius(22)
                VStack(alignment: .leading, spacing: 4) {
                    Text(activity.description)
                        .font(.system(size: 14, weight: .semibold))
                    Text(activity.completeDate)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                }
            }.listRowBackground(Color.clear)
        }.scrollContentBackground(.hidden)
        .listStyle(PlainListStyle())
    }
    
    private func StatusImageForegroundColor(completeStatus :CompleteStatus) -> Color {
        switch completeStatus {
        case .sLevel:
            return AppColors.primaryColor
        case .inProgress:
            return .gray
        case .completed:
            return AppColors.blackIronColor
        case .cLevel:
            return AppColors.bronzeColor
        case .bLevel:
            return AppColors.sliderColor
        case .aLevel:
            return AppColors.goldColor
        }
    }
}
