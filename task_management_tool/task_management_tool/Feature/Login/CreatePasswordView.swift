//
//  CreatePassword.swift
//  task_management_tool
//
//  Created by i564407 on 4/19/24.
//

import SwiftUI

struct CreatePasswordView: View {
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Create new password")
                        .font(.title)
                        .bold()
                        .padding(.top, 24)
                    Spacer() // Spacer 将文本推向左侧
                }
                .frame(width: 330) // 限制 HStack 的宽度
                Text("Enter the verification code we just sent on your email address.")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(AppColors.FourthTitleColor)
                    .padding(.top, -4)
                    .padding(.bottom, 16)
                    .multilineTextAlignment(.leading) // 确保文本居中对齐

                SecureField("Password", text: $password)
                    .padding() // 减小左右内边距
                    .background(Color.secondary.opacity(0.1))
                    .font(.system(size: 15,weight: .light))
                    .border(AppColors.textFieldBorderColor, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .cornerRadius(8)
                SecureField("Confirm Password", text: $password)
                    .padding() // 减小左右内边距
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(8)
                    .font(.system(size: 15,weight: .light))
                    .border(AppColors.textFieldBorderColor, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .cornerRadius(8)
                NavigationLink(destination: PasswordChangedView()) {
                    Text("Reset Password")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(AppColors.primaryColor)
                        .cornerRadius(8)
                        .font(.system(size: 15,weight: .semibold))
                        .padding(.vertical, 24)
                }
            }
            .padding(.horizontal, 24).navigationBarTitle("", displayMode: .inline).navigationBarBackButtonHidden().navigationBarItems(leading: BackButton())
        Spacer()
    }
}

