//
//  InspirationModel.swift
//  task_management_tool
//
//  Created by i564407 on 4/22/24.
//

import Foundation
import UIKit

class InspirationalModel {
    let id = UUID()  // 添加UUID以支持Identifiable
    var title: String       // 大标题
    var imageContent: UIImage  // 图片内容
    var description: String // 描述文本
    var date: Date         // 时间日期
    var theme: String      // 今日主题

    // 初始化器
    init(title: String, imageContent: UIImage, description: String, date: Date, theme: String) {
        self.title = title
        self.imageContent = imageContent
        self.description = description
        self.date = date
        self.theme = theme
    }
}

