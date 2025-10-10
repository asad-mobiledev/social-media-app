//
//  DefaultFileServiceTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 10/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct DefaultFileServiceTests {
    @Test(.tags(.fileService, .unit))
    func testDirectory() async throws {
        let documentsDirectory = Directory.documents
        let cachesDirectory = Directory.caches
        let temporaryDirectory = Directory.temporary
        
        #expect(documentsDirectory.url == FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)
        #expect(cachesDirectory.url == FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first)
        #expect(temporaryDirectory.url == FileManager.default.temporaryDirectory)
    }
    
    @Test(.tags(.fileService, .unit))
    func testInitialization() async throws {
        let directory: Directory = .documents
        let fileService = DefaultFileService(directory: directory)
        
        #expect(fileService != nil)
        #expect(fileService.directory == .documents)
        #expect(fileService.fileManager == FileManager.default)
    }
    
    @Test(.tags(.fileService, .unit))
    func testCreateFolderSuccess() async throws {
        let directory = Directory.documents
        
        // Given
        let service = DefaultFileService(directory: directory)
        let folderName = "testFolder"
        
        // When
        let folderURL = service.createFolder(name: folderName)
        
        // Then
        #expect(folderURL != nil)
        #expect(folderURL?.lastPathComponent == folderName)
    }
    
    @Test(.tags(.fileService, .unit))
    func testCreateFolderWithMultipleDirectories() async throws {
        // Given
        let directories: [Directory] = [Directory.documents, Directory.caches, Directory.temporary]
        let folderName = "testFolder"
        
        // When & Then
        for directory in directories {
            let service = DefaultFileService(directory: directory)
            let folderURL = service.createFolder(name: folderName)
            
            #expect(folderURL != nil)
            #expect(folderURL?.lastPathComponent == folderName)
        }
    }
    
    @Test(.tags(.fileService, .unit))
    func testSaveFileSuccess() async throws {
        // Given
        let directory = Directory.documents
        let service = DefaultFileService(directory: directory)
        let sourceURL = FileServiceTestHelper.createTestImageFile(in: .documents)
        let folder = "images"
       
        // When
        #expect(sourceURL != nil)
        let fileName = try service.saveFileFrom(sourceURL: sourceURL!, folder: folder)
        
        // Then
        #expect(fileName != nil)
        #expect(!fileName!.isEmpty)
        #expect(fileName!.contains("jpg"))
    }
    
    @Test(.tags(.fileService, .unit))
    func testSaveFileSuccessWithDifferentDirectories() async throws {
        // Given
        let directories: [Directory] = [Directory.documents, Directory.caches, Directory.temporary]
        let folder = "images"
       
        // When & Then
        for directory in directories {
            let service = DefaultFileService(directory: directory)
            let sourceURL = FileServiceTestHelper.createTestImageFile(in: .documents)
            #expect(sourceURL != nil)
            let fileName = try service.saveFileFrom(sourceURL: sourceURL!, folder: folder)
            
            #expect(fileName != nil)
            #expect(!fileName!.isEmpty)
            #expect(fileName!.contains("jpg"))
        }
    }
    
    @Test(.tags(.fileService, .unit))
    func testSaveFileErrorCase() async throws {
        // Given
        let directory = Directory.documents
        let service = DefaultFileService(directory: directory)
        let sourceURL = URL(fileURLWithPath: "documents/images/image.jpg")
        let folder = "images"
        
        // When & Then
        #expect(sourceURL != nil)
        #expect(throws: Error.self) {
            let fileName = try service.saveFileFrom(sourceURL: sourceURL, folder: folder)
            #expect(fileName != nil)
            #expect(!fileName!.isEmpty)
            #expect(fileName!.contains("jpg"))
        }
    }
    
    @Test(.tags(.fileService, .unit))
    func testSaveSuccess() async throws {
        let mediaURL = FileServiceTestHelper.createTestImageFile(in: .documents)
        let mediaType = MediaType.image
        let service = DefaultFileService(directory: .documents)
        
        let filePath = try service.save(mediaType: mediaType, mediaURL: mediaURL)
        
        #expect(filePath != nil)
        #expect(!filePath.isEmpty)
    }
    
    @Test(.tags(.fileService, .unit))
    func testSaveFailure() async throws {
        let mediaURL = URL(string: "documents/images/test.jpg")
        let mediaType = MediaType.image
        let service = DefaultFileService(directory: .documents)
        
        #expect(throws: Error.self) {
            try service.save(mediaType: mediaType, mediaURL: mediaURL)
        }
    }
    
    @Test(.tags(.fileService, .unit))
    func testGetDataOfSuccess() async throws {
        // Create file
        let testImageURL = FileServiceTestHelper.createTestImageFile(in: .documents)
        
        let service = DefaultFileService(directory: .documents)
        let fileName = "test.jpg"
        let folder = "test"
        let data = try service.getDataOf(fileName: fileName, folder: folder)
        
        #expect(data != nil)
        #expect(data.count > 0)
    }
    
    @Test(.tags(.fileService, .unit))
    func testGetDataOfFailure() async throws {
        // When file is not saved
        let service = DefaultFileService(directory: .documents)
        let fileName = "test.jpg"
        let folder = "test"
        let data = try service.getDataOf(fileName: fileName, folder: folder)
        
        #expect(data != nil)
        #expect(data.count > 0)
    }
    
    @Test(.tags(.fileService, .unit))
    func testGetFileURL() async throws {
        
        let service = DefaultFileService(directory: .documents)
        let fileName = "test.jpg"
        let folder = "test"
        let url = service.getFileURL(name: fileName, folder: folder)
        
        #expect(url != nil)
    }
    
    @Test(.tags(.fileService, .unit))
    func testListFiles() async throws {
        let folder = "image"
        let service = DefaultFileService(directory: .documents)
        
        let files = service.listFiles(folder: folder)
        
        #expect(files != nil)
    }
    
    @Test(.tags(.fileService, .unit))
    func testGetDataSuccess() async throws {
        let service = DefaultFileService(directory: .documents)
        let imageURL = FileServiceTestHelper.createTestImageFile(in: .documents)
        
        #expect(imageURL != nil)
        let data = try service.getData(from: imageURL!)
        #expect(data != nil)
        #expect(data.count > 0)
    }
    
    @Test(.tags(.fileService, .unit))
    func testGetDataFailure() async throws {
        let service = DefaultFileService(directory: .documents)
        let imageURL = URL(string: "documents/image/tes.png")!
        
        #expect(throws: Error.self) {
            let data = try service.getData(from: imageURL)
        }
    }
}
