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
    
    @MainActor
    func fetchImage(localUrl: URL) {
        Task {
            do {
                let data = try await Task.detached(priority: .userInitiated) {
                    return try self.loadImageDataUseCase.loadImage(url: localUrl)
                }.value
                
                if let image = UIImage(data: data) {
                    self.image = image
                } else {
                    self.errorMessage = "Unable to convert data to image"
                }
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    @MainActor
    func fetchImage(imageName: String) {
        Task {
            do {
                let data = try await Task.detached(priority: .userInitiated) {
                    return try self.loadImageDataUseCase.loadImage(name: imageName)
                }.value
                
                if let image = UIImage(data: data) {
                    self.image = image
                } else {
                    self.errorMessage = "Unable to convert data to image"
                }
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
