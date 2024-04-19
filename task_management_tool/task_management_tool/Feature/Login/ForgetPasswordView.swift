//
//  ForgetPasswordView.swift
//  task_management_tool
//
//  Created by i564407 on 4/19/24.
//

import SwiftUI





struct ForgetPasswordView: View {
    @State private var email: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Forgot Password?")
                    .font(.title)
                    .bold()
                    .padding(.top, 24)
                Spacer() // Spacer 将文本推向左侧
            }
            .frame(width: 330) // 限制 HStack 的宽度
            Text("Don't worry! It occurs. Please enter the email address linked with your account.")
                .font(.system(size: 16, weight: .light))
                .foregroundColor(AppColors.FourthTitleColor)
                .padding(.top, -6)
                .padding(.bottom, 16)
                .multilineTextAlignment(.leading) // 确保文本居中对齐
            
            TextField("Enter your Email", text: $email)
                .padding() // 减小左右内边距
                .background(Color.secondary.opacity(0.1))
                .font(.system(size: 15,weight: .light))
                .border(AppColors.textFieldBorderColor, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .cornerRadius(8)
            
            NavigationLink(destination: VerificationView()) {
                Text("Send Code")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppColors.primaryColor)
                    .cornerRadius(8)
                    .font(.system(size: 15,weight: .semibold))
                    .padding(.vertical, 20)
            }
            Spacer()
            
            HStack {
                Text("Remeber Password?").font(.system(size: 16, weight: .light)).foregroundColor(.black)
                NavigationLink("Login", destination: LoginView())
                    .foregroundColor(AppColors.thirdTitleColor).font(.callout)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.horizontal, 24) // 减小整个 VStack 的水平内边距
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: BackButton())
        Spacer() // 使用 Spacer 在底部推动所有内容向上
    }
}
