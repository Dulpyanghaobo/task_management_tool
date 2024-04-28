//
//  Achievements.swift
//  task_management_tool
//
//  Created by i564407 on 4/28/24.
//

import SwiftUI

struct AchievementsView: View {
    var achievements: Achievements
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Level Section
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Level \(achievements.level)")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(achievements.pointsToNextLevel) points to next level")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    ProgressView(value: Double(achievements.experiencePoints), total: Double(achievements.totalExperiencePoints))
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .padding(.top, 4)
                    
                    HStack {
                        Text("Level \(achievements.level)")
                            .font(.caption)
                        Spacer()
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(achievements.experiencePoints)/\(achievements.totalExperiencePoints)")
                            .font(.caption)
                    }
                }.padding().background(.white).shadow(radius: 1).cornerRadius(24)
                
                // Medals Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("MEDALS")
                        .font(.headline)
                        .fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment:.center, spacing: 16) {
                            MedalView(count: achievements.medals.gold, type: "Gold")
                            MedalView(count: achievements.medals.silver, type: "Silver")
                            MedalView(count: achievements.medals.bronze, type: "Bronze")
                            MedalView(count: achievements.medals.iron, type: "Iron")
                        }
                    }
                }
                
                // Certifications Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("CERTIFICATIONS")
                        .font(.headline)
                        .fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(achievements.certifications, id: \.self) { certification in
                                CertificationsView(description: certification, image: "fireworks", certified: "certification").frame(maxWidth: 150)
                            }
                        }
                    }
                }
                
                // Badges Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("BADGES")
                        .font(.headline)
                        .fontWeight(.bold)
                        ForEach(achievements.badges) { badge in
                                HStack {
                                    Image(systemName: "star.fill")
                                    VStack(alignment: .leading) {
                                        Text(badge.name)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text(badge.description)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                }
                        }.frame(maxWidth: .infinity).padding().background(.white).cornerRadius(8).shadow(radius: 1)
                }
            }
            .padding()
        }
        .navigationBarTitle("Achievements")
    }
}

struct MedalView: View {
    var count: Int
    var type: String
    
    var body: some View {
        VStack {
            Text("\(count)")
                .font(.title)
                .fontWeight(.bold)
            Text(type)
                .font(.caption)
        }.padding(.horizontal, 50).padding(.vertical, 24).background(.white).cornerRadius(24).shadow(radius: 1)
    }
}

struct CertificationsView: View {
    var description: String
    var image: String
    var certified: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: image)
            Text("\(description)").font(.system(size: 14, weight: .semibold))
            Text("\(certified)").padding(.all, 4).font(.system(size: 14, weight: .semibold)).foregroundColor(.gray).background(.gray.opacity(0.5)).cornerRadius(8)
        }.padding().background(.white).cornerRadius(24)
    }
}
