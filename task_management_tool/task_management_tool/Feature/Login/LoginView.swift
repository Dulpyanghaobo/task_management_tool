//
//  LoginRegisterView.swift
//  task_management_tool
//
//  Created by i564407 on 4/17/24.
//
import SwiftUI
import AuthenticationServices  // 导入支持苹果登录的库

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @EnvironmentObject var viewRouter: ViewRouter

    var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text("Welcome back! Glad to see you, Again!")
                    .font(.title)
                    .frame(width: 330)
                    .bold().padding(.trailing)
                    .padding(.vertical, 24)
                
                // 用户名输入
                TextField("Enter your email", text: $username)
                    .padding() // 减小左右内边距
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(8)
                    .font(.subheadline)
                
                // 密码输入
                HStack {
                    if isPasswordVisible {
                        TextField("Password", text: $password).font(.subheadline)
                    } else {
                        SecureField("Password", text: $password).font(.subheadline)

                    }
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray).font(.subheadline)
                    }
                }
                .padding() // 减小左右内边距
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(8.0)

                HStack {
                    Spacer()
                    NavigationLink(destination: ForgetPasswordView()) {
                        Text("Forgot Password?")
                            .foregroundColor(AppColors.secondaryTitleColor).font(.system(size: 14))
                    }
                }.padding(.bottom, 16)
                
                Button("Login", action: {
                    UserDefaults.standard.set(true, forKey: UserDefaultsKeys.appUserLogin)
                    viewRouter.currentPage = "HomePageView"
                })
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppColors.primaryColor)
                    .cornerRadius(8)
                    .padding(.bottom, 16)
                
                Text("Or Login with")
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
                    Text("Don't have an account?").font(.system(size: 14)).foregroundColor(.black)
                    NavigationLink("Register Now", destination: RegisterView())
                        .foregroundColor(AppColors.thirdTitleColor).font(.callout)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
        } .padding(.horizontal, 24) // 减小整个 VStack 的水平内边距
            .navigationBarTitle("", displayMode: .inline).navigationBarBackButtonHidden().navigationBarItems(leading: BackButton())
    }
}

