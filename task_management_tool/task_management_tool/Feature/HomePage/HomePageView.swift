//
//  HomePageView.swift
//  task_management_tool
//
//  Created by i564407 on 4/17/24.
//

import SwiftUI

struct HomePageView: View {
    @State private var selectedTab: String = "home"  // 默认选中的标签

    var body: some View {
        VStack(spacing: 0) {
            // Content area
            ZStack {
                switch selectedTab {
                case "home":
                    OKRContentView()
                case "tasks":
                    TaskPageContentView()
                case "goal":
                    GoalTypeSelectionView()
                case "profile":
                    ProfileView()
                default:
                    Text("Unknown tab")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Custom Tab Bar
            CustomTabBar(selectedTab: $selectedTab)
                .frame(height: 84)  // 设置高度为84
                .padding(.horizontal)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .edgesIgnoringSafeArea(.bottom)  // 确保填充到底部边缘
                .offset(y: -8)
        }
        .edgesIgnoringSafeArea(.bottom)  // 对整个 VStack 应用，确保无间隙
        .background(AppColors.systemBackgroundColor)
    }
}


    struct CustomTabBar: View {
        @Binding var selectedTab: String
        var body: some View {
            HStack {
                TabBarButton(icon: "house.fill", selectedTab: $selectedTab, assignedTab: "home").offset(x: -8)
                TabBarButton(icon: "checkmark.seal.fill", selectedTab: $selectedTab, assignedTab: "tasks").offset(x: -8)
                CenterTabBarButton().zIndex(1)
                TabBarButton(icon: "trophy.fill", selectedTab: $selectedTab, assignedTab: "goal").offset(x: 8)
                TabBarButton(icon: "person.fill", selectedTab: $selectedTab, assignedTab: "profile").offset(x: 8)
            }
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }

    struct TabBarButton: View {
        let icon: String
        @Binding var selectedTab: String
        let assignedTab: String
        @State private var isAnimating = false  // 用于跟踪是否应该触发动画

        var body: some View {
            Button(action: {
                // 触发动画
                withAnimation(.default) {
                    isAnimating = true
                }
                // 延迟重置动画状态
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    isAnimating = false
                }
                selectedTab = assignedTab
            }) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(selectedTab == assignedTab ? .blue : .gray)
                    .rotationEffect(.degrees(isAnimating ? 15 : 0))  // 应用旋转角度
                    .animation(.easeInOut(duration: 0.15).repeatCount(3, autoreverses: true), value: isAnimating)  // 抖动效果
            }
            .frame(maxWidth: .infinity)
        }
    }

    struct CenterTabBarButton: View {
        
        @State private var animateOuterRings = false

        var body: some View {
                Button(action: {
                    print("Center button tapped!")
                }) {
                    Image(systemName: "poweroutlet.type.f.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.blue))
                        .overlay(
                            ZStack {
                                ForEach(0..<3) { index in
                                    Circle()
                                        .stroke(Color.blue.opacity(0.6), lineWidth: 3)
                                        .scaleEffect(animateOuterRings ? 1.5 : 1)
                                        .opacity(animateOuterRings ? 0 : 0.6)
                                        .animation(
                                            Animation.easeOut(duration: 1.5)
                                                .delay(Double(index) * 0.2)
                                                .repeatForever(autoreverses: false),
                                            value: animateOuterRings
                                        )
                                }
                            }
                        )
                        .shadow(radius: 5)
                        .onAppear {
                            animateOuterRings = true
                        }
                }
                .frame(width: 70, height: 70)
            }
    }


#Preview {
    HomePageView()
}
