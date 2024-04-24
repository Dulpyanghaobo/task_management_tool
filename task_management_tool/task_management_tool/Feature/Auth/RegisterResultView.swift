//
//  RegisterResultView.swift
//  task_management_tool
//
//  Created by i564407 on 4/19/24.
//

import SwiftUI

struct RegisterResultView: View {
    @EnvironmentObject var viewRouter: ViewRouter

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.seal.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(AppColors.checkmarkImageColor)
            
            Text("Register Success")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Your account has been successfully created.")
                .font(.system(size: 16, weight: .light))
                .foregroundColor(.gray)
                .padding(.top, -12)
            
            Button(action: {
                viewRouter.currentPage = "HomePageView"
            }) {
                Text("Start Now")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppColors.primaryColor)
                    .cornerRadius(8)
            }.padding(.top, 24).padding(.horizontal, 56) // Ensure button has a maximum size by limiting horizontal padding
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true) // Optionally hide the navigation bar
    }
}

