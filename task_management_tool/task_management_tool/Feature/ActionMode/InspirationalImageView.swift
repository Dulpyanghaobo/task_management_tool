//
//  InspirationalImageView.swift
//  task_management_tool
//
//  Created by i564407 on 4/22/24.
//
import SwiftUI
import SwiftUI

struct InspirationalImageView: View {
    var model: InspirationalModel

    var body: some View {
        ZStack(alignment: .bottomLeading) {  // ZStack用于层叠视图
            Image(uiImage: model.imageContent)
                .resizable()
                .aspectRatio(contentMode: .fill)  // fill模式让图片填满并可能被裁剪
                .edgesIgnoringSafeArea(.all)  // 让图片延伸到边缘
            
            // 使用VStack来组织所有文本元素
            VStack(alignment: .leading, spacing: 8) {
                Text(model.title)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding([.top, .leading, .trailing])
                
                Text(model.description)
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .regular))
                    .padding([.leading, .trailing])
                Spacer(minLength: 32)
                Text("Date: \(model.date, formatter: itemFormatter)")
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.red, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    ).font(.system(size: 12, weight: .regular))
                    .padding([.leading, .trailing])
                
                Text(model.theme)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.red, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    ).font(.system(size: 12, weight: .regular))
                    .padding([.leading, .trailing])
            }
            .padding()
        }
    }
}

// Helper function to format the date
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()
