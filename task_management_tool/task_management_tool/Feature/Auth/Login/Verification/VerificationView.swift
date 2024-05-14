//
//  VerificationView.swift
//  task_management_tool
//
//  Created by i564407 on 4/18/24.
//
import SwiftUI

struct VerificationView: View {
    @StateObject private var viewModel: VerificationViewModel

    init(userId: String) {
        _viewModel = StateObject(wrappedValue: VerificationViewModel(userId: userId))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("OTP Verification")
                    .font(.title)
                    .bold()
                    .padding(.top, 24) // 添加顶部边距
                Spacer() // Spacer 将文本推向左侧
            }
            .frame(width: 330) // 限制 HStack 的宽度
            Text("Enter the verification code we just sent on your email address.")
                .font(.system(size: 16, weight: .light))
                .foregroundColor(AppColors.FourthTitleColor)
                .padding(.top, -4)
                .multilineTextAlignment(.leading)

            HStack(spacing: 16) {
                // 在 VerificationView 中使用
                ForEach(0..<6, id: \.self) { index in
                    VerificationCodeField(
                        text: $viewModel.code[index],
                        isFocused: viewModel.focusedField == index,
                        onTextChange: { newValue in
                            viewModel.handleTextChange(at: index, newValue: newValue)
                        },
                        onCommit: {
                            if index < 5 {
                                viewModel.focusedField = index + 1
                            } else {
                                // 最后一个 TextField 输入完成后的操作，例如提交验证码
                                viewModel.verify()
                            }
                        }
                    )
                    .focused(viewModel.$focusedField, equals: index)
                }

            }
            .onAppear {
                viewModel.focusedField = 0  // Focus the first field when the view appears
            }
            .padding(.top, 16)
            Button(action: {
                viewModel.verify()
            }) {
                Text("Verify")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppColors.primaryColor)
                    .cornerRadius(8)
                    .font(.system(size: 15,weight: .semibold))
            }
            .padding(.top, 16)
        }
        .padding(.horizontal, 24) // 减小整个 VStack 的水平内边距
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: BackButton())
        .alert(isPresented: $viewModel.showAlert, content: {
            Alert(title: Text("Verification Failed"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        })
        .background(
            NavigationLink(destination: CreatePasswordView(), isActive: $viewModel.isVerified) {
                EmptyView()
            }
        )
        .withLoading(isLoading: viewModel.isLoading, text: "Verifying...")
        Spacer() // 使用 Spacer 在底部推动所有内容向上
    }
}

struct VerificationCodeField: View {
    @Binding var text: String
    var isFocused: Bool
    var onTextChange: (String) -> Void
    var onCommit: () -> Void

    var body: some View {
        TextField("", text: $text)
            .multilineTextAlignment(.center)
            .frame(width: 44, height: 44)
            .background(AppColors.textFieldBackgroundColor)
            .font(.subheadline)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isFocused ? AppColors.thirdTitleColor : AppColors.textFieldBorderColor, lineWidth: 1)
            )
            .keyboardType(.numberPad)
            .onChange(of: text) { newValue in
                if newValue.count > 1 {
                    text = String(newValue.prefix(1))
                }
                onTextChange(text)
                if text.count == 1 {
                    onCommit()
                }
            }
    }
}


