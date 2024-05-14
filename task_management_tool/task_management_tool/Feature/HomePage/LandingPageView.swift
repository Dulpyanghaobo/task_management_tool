//
//  OKRContentView.swift
//  task_management_tool
//
//  Created by i564407 on 11/16/23.
//

import SwiftUI

struct LandingPageView: View {
    @State private var showMoodSelection = false

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ScrollViewReader { value in
                    
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 24) {
                        HeaderSection().id("top")
                        MoodSelectionSection(showMoodSelection: $showMoodSelection)
                        // 今日任务
                        TodayTaskSection()

                        // 进行中的任务
                        InProgressSection()
                        
                        // 任务组
                        TaskGroupsSection()
                        
                        // 年度OKR
                        AnnualOKRSection()
                        
                        // 返回顶部按钮
                        ScrollToTopButton(scrollTo: { value.scrollTo("top", anchor: .top) })  // 将滚动功能传递到按钮
                    }.padding()  // 移除水平内边距
                }
            }
            .background(
                Image("background")  // 替换 "backgroundImageName" 为您的图片资源名
                    .resizable()  // 确保图片可以调整大小以适应容器
                    .scaledToFill()  // 填充整个可用空间，可能会裁剪图片
                    .edgesIgnoringSafeArea(.all)  // 让背景图片延伸到安全区域之
            )
            
        }.sheet(isPresented: $showMoodSelection) {
            MoodSelectionView()
        }

    }
        
}

struct HeaderSection: View {
    
    @State var hasNotifications: Bool = true  // 假设有未读通知，您可以根据实际情况动态改变这个状态
    @State var isAnimating: Bool = false
    
    var body: some View {
        HStack(spacing: 8){
            Image("Welcome_Image").resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 42, height: 42)
            VStack(alignment: .leading, spacing: 4) {
                Text("Hello!").font(.system(size: 14,weight: .regular))
                Text("Hab Yang").bold()
            }
            
            Spacer()
            
                Button(action: {
                    // 触发动画
                    withAnimation(.default) {
                        isAnimating = true
                    }
                    // 延迟重置动画状态
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isAnimating = false
                    }
                }) {
                    ZStack(alignment: .topTrailing) {

                    Image(systemName: "bell.fill")
                        .foregroundColor(.black)
                        .padding().rotationEffect(.degrees(isAnimating ? 15 : 0))  // 应用旋转角度
                        .animation(.easeInOut(duration: 0.15).repeatCount(3, autoreverses: true), value: isAnimating)  // 抖动效果
                    // 条件添加小红点
                    if hasNotifications {
                        Circle()
                            .fill(AppColors.primaryColor)
                            .frame(width: 8, height: 8)
                            .offset(x: -16, y: 12)  // 根据需要调整偏移量来定位小红点
                    }
                }
            }
        }
    }
}

struct TodayTaskSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center, spacing: 8) {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Your today's task almost done!")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .regular))
                    
                    Button(action: {
                        // View task action
                    }) {
                        Text("View Task")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.horizontal, 20).padding(.vertical, 12)
                            .background(Color.white)
                            .foregroundColor(AppColors.tabbarTintColor)
                            .cornerRadius(8)
                    }
                }
                .frame(maxWidth: .infinity)  // 确保填充父容器宽度
                .padding()
                .padding(.vertical, 12)
                
                ZStack {
                    RingView(colors: [.white], progress: 0.7, lineWidth: 8)
                        .frame(width: 82, height: 82)
                    
                    Text("\(Int(0.7 * 100))%")  // Calculate progress as a percentage
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .bold()
                }
                Spacer(minLength: 48) // 可以控制这个Spacer的大小或移除

                Button(action: {
                    // 显示更多选项
                }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white) // 设置图标颜色
                        .frame(width: 22, height: 22) // 设置正方形的尺寸
                        .background(AppColors.tabbarBackgroundColor.opacity(0.5)) // 添加背景
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.trailing, 16)  // 确保按钮靠右并有间隔
                .padding(.top, -56)
            }
            .frame(maxWidth: .infinity)  // 确保 HStack 填充父容器的宽度
            .background(AppColors.tabbarTintColor)
            .cornerRadius(24)
        }
        .padding(.horizontal, 0)  // 将这个部分的水平内边距设置回来
    }
}


struct InProgressSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 4) {
                Text("In Progress").font(.system(size: 22, weight: .semibold))
                Text("3").font(.system(size: 12, weight: .medium)).frame(width: 16, height: 16)  .foregroundColor(AppColors.tabbarTintColor).background(AppColors.tabbarBackgroundColor.opacity(8)) .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<3) { _ in
                        InProgressTaskCard()
                    }
                }
            }
        }
    }
}

