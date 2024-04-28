//
//  VerificationView.swift
//  task_management_tool
//
//  Created by i564407 on 4/18/24.
//
import SwiftUI

struct VerificationView: View {
    @State private var code: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedField: Int?

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
                ForEach(0..<6, id: \.self) { index in
                    TextField("", text: $code[index])
                        .multilineTextAlignment(.center)
                        .frame(width: 44, height: 44)
                        .background(AppColors.textFieldBackgroundColor)
                        .font(.subheadline)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(focusedField == index ? AppColors.thirdTitleColor : AppColors.textFieldBorderColor, lineWidth: 1)
                        )
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: index)
                        .onChange(of: code[index]) { newValue in
                            handleTextChange(at: index, newValue: newValue)
                        }
                }
            }
            .onAppear {
                focusedField = 0  // Focus the first field when the view appears
            }
            .padding(.top, 16)
            NavigationLink(destination: CreatePasswordView()) {
                Text("Verify")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppColors.primaryColor)
                    .cornerRadius(8)
                    .font(.system(size: 15,weight: .semibold))
            }.simultaneousGesture(TapGesture().onEnded {
                UserDefaults.standard.set(true, forKey: UserDefaultsKeys.appUserLogin)
                })
            .padding(.top, 16)
        }
        .padding(.horizontal, 24) // 减小整个 VStack 的水平内边距
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: BackButton())
        Spacer() // 使用 Spacer 在底部推动所有内容向上
    }

    private func handleTextChange(at index: Int, newValue: String) {
        if newValue.count > 1 {
            // Limit to one character and stay in the same field
            code[index] = String(newValue.prefix(1))
        } else if newValue.isEmpty && index > 0 {
            // If the current field is cleared, move focus to the previous field
            focusedField = index - 1
        } else if newValue.count == 1 && index < 5 {
            // If a new character is entered, move focus to the next field if not the last
            focusedField = index + 1
        }
    }
}
