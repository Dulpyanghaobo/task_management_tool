//
//  BackButton.swift
//  task_management_tool
//
//  Created by i564407 on 4/18/24.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .foregroundColor(.black)  // 确保图标为黑色
                .imageScale(.large)
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 12))  // 应用圆角
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppColors.textFieldBorderColor, lineWidth: 1)
                )
        }

    }
}
