//
//  NavigationConfigurator.swift
//  task_management_tool
//
//  Created by i564407 on 4/18/24.
//

import SwiftUI

struct GradientNavigationView<Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        NavigationView {
            content()
                .navigationBarTitle("Gradient Nav Bar", displayMode: .inline)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing)
                        .edgesIgnoringSafeArea(.all)
                )
        }
    }
}

