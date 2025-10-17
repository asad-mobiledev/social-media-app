//
//  MockPostsListingRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

class MockPlayableRepository: PlayableRepository {
    var returnNilURL = false
    
    func load(name: String, mediaType: MediaType) -> URL? {
        if returnNilURL {
            return nil
        }
        return FileServiceTestHelper.createTestImageFile(fileName: name, folderName: mediaType.rawValue, directory: .documents)
    }
}
