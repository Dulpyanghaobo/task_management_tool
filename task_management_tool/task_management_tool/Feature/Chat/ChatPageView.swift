//
//  ChatPageView.swift
//  task_management_tool
//
//  Created by i564407 on 4/23/24.
//

import SwiftUI

struct ChatPageView: View {
    var body: some View {
        ScrollView {
            
        }.background(
            Image("background")  // 替换 "backgroundImageName" 为您的图片资源名
                .resizable()  // 确保图片可以调整大小以适应容器
                .scaledToFill()  // 填充整个可用空间，可能会裁剪图片
                .edgesIgnoringSafeArea(.all)  // 让背景图片延伸到安全区域之外
        )
    }
}
