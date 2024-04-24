//
//  SettingsView.swift
//  task_management_tool
//
//  Created by i564407 on 4/19/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var brightness: Double = UIScreen.main.brightness

    var body: some View {
        VStack {
            List {
                // First Section: Personal Information Settings
                Section(header: Text("")) {
                    NavigationLink(destination: UserProfileView()) {
                        HStack {
                            Image("Welcome_Image")  // Assuming there's a user avatar image
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text("Hab Yang")
                                    .font(.system(size: 14, weight: .semibold)).foregroundColor(AppColors.SixthTitleColor)
                                Text("id, media and shopping")
                                    .font(.system(size: 14, weight: .light)).foregroundColor(AppColors.SixthTitleColor)

                            }
                        }
                    }
                }

                // Second Section: App Settings
                Section(header: Text("")) {
                    NavigationLink(destination: NotificationsSettingsView()) {
                        SettingItemRow(symbolsImageStr: "bell.badge", label: "Notifications")
                    }
                    NavigationLink(destination: SoundSettingsView()) {
                        SettingItemRow(symbolsImageStr: "headphones.circle", label: "Sound")
                    }
                    NavigationLink(destination: TouchFeedbackSettingsView()) {
                        SettingItemRow(symbolsImageStr: "square.and.pencil.circle", label: "Touch Feedback")
                    }
                    HStack {
                        Text("Brightness").font(.system(size: 12, weight: .regular)).foregroundColor(.black)
                        // Brightness adjustment is kept as a slider without NavigationLink
                        Slider(value: $brightness, in: 0...1, step: 0.01, onEditingChanged: { changed in
                            UIScreen.main.brightness = brightness
                        }) {
                            Text("Brightness")
                        }
                    }

                    
                }.onAppear {
                    // 初始化时同步亮度值
                    self.brightness = UIScreen.main.brightness
                }

                // Third Section: General
                Section(header: Text("")) {
                    NavigationLink(destination: HealthKitSettingsView()) {
                        SettingItemRow(symbolsImageStr: "gearshape", label: "General")
                    }
                    NavigationLink(destination: HealthKitSettingsView()) {
                        SettingItemRow(symbolsImageStr: "figure.walk.circle.fill", label: "HealthKit")
                    }
                    NavigationLink(destination: PrivacyPolicyView()) {
                        SettingItemRow(symbolsImageStr: "lock.badge.clock.fill", label: "Privacy Policy")
                    }
                    NavigationLink(destination: PrivacyPolicyView()) {
                        SettingItemRow(symbolsImageStr: "exclamationmark.bubble", label: "Report")
                    }
                    Toggle(isOn: .constant(true)) {
                        Text("Dark Mode")
                            .foregroundColor(AppColors.FifthTitleColor)
                            .font(.system(size: 14,weight: .regular))
                    }
                }
            }
            .listStyle(SidebarListStyle()) // This applies default system list styling
            
            Button(action: {
                UserDefaults.standard.set(false, forKey: UserDefaultsKeys.appUserLogin)
                viewRouter.currentPage = "WelcomeView"
            }) {
                    Text("Logout")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.red)
                        .cornerRadius(8)
                        .padding(.horizontal, 24)
                
            }
        }.background(AppColors.systemBackgroundColor).navigationBarTitle("Settings", displayMode: .inline)
        .navigationBarBackButtonHidden().navigationBarItems(leading: BackButton()) // Hides the navigation bar if desired
    }
}

// Helper View for setting items
struct SettingItemRow: View {
    var symbolsImageStr: String
    let label: String

    var body: some View {
        HStack {
            Image(systemName: symbolsImageStr)
            Text(label)
                .foregroundColor(AppColors.FifthTitleColor)
                .font(.system(size: 14,weight: .regular))
        }
    }
}
