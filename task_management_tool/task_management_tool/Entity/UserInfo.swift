//
//  UserInfo.swift
//  task_management_tool
//
//  Created by i564407 on 4/17/24.
//

import SwiftUI

struct UserInfo: Decodable {
    var name: String = "Hab Yang"
    var age: Int = 26
    var avatar: String = "https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg"
    var bodyInfo: UserBodyInfo = UserBodyInfo()
    var emotionalStatusInfo: EmotionalStatusInfo = EmotionalStatusInfo()
    var userControlState: UserControlState = UserControlState()
    var topic: [WeekStatusTopic] = [WeekStatusTopic.init(topic: "Interpersonal Communication"), WeekStatusTopic.init(topic: "Cyber Security"), WeekStatusTopic.init(topic: "WFH Policies")]
    var activityDetails: [ActivityDetail] = [ActivityDetail(completeStatus: .sLevel, description: "Earned Gold Certification in Change Management", completeDate: "May 1, 2022 • 5/5 Correct"),
        ActivityDetail(completeStatus: .aLevel, description: "Completed Advanced Python Programming Course", completeDate: "April 15, 2022 • 4/5 Correct"),
        ActivityDetail(completeStatus: .bLevel, description: "Attended Leadership Development Seminar", completeDate: "March 28, 2022 • 3/5 Correct"),
        ActivityDetail(completeStatus: .cLevel, description: "Participated in Team Building Workshop", completeDate: "February 10, 2022 • 2/5 Correct"),
        ActivityDetail(completeStatus: .completed, description: "Finished Project Management Basics Course", completeDate: "January 5, 2022 • Completed"),
        ActivityDetail(completeStatus: .inProgress, description: "Enrolled in Data Science Bootcamp", completeDate: "In Progress"),
        ActivityDetail(completeStatus: .sLevel, description: "Achieved Top Sales Performance for Q4", completeDate: "December 31, 2021 • 5/5 Correct"),
        ActivityDetail(completeStatus: .aLevel, description: "Completed Agile Methodology Training", completeDate: "November 20, 2021 • 4/5 Correct"),
        ActivityDetail(completeStatus: .bLevel, description: "Attended Industry Conference as Speaker", completeDate: "October 15, 2021 • 3/5 Correct"),
        ActivityDetail(completeStatus: .cLevel, description: "Participated in Company Hackathon Event", completeDate: "September 8, 2021 • 2/5 Correct")]
    var achievements: Achievements = Achievements()
}

struct EmotionalStatusInfo: Decodable {
    var energyLevel: Int = 0
    var emotionalState: Double = 0.63
    var goalCompletionState: Double = 0.89
    var chakraLevel: Double = 0
    // 其他状态信息字段
}

struct UserControlState: Decodable {
    var healthyDietControl: Double = 0.28
    var assetControl: Double = 0.35
    var taskControl: Double = 0.40
}

struct WeekStatusTopic: Identifiable, Decodable {
    var id = UUID()
    var topic: String = ""
}

enum StatusControlType {
    case userControl(UserControlState)
    case weekTopic([WeekStatusTopic])
}

enum CompleteStatus: String, Decodable {
    case inProgress = "In Progress"
    case completed = "Completed"
    case cLevel = "C Level"
    case bLevel = "B Level"
    case aLevel = "A Level"
    case sLevel = "S Level"
}


struct ActivityDetail:Identifiable, Decodable {
    var id: UUID = UUID()
    
    var completeStatus: CompleteStatus
    var description: String
    var completeDate: String
    
    var statusImage: String {
        switch completeStatus {
        case .inProgress:
            return "medal.fill"
        case .completed:
            return "medal.fill"
        case .cLevel:
            return "medal.fill"
        case .bLevel:
            return "medal.fill"
        case .aLevel:
            return "medal.fill"
        case .sLevel:
            return "medal.fill"
        }
    }
}

struct Achievements: Decodable {
    var level: Int = 2
    var pointsToNextLevel: Int = 500
    var experiencePoints: Int = 5200
    var totalExperiencePoints: Int = 6000
    var medals: Medals = Medals()
    var certifications: [String] = ["Food Safety Protocols", "Facilities & Maintenance", "Safety & Security"]
    var badges: [Badge] = [
        Badge(name: "Quiz Genius", description: "Passed 500 Quizzes"),
        Badge(name: "Ace", description: "Earned perfect scores on 25 quizzes"),
        Badge(name: "Bronze Standard", description: "Score 90% or above on 100 quizzes")
    ]
}

struct Medals: Decodable {
    var gold: Int = 5
    var silver: Int = 10
    var bronze: Int = 20
    var iron: Int = 30
}

struct Badge: Identifiable, Decodable {
    var id: UUID = UUID()
    var name: String
    var description: String
}
