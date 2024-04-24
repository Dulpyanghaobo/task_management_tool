//
//  ProjectPageView.swift
//  task_management_tool
//
//  Created by i564407 on 4/23/24.
//

import SwiftUI

struct ProjectPageView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        VStack(alignment: .center, spacing: 24){
            Spacer()
            Image("TaskManagement_Page_header").resizable()  // 确保图片可以调整大小以适应容器
                .scaledToFill()  // 填充整个可用空间，可能会裁剪图片
                .frame(width: 245, height: 340)
            Spacer()
            Text("Task Management & To-Do List").font(.system(size: 24, weight: .semibold)).foregroundColor(.black).multilineTextAlignment(.center)
            Text("This productive tool is designed to help you better manage your task project-wise conveniently!").font(.system(size: 14, weight: .regular)).foregroundColor(AppColors.projectTitleColor).multilineTextAlignment(.center)
            Spacer()
            Button {
                viewRouter.currentPage = "TaskPageContentView"
            } label: {
                Text("Let's Start").frame(maxWidth: .infinity).foregroundColor(.white).padding().font(.system(size: 19, weight: .semibold)).background(AppColors.primaryColor).cornerRadius(8)
            }.padding(.bottom, 16)
        }.padding(.horizontal, 48)
        .background(
            Image("background")  // 替换 "backgroundImageName" 为您的图片资源名
                .resizable()  // 确保图片可以调整大小以适应容器
                .scaledToFill()  // 填充整个可用空间，可能会裁剪图片
                .edgesIgnoringSafeArea(.all)  // 让背景图片延伸到安全区域之外
        )
    }
}
