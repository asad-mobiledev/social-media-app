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
    
    init(loadImageDataUseCase: ImageUseCase) {
        self.loadImageDataUseCase = loadImageDataUseCase
    }
    
    func fetchImage(localUrl: URL) {
        do {
            let data = try loadImageDataUseCase.loadImage(url: localUrl)
            if let image = UIImage(data: data) {
                self.image = image
            } else {
                self.errorMessage = "Unable to covert Data to image"
            }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func fetchImage(imageName: String, mediaType: MediaType = .image) {
        do {
            let data = try loadImageDataUseCase.loadImage(name: imageName, mediaType: mediaType)
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
