//
//  MoodSelectionView.swift
//  task_management_tool
//
//  Created by i564407 on 4/29/24.
//

import SwiftUI

struct MoodSelectionView: View {
    @Environment(\.dismiss) var dismiss
    @State private var arrowRotation: Double = 0
    
    var selectedMood: MoodEnum {
        let normalizedRotation = arrowRotation
        switch normalizedRotation {
        case -90 ... -55:
            return .soSad
        case -55 ... -20:
            return .sad
        case -20 ... 15:
            return .normal
        case 15 ... 50:
            return .happy
        default:
            return .soHappy
        }
    }
    
    var moodText: String {
        let selectedMood = selectedMood
        switch selectedMood {
        case .soSad:
            return "soSad"
        case .sad:
            return "sad"
        case .normal:
            return "normal"
        case .happy:
            return "happy"
        case .soHappy:
            return "soHappy"
        }
    }
    
    var body: some View {
        VStack(alignment:.center, spacing: 16) {
            Spacer()
            Text("How do you feel today?").font(.system(size: 32, weight: .semibold))
            
            Image("mood\(selectedMood.rawValue)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 208, height: 208)
            Text(moodText).font(.system(size: 40, weight: .semibold))

            ZStack(alignment: .center) {
                Image("choose_face").resizable().aspectRatio(contentMode: .fill).frame(width: ScreenWidth - 96)
                Image("choose_arrow")
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(width: 52, height: 97)
                             .rotationEffect(.degrees(arrowRotation), anchor: .bottom)  // 指定旋转锚点为底部中心
                             .gesture(
                                 DragGesture()
                                     .onChanged { value in
                                         let rotation = value.translation.width / 10
                                         arrowRotation = max(-90, min(90, arrowRotation + rotation))
                                         print("arrowRotation\(arrowRotation)")
                                     }
                             )
                             .offset(y: -36)
            }.offset(y:48)
            Button(action: {
                dismiss()
            }, label: {
                Text("I feel \(moodText)").padding(.horizontal, 120).padding(.vertical, 16).foregroundColor(.white).background(AppColors.primaryColor).font(.system(size: 18, weight: .semibold)).cornerRadius(24)
            }).offset(y: -24)
        }
    }
}
