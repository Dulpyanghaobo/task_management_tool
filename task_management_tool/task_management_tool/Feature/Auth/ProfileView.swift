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
    let user: UserInfo = UserInfo(name: "John Doe", avatar: "person.fill")
    
    var body: some View {
        NavigationView {
            
            ZStack(alignment: .topTrailing) {
                ScrollView {
                    VStack {
                        // User Info Section
                        VStack {
                            NetworkImageView(urlString: "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg")
                            Text(user.name)
                                .font(.title)
                                .padding()
                        }
                        .padding([.top, .leading, .trailing])
                        
                        // Segment Control
                        CustomSegmentedControl(selectedSegment: $selectedSegment)
                        
                        DetailView(selectedSegment: $selectedSegment)
                    }
                }.background(AppColors.systemBackgroundColor)
                
                Button(action: {
                    self.isActive = true
                    
                    //                let userManager = NetworkManager<TestService>()
                    //                userManager.request(target: .test) { (result: Result<TestModel, NetworkError>) in
                    //                    switch result {
                    //                    case .success(let user):
                    //                        print("User: \(user)")
                    //                    case .failure(let error):
                    //                        print("Error: \(error)")
                    //                    }
                    //                }
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
            }.navigationBarHidden(true)  // 隐藏导航栏
        }

    }
}

struct DetailView: View {
    @Binding var selectedSegment: Int
    
    var body: some View {
        Group {
            switch selectedSegment {
            case 0:
                Text("Status details here")
            case 1:
                Text("Activity details here")
            case 2:
                Text("Achievements details here")
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
                    .foregroundColor(selectedSegment == index ? AppColors.segmentFontColor : AppColors.unselectedColor)
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
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}

