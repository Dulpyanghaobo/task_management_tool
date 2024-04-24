//
//  ActionGenerateView.swift
//  task_management_tool
//
//  Created by i564407 on 4/22/24.
//
import SwiftUI

struct RingView: View {
    var colors: [Color]
    var progress: Double
    var lineWidth: Double = 32
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(0.3)
                .foregroundColor(.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .fill(LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)) // 修改渐变方向
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
        }
    }
}


struct ActionGenerateView: View {
    @State private var workEnvironment: Double = 0.5
    @State private var moodEnergy: Double = 0.5
    @State private var workPressure: Double = 0.5
    @EnvironmentObject var viewRouter: ViewRouter

    var body: some View {
        ZStack {
            DynamicBackgroundView()
            
            VStack {
                ZStack {
                    RingView(colors: [.red, .purple, .green, .yellow, .brown], progress: workEnvironment)
                        .frame(width: 300, height: 300)
                    
                    RingView(colors: [.green, .yellow], progress: moodEnergy)
                        .frame(width: 250, height: 250)
                    
                    RingView(colors: [.red, .orange], progress: workPressure)
                        .frame(width: 200, height: 200)
                    // 第二层：中心文本
                    Text("总体进度")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                }
                .padding()
                Spacer()
                
                VStack {
                    ForEach([
                        ("工作环境", $workEnvironment),
                        ("情绪能量", $moodEnergy),
                        ("工作压力", $workPressure)
                    ], id: \.0) { setting in
                        HStack {
                            Text(setting.0).font(.system(size: 12, weight: .regular))
                                .foregroundColor(.gray)
                            Spacer()
                            Text(String(format: "0.4"))
                        }.padding(.bottom, -8)
                        Slider(value: setting.1, in: 0...1)
                            .tint(Color.blue.opacity(0.5))
                    }
                }
                .padding(.horizontal, 16)
                Spacer()
                Button("Start Now", action: {
                    viewRouter.currentPage = "ActionModeView"
                })
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [AppColors.primaryColor, AppColors.secondaryColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(8)
                .padding(.horizontal, 16)
                
            }
        }
    }
}

struct DynamicBackgroundView: View {
    @State private var isAnimating = false
    let colors1: [Color] = [.white, .gray]
    let colors2: [Color] = [.pink, .purple]
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: isAnimating ? colors1 : colors2), startPoint: .topLeading, endPoint: .bottomTrailing)
            .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
            .onAppear {
                isAnimating.toggle()
            }
            .ignoresSafeArea()
    }
}
