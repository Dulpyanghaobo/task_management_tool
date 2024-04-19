//
//  UserInfo.swift
//  task_management_tool
//
//  Created by i564407 on 4/17/24.
//

import SwiftUI

struct UserInfo: Decodable {
    var name: String = "Hab"
    var age: Int = 26
    var avatar: String = "person.fill"
    var bodyInfo: UserBodyInfo = UserBodyInfo()
}
