//
//  Enums.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import Foundation
import SwiftUI

enum MediaType {
    case image, video, audio
}

enum LoadState {
    case unknown, loading, loaded(URL?, Image?), failed
}

extension LoadState {
    var isURLLoaded: Bool {
        if case .loaded(let url, _) = self, url != nil {
            return true
        }
        return false
    }

    var isImageLoaded: Bool {
        if case .loaded(_, let image) = self, image != nil {
            return true
        }
        return false
    }
}
