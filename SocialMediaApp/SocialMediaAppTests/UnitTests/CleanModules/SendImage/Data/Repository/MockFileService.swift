//
//  MockFileService.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

class MockFileService: FileService {
    var fileManager = FileManager.default
    var errorToThrow: Error?
    func save(mediaType: MediaType, mediaURL: URL?) throws -> String {
        if let error = errorToThrow {
            throw error
        }
        return "test.png"
    }
    
    func createFolder(name: String) -> URL? {
        FileServiceTestHelper.createTestImageFile(fileName: "test.png", folderName: "test", directory: .documents)
    }
    
    func getDataOf(fileName: String, folder: String) throws -> Data {
        if let error = errorToThrow {
            throw error
        }
        return FileServiceTestHelper.createImageData()
    }
    
    func getFileURL(name: String, folder: String) -> URL? {
        if name.isEmpty || folder.isEmpty {
            return nil
        }
        if name == "test.mp3" {
            return FileServiceTestHelper.createTestAudioFile(fileName: "test.mp3", folderName: "test", directory: .documents)
        }
        return FileServiceTestHelper.createTestImageFile(fileName: "test.png", folderName: "test", directory: .documents)
    }
    
    func deleteFile(name: String, folder: String, directory: Directory = .documents) throws {
        if name.isEmpty || folder.isEmpty {
            throw CustomError.message("File name or folder name is empty")
        }
    }
    
    func listFiles(folder: String) -> [URL] {
        [FileServiceTestHelper.createTestImageFile(fileName: "test.png", folderName: "test", directory: .documents)!]
    }
    
    func saveFileFrom(sourceURL: URL, folder: String) throws -> String? {
        if let error = errorToThrow {
            throw error
        }
        return "test.png"
    }
    
    func getData(from url: URL) throws -> Data {
        if let error = errorToThrow {
            throw error
        }
        return FileServiceTestHelper.createImageData()
    }
}
