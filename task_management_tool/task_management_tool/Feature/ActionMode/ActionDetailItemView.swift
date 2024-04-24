//
//  ActionDetailItemView.swift
//  task_management_tool
//
//  Created by i564407 on 4/22/24.
//

import SwiftUI

struct ActionDetailItemView: View {
    let item: ScheduleItem
    @State private var comment: String = ""
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                // Large image at the top
                if let firstImage = item.imageList.first {
                    Image(firstImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                }
                
                // Time range
                HStack {
                    Image(systemName: "star.fill")
                    Text(item.startTimeRange)
                    Text(item.endTimeRange)
                        Spacer()
                }
                .font(.subheadline)
                .foregroundColor(.gray)
                // Title
                Text(item.title)
                    .font(.title)
                    .fontWeight(.bold)
                VStack (alignment: .leading, spacing: 8){
                    HStack {
                        Image(systemName: "target")
                        Text("Booking options").font(.system(size: 16, weight: .black))
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top) {
                            ForEach(item.tagList, id: \.self) { tag in
                                HStack {
                                    Text(tag).font(.system(size: 14, weight: .black)).foregroundColor(.black)
                                    Image(systemName: "line.diagonal.arrow")
                                }.padding(.horizontal).padding(.vertical, 8).background(Color.blue.opacity(0.1)).cornerRadius(16)
                            }
                        }
                    }
                }


                VStack (alignment: .leading, spacing: 16){
                    HStack {
                        Image(systemName: "lightbulb.max.fill")
                        Text("Tips").font(.system(size: 16, weight: .black))
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(item.tipsList, id: \.self) { tip in
                            Text(tip)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.black)
                        }
                    }
                }

                VStack (alignment: .leading, spacing: 16){
                    HStack {
                        Image(systemName: "lightbulb.max.fill")
                        Text("Desciptions").font(.system(size: 16, weight: .black))
                    }
                    // Description
                    Text(item.description)
                        .font(.system(size: 12, weight: .regular))
                }
                // Comment section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Comments")
                        .font(.headline)
                    
                    TextField("Add a comment...", text: $comment)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        // Handle comment submission
                        print("Comment submitted: \(comment)")
                        comment = ""
                    }) {
                        Text("Submit")
                            .foregroundColor(.white)
                            .padding()
                            .background(AppColors.secondaryColor)
                            .cornerRadius(8)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: BackButton())
        Button(action: {
            // Handle task status change
            print("Task status changed")
        }) {
            Text("Start")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(AppColors.primaryColor)
                .cornerRadius(8)
                .padding(.bottom, 16)
        }
    }
}

