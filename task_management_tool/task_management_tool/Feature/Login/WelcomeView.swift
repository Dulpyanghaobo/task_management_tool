//
//  WelcomeView.swift
//  task_management_tool
//
//  Created by i564407 on 4/18/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            // 使用 ZStack 将内容叠加在渐变背景上
            ZStack {
                // 渐变背景
                LinearGradient(gradient: Gradient(colors: [AppColors.primaryColor, AppColors.secondaryColor]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                // 垂直堆叠视图
                VStack {
                    Spacer()
                    
                    // 图片和文本部分
                    VStack {
                        Image("Welcome_Image")  // 确保图片已添加到项目中
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 128, height: 128)
                        
                        Text("Engineer's  Butler")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.top, 16)
                        
                        Text("Exclusive APP for INTJs")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(.top, 4)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        NavigationLink(destination: LoginView()) {
                            Text("Login")
                                .foregroundColor(.white)
                                .frame(width: ScreenWidth - 48, height: 56)
                                .background(AppColors.thirdButtonColor)
                                .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: RegisterView()) {
                            Text("Register")
                                .foregroundColor(.black)
                                .frame(width: ScreenWidth - 48, height: 56)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.bottom, 40)
                }
            }
        }
        
    }
}

