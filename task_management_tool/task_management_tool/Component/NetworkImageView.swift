//
//  NetworkImageView.swift
//  task_management_tool
//
//  Created by i564407 on 4/17/24.
//

import SwiftUI

struct NetworkImageView: View {
    @ObservedObject var loader = ImageLoader()
    let urlString: String
    
    var body: some View {
        Group {
            if loader.image != nil {
                loader.image?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72, height: 72)
                    .clipShape(Circle())
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72, height: 72)
                    .clipShape(Circle())
            }
        }
        .onAppear {
            loader.load(fromURLString: urlString)
        }
    }
}

