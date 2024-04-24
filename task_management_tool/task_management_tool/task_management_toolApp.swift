//
//  task_management_toolApp.swift
//  task_management_tool
//
//  Created by i564407 on 11/14/23.
//

import SwiftUI

@main
struct task_management_toolApp: App {
    @StateObject private var viewRouter: ViewRouter

    init() {
        _viewRouter = StateObject(wrappedValue: ViewRouter(startPage: UserDefaults.standard.bool(forKey: UserDefaultsKeys.appUserLogin) ? "HomePageView" : "WelcomeView"))
//        setupNavigationBarAppearance()

    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewRouter)
        }
    }
    
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        // 定义渐变色
        let colors = [AppColors.secondaryColor.cgColor!, AppColors.primaryColor.cgColor!]  // 渐变色
        if let gradientImage = UIImage.gradientImage(with: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100), colors: colors, locations: [0, 1], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0.5, y: 1)) {
            appearance.backgroundImage = gradientImage
        }
        // 设置普通状态下的标题属性
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 18, weight: .bold), // 更改字体样式和大小
            .foregroundColor: UIColor.white // 更改字体颜色
        ]

        // 设置大标题的属性（如果你的导航栏使用了大标题）
        appearance.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 34, weight: .bold), // 更改字体样式和大小
            .foregroundColor: UIColor.white // 更改字体颜色
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
