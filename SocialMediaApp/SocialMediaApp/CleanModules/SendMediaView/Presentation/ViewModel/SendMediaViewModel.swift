//
//  SendMediaViewModel.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 10/09/2025.
//
import Foundation
import Combine
import UIKit


class SendMediaViewModel: ObservableObject {
    private let sendMediaUseCase: SendMediaUseCase
    
    init(sendMediaUseCase: SendMediaUseCase) {
        self.sendMediaUseCase = sendMediaUseCase
    }
    
    func post(mediaType: MediaType, mediaURL: URL?) {
        Task {
            do {
                try await sendMediaUseCase.sendMedia(mediaType: mediaType, mediaURL: mediaURL)
            } catch {
                print(error)
            }
        }
    }
}
