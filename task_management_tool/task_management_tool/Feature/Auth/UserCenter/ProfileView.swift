//
//  ProfileView.swift
//  task_management_tool
//
//  Created by i564407 on 4/17/24.
//

import SwiftUI
import SwiftUI

struct ProfileView: View {
    @State private var isActive = false

    @State private var selectedSegment = 0
    let user: UserInfo = UserInfo(name: "Hab Yang", avatar: "https://dulpyhb-1319648537.cos.ap-shanghai.myqcloud.com/Butler%2FProfile%2FWechatIMG1296.jpg")
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                    VStack {
                        // User Info Section
                        VStack {
                            NetworkImageView(urlString: user.avatar)
                            Text(user.name).font(.system(size: 24,weight: .bold))
                        }
                        .padding([.top, .leading, .trailing])
                        
                        // Segment Control
                        CustomSegmentedControl(selectedSegment: $selectedSegment)
                        
                        DetailView(selectedSegment: $selectedSegment, userInfo: user)
                    }
                    
                
                Button(action: {
                    self.isActive = true
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding() // Add padding to make the button easier to tap
                }
                
                .padding(.trailing, 20) // Right padding for button alignment
                .padding(.top, -8)

                NavigationLink(
                    destination: SettingsView(),
                    isActive: $isActive
                ) {
                    EmptyView()
                }
                .hidden()
            }
            .background(
                Image("background")  // 替换 "backgroundImageName" 为您的图片资源名
                    .resizable()  // 确保图片可以调整大小以适应容器
                    .scaledToFill()  // 填充整个可用空间，可能会裁剪图片
                    .edgesIgnoringSafeArea(.all)  // 让背景图片延伸到安全区域之
            )
            .navigationBarHidden(true)  // 隐藏导航栏
        }
    }
}

struct DetailView: View {
    @Binding var selectedSegment: Int
    
    var userInfo :UserInfo
    
    var body: some View {
        Group {
            switch selectedSegment {
            case 0:
                StatusView(emotionalStatusInfo: userInfo.emotionalStatusInfo, userControlState: userInfo.userControlState, topic: userInfo.topic)
            case 1:
                AchievementsView(achievements: userInfo.achievements)
            case 2:
                ActivityDetailView(activityDetails: userInfo.activityDetails)
            default:
                Text("Unknown selection")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CustomSegmentedControl: View {
    @Binding var selectedSegment: Int
    let titles = ["Status", "Achievements", "Activity"]
    
    var body: some View {
        HStack {
            ForEach(titles.indices, id: \.self) { index in
                Text(titles[index])
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(selectedSegment == index ? AppColors.primaryColor : AppColors.unselectedColor)
                    .padding()
                    .background(Color.clear)
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation {
                            selectedSegment = index
                        }
                    }
            }
        }
        .padding(.horizontal)
    }
}

