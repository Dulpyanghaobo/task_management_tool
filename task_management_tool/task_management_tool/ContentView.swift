//
//  ContentView.swift
//  task_management_tool
//
//  Created by i564407 on 11/14/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TaskPageContentView().tabItem {
                Label("任务管理", systemImage: "list.bullet")
            }
            TimeContentView().tabItem {
                Label("时间管理", systemImage: "clock")
            }
        }

    }
}


#Preview {
    ContentView()
}
