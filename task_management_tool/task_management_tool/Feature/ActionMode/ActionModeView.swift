//
//  ActionModeView.swift
//  task_management_tool
//
//  Created by i564407 on 4/22/24.
//

import SwiftUI

struct ActionModeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                ActionConfigView()
                ScheduleView()
                Spacer()
                BackHomeView()
            }.ignoresSafeArea(.all, edges: .top) // Ignore the top safe area
        }
    }
}

struct BackHomeView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        Button("Back Home", action: {
            viewRouter.currentPage = "HomePageView"
        })
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [AppColors.primaryColor, AppColors.secondaryColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(8)
        .padding(.horizontal, 16)
    }
}

struct ActionConfigView: View {
    
    var body: some View {
        Section(header: Text("")) {
            VStack {
                InspirationalImageView(model: InspirationalModel(
                    title: "Inspiration of the Day",
                    imageContent: UIImage(named: "task_move_action_back_image 1")!,  // 确保替换为有效的图片
                    description: "A short description of the inspirational thought.",
                    date: Date(),
                    theme: "Resilience"
                ))

                }
            }
        }
}

struct ScheduleView: View {
    var body: some View {
            Section(header: Text("")) {
                VStack(spacing: 32) {
                    ForEach(scheduleData, id: \.id) { item in
                        NavigationLink(destination: ActionDetailItemView(item: item)) {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Rectangle().fill(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom)).frame(width: 4)
                                    VStack(alignment: .leading, spacing: 12) {
                                        Text(item.startTimeRange)
                                            .frame(width: 100, alignment: .leading)
                                            .font(.system(size: 24, weight: .bold))
                                            .foregroundColor(.black)
                                        Text(item.endTimeRange)
                                            .frame(width: 100, alignment: .leading)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.black)
                                    }
                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack {
                                            Image(systemName: item.icon)
                                            Text(item.title)
                                                .font(.system(size: 16, weight: .bold))
                                                .background(GeometryReader { geometry in
                                                    Color.clear.preference(key: ViewOffsetKey.self, value: geometry.frame(in: .local).minX)
                                                })
                                                .foregroundColor(.black)
                                            Spacer()
                                        }
//                                        Text(item.description).font(.system(size: 12, weight: .regular)).foregroundColor(.gray)
                                    }
                                    Spacer()
                                }.padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .center) {
                                        ForEach(item.imageList, id: \.self) { imageName in
                                            Image(imageName)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 100)
                                        }
                                    }
                                    .padding(.leading, 136)
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .center) {
                                        ForEach(item.tagList, id: \.self) { tag in
                                            HStack {
                                                Text(tag).font(.system(size: 14, weight: .black)).foregroundColor(.black)
                                                Image(systemName: "line.diagonal.arrow")
                                            }.padding(.horizontal).padding(.vertical, 8).background(Color.blue.opacity(0.1)).cornerRadius(16)
                                        }
                                    }
                                    .padding(.leading, 136)
                                }
                            }
                        }
                    }
            }
        }
    }
}

// Custom preference key to read the horizontal offset
struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}



// 示例数据结构和模型
struct ScheduleItem {
    var id = UUID()
    var startTimeRange: String
    var endTimeRange: String
    var title: String
    var icon: String
    var tagList: [String]
    var description: String
    var imageList: [String]
    var tipsList: [String] = []
}

let scheduleData = [
    ScheduleItem(startTimeRange: "09:20", endTimeRange: "-10:50", title: "Flight to Milan", icon: "circle.dotted.circle.fill", tagList: ["Expedia", "Tripadvisor", "Museums", "Booking", "options"], description: "Note: The FlowLayout view used for the tag list is a custom layout that you would need to implement separately. You can find various implementations of flow layouts in SwiftUI online or create your own based on your specific requirements This implementation provides a starting point for the ActionDetailItemView based on the given requirements. You can further customize the styling, add more functionality, and handle user interactions as needed.", imageList: ["task_move_action_back_image 1","task_move_action_back_image 1"], tipsList: ["This implementation provides a starting point","This implementation provides a starting point","This implementation provides a starting point","This implementation provides a starting point","This implementation provides a starting point","This implementation provides a starting point"]),
    ScheduleItem(startTimeRange: "09:20", endTimeRange: "-10:50", title: "Flight to Milan", icon: "circle.dotted.circle.fill", tagList: ["Expedia", "Tripadvisor", "Museums", "Booking", "options"], description: "Note: The FlowLayout view used for the tag list is a custom layout that you would need to implement separately. You can find various implementations of flow layouts in SwiftUI online or create your own based on your specific requirements This implementation provides a starting point for the ActionDetailItemView based on the given requirements. You can further customize the styling, add more functionality, and handle user interactions as needed.", imageList: ["task_move_action_back_image 1","task_move_action_back_image 1"]),
    ScheduleItem(startTimeRange: "09:20", endTimeRange: "-10:50", title: "Flight to Milan", icon: "circle.dotted.circle.fill", tagList: ["Expedia", "Tripadvisor", "Museums", "Booking", "options"], description: "Note: The FlowLayout view used for the tag list is a custom layout that you would need to implement separately. You can find various implementations of flow layouts in SwiftUI online or create your own based on your specific requirements This implementation provides a starting point for the ActionDetailItemView based on the given requirements. You can further customize the styling, add more functionality, and handle user interactions as needed.", imageList: ["task_move_action_back_image 1","task_move_action_back_image 1"]),
    ScheduleItem(startTimeRange: "09:20", endTimeRange: "-10:50", title: "Flight to Milan", icon: "circle.dotted.circle.fill", tagList: ["Expedia", "Tripadvisor", "Museums", "Booking", "options"], description: "Note: The FlowLayout view used for the tag list is a custom layout that you would need to implement separately. You can find various implementations of flow layouts in SwiftUI online or create your own based on your specific requirements This implementation provides a starting point for the ActionDetailItemView based on the given requirements. You can further customize the styling, add more functionality, and handle user interactions as needed.", imageList: ["task_move_action_back_image 1","task_move_action_back_image 1"], tipsList: ["This implementation provides a starting point","This implementation provides a starting point","This implementation provides a starting point","This implementation provides a starting point","This implementation provides a starting point","This implementation provides a starting point"])
]
