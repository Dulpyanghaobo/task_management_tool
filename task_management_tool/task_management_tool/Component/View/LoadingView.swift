//
//  LoadingView.swift
//  task_management_tool
//
//  Created by i564407 on 5/13/24.
//

import SwiftUI

struct LoadingView: View {
    var text: String?
    
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(1.5)
            
            if let text = text {
                Text(text)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct LoadingModifier: ViewModifier {
    var isLoading: Bool
    var text: String?
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isLoading {
                LoadingView(text: text)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.8))
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

extension View {
    func withLoading(isLoading: Bool, text: String? = nil) -> some View {
        self.modifier(LoadingModifier(isLoading: isLoading, text: text))
    }
}
