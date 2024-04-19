//
//  App+Common.swift
//  task_management_tool
//
//  Created by i564407 on 4/18/24.
//

import Foundation
import UIKit

var statusBarHeight: CGFloat {
    let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
}

var ScreenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

