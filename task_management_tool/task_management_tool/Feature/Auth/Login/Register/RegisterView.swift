//
//  RegisterView.swift
//  task_management_tool
//
//  Created by i564407 on 4/18/24.
//

import SwiftUI
import AuthenticationServices  // 导入支持苹果登录的库

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Hello! Register to get started")
                        .font(.title)
                        .bold()
                        .padding(.vertical, 24)
                }

            TextField("Username", text: $viewModel.username)
                    .padding() // 减小左右内边距
                    .background(Color.secondary.opacity(0.1))
                    .font(.system(size: 15,weight: .light))
                    .border(AppColors.textFieldBorderColor, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .cornerRadius(8)
            TextField("Email", text: $viewModel.email)
                    .padding() // 减小左右内边距
                    .background(Color.secondary.opacity(0.1))
                    .font(.system(size: 15,weight: .light))
                    .border(AppColors.textFieldBorderColor, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .cornerRadius(8)
            SecureField("Password", text: $viewModel.password)
                    .padding() // 减小左右内边距
                    .background(Color.secondary.opacity(0.1))
                    .font(.system(size: 15,weight: .light))
                    .border(AppColors.textFieldBorderColor, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .cornerRadius(8)
            SecureField("Confirm Password", text: $viewModel.confirmPassword)
                    .padding() // 减小左右内边距
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(8)
                    .font(.system(size: 15,weight: .light))
                    .border(AppColors.textFieldBorderColor, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .cornerRadius(8)
            Button(action: {
                viewModel.register()
            }) {
                Text("Register")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppColors.primaryColor)
                    .cornerRadius(8)
                    .font(.system(size: 15,weight: .semibold))
                    .padding(.vertical, 24)
            }
            
                Text("Or Register with")
                    .frame(maxWidth: .infinity, alignment: .center).font(.system(size: 14)).foregroundColor(AppColors.secondaryTitleColor)
                
                // Apple 登录按钮
                SignInWithAppleButton(.signIn) { request in
                    // 处理苹果登录的请求配置
                } onCompletion: { result in
                    // 处理登录结果
                }
                .signInWithAppleButtonStyle(.black)
                .frame(height: 50)
                
                Spacer()
                
                HStack {
                    Text("Already have an account?").font(.system(size: 16)).foregroundColor(.black)
                    NavigationLink("Login Now", destination: LoginView())
                        .foregroundColor(AppColors.thirdTitleColor).font(.callout)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
            }
            .padding(.horizontal, 24) // 减小整个 VStack 的水平内边距
        .navigationBarTitle("", displayMode: .inline).navigationBarBackButtonHidden().navigationBarItems(leading: BackButton())
        .alert(isPresented: $viewModel.showAlert, content: {
            Alert(title: Text("Registration Failed"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        })
        .background(
            NavigationLink(destination: VerificationView(userId: viewModel.userId), isActive: $viewModel.isRegistered) {
                EmptyView()
            }
        )
        .withLoading(isLoading: viewModel.isLoading, text: "Loading...")
    }
}
