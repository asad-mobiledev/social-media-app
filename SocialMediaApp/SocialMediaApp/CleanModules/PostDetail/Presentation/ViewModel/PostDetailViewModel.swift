//
//  Untitled.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 26/09/2025.
//

import Foundation
import Combine

class PostDetailViewModel: ObservableObject {
    let post: PostEntity
    
    init(post: PostEntity) {
        self.post = post
    }
}
