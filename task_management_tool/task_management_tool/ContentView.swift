//
//  ContentView.swift
//  task_management_tool
//
//  Created by i564407 on 11/14/23.


import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        switch viewRouter.currentPage {
        case "HomePageView":
            HomePageView()
        case "WelcomeView":
            WelcomeView()
        case "RegisterResultView":
            RegisterResultView()
        case "OKRResultView":
            LandingPageView()
        case "ActionGenerateView":
            ActionGenerateView()
        case "ActionModeView":
            ActionModeView()
        case "TaskPageContentView":
            TaskPageContentView()
        default:
            Text("Unknown view")
        }
            
    }
}
