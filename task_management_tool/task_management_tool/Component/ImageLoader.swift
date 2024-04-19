//
//  ImageLoader.swift
//  task_management_tool
//
//  Created by i564407 on 4/17/24.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: Image?
    
    func load(fromURLString urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = Image(uiImage: uiImage)
                }
            }
        }.resume()
    }
}
