//
//  ContentView.swift
//  task_management_tool
//
//  Created by i564407 on 11/14/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: TaskPageContentView()) {
                Text("Show Task Page")
            }
        }
    }
}


#Preview {
    ContentView()
}
