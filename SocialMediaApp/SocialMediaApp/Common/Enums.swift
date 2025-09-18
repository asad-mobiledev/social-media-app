//
//  Enums.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import Foundation

enum MediaType: String, Codable {
    case image, video, audio
}

enum LoadState {
    case unknown, loading, loaded(URL?), failed
}

extension LoadState {
    var isURLLoaded: Bool {
        if case .loaded(let url) = self, url != nil {
            return true
        }
        return false
    }
}

enum CustomError: Error {
    case message(String)
}
