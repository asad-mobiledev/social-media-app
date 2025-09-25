//
//  SendImageModel.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 17/09/2025.
//

import UIKit

class ImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var errorMessage: String?
    let loadImageDataUseCase: ImageUseCase
    let url: URL
    
    init(loadImageDataUseCase: ImageUseCase, url: URL) {
        self.loadImageDataUseCase = loadImageDataUseCase
        self.url = url
    }
    
    func fetchImage() {
        do {
            let data = try loadImageDataUseCase.loadImage(url: url)
            if let image = UIImage(data: data) {
                self.image = image
            } else {
                self.errorMessage = "Unable to covert Data to image"
            }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