struct InProgressTaskCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Office project").foregroundColor(AppColors.FifthTitleColor).font(.system(size: 14, weight: .regular))
                Spacer()
                Image(systemName: "star.fill").frame(width: 32, height: 32).background(AppColors.homePageProgress2Color).foregroundColor(AppColors.homePageProgress2TintIconColor).cornerRadius(8)
            }
            Text("Grocery shopping app design").font(.system(size: 16, weight: .semibold))
            ProgressView(value: 0.5)
                .progressViewStyle(LinearProgressViewStyle()).lineSpacing(8)
            // 添加更多详细信息和样式
        }
        .padding()
        .frame(width: 250)
        .background(AppColors.homePageProgress1Color)
        .cornerRadius(16)
    }
}

struct TaskGroupsSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 4) {
                Text("Task Groups").font(.system(size: 22, weight: .semibold))
                Text("4").font(.system(size: 12, weight: .medium)).frame(width: 16, height: 16)  .foregroundColor(AppColors.tabbarTintColor).background(AppColors.tabbarBackgroundColor.opacity(8)) .clipShape(RoundedRectangle(cornerRadius: 8))
                Spacer()
                NavigationLink(destination: AddTaskOKRView(onSave: { task in
                    
                })) {
                    Image(systemName: "plus.circle.fill").foregroundColor(AppColors.primaryColor).font(.system(size: 22, weight: .bold))
                }
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(0..<3) { _ in
                        TaskGroupCard()
                    }
                }
            }
        }
    }
}

struct TaskGroupCard: View {
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
                Image(systemName: "star.fill").frame(width: 36, height: 36).background(AppColors.homePageProgress2Color).foregroundColor(AppColors.homePageProgress2TintIconColor).cornerRadius(8)
            VStack(alignment: .leading,spacing: 4) {
                Text("Office project").font(.system(size: 16, weight: .semibold))
                Text("23 Tasks").font(.system(size: 14, weight: .regular)).foregroundColor(AppColors.FifthTitleColor)
            }
            Spacer()
            RingView(colors: [AppColors.homePageProgress2TintIconColor], progress: 0.5, lineWidth: 4).frame(width: 42, height: 42)
            // 添加更多详细信息和样式
        }
        .padding()
        .background(AppColors.whiteColor)
        .cornerRadius(16)
    }
}

struct AnnualOKRSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 4) {
                Text("OKR").font(.system(size: 22, weight: .semibold))
                Text("4").font(.system(size: 12, weight: .medium)).frame(width: 16, height: 16)  .foregroundColor(AppColors.tabbarTintColor).background(AppColors.tabbarBackgroundColor.opacity(8)) .clipShape(RoundedRectangle(cornerRadius: 8))
                Spacer()
                NavigationLink(destination: AddTaskOKRView(onSave: { task in
                    
                })) {
                    Image(systemName: "plus.circle.fill").foregroundColor(AppColors.primaryColor).font(.system(size: 22, weight: .bold))
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<3) { _ in
                        OKRGroupCard()
                    }
                }
            }
        }
    }
}
struct OKRGroupCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(systemName: "star.fill").frame(width: 56, height: 56).background(AppColors.homePageProgress2Color).foregroundColor(AppColors.homePageProgress2TintIconColor).cornerRadius(8)
            Text("Office project").foregroundColor(AppColors.FifthTitleColor).font(.system(size: 14, weight: .regular))
            Text("Grocery shopping app design").font(.system(size: 16, weight: .semibold))
            Spacer()
            Text("Reminder").foregroundColor(AppColors.FifthTitleColor).font(.system(size: 12, weight: .regular))
            Text("Every Day").foregroundColor(AppColors.FifthTitleColor).font(.system(size: 12, weight: .semibold))
        }
        .padding()
        .background(AppColors.homePageProgress1Color)
        .cornerRadius(16)
    }
}

struct MoodSelectionSection: View {
    @Binding var showMoodSelection: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("How do you feel today?").font(.system(size: 20, weight: .semibold))
            HStack(alignment: .center, spacing: 16) {
                ForEach(0..<5) { index in
                    Image("mood\(index)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                            showMoodSelection = true
                        }
                }
            }.padding(.horizontal, 16)
        }.padding().background(.white).cornerRadius(24).shadow(color: .gray, radius: 1, x: 1, y: 3)
    }
}

struct ScrollToTopButton: View {
    let scrollTo: () -> Void  // 接收一个闭包，用于滚动动作

    var body: some View {
        Button(action: {
            scrollTo()
        }) {
            Text("Back Top")
                .foregroundColor(.white)
                .padding()
                .frame(width: 120, height: 42)
                .background(AppColors.primaryColor)
                .cornerRadius(8)
        }
    }
}

