//
//  PasswordChangedView.swift
//  task_management_tool
//
//  Created by i564407 on 4/19/24.
//

import SwiftUI


struct PasswordChangedView: View {

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.seal.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(AppColors.checkmarkImageColor)
            
            Text("Password Changed!")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Your password has been changed successfully.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, -12)
                .frame(width: 330)
            
            NavigationLink(destination: LoginView()) {
                Text("Back to Login")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppColors.primaryColor)
                    .cornerRadius(8)
                    .font(.system(size: 15,weight: .semibold))
            }.padding(.horizontal, 32).padding(.top, 32)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true) // Optionally hide the navigation bar
        Spacer()
    }
}

