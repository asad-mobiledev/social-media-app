//
//  MockFileManager.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 10/10/2025.
//

import Foundation

class MockFileManager: FileManager {
    var fileExistsResult: [String: Bool] = [:]
    var createDirectoryError: Error?
    var createDirectoryResult: Bool = true
    var contentsOfDirectoryError: Error?
    var contentsOfDirectoryResult: [URL] = []
    var copyItemAtError: Error?
    var copyItemATResult: Bool = true
    var mockFolder = "mockFolder"
    
    override func fileExists(atPath path: String) -> Bool {
        fileExistsResult[path] ?? false
    }
    
    override func createDirectory(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey : Any]? = nil) throws {
        if let error = createDirectoryError {
            throw error
        }
        
        if !createDirectoryResult {
            throw NSError(domain: "MockError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to create directory"])
        }
    }
    
    override func contentsOfDirectory(at url: URL, includingPropertiesForKeys keys: [URLResourceKey]?, options mask: FileManager.DirectoryEnumerationOptions = []) throws -> [URL] {
        if let error = contentsOfDirectoryError {
            throw error
        }
        return contentsOfDirectoryResult
    }
    
    override func copyItem(at srcURL: URL, to dstURL: URL) throws {
        if let error = copyItemAtError {
            throw error
        }
        
        if !copyItemATResult {
            throw NSError(domain: "MockError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to copy items from source url to destination url"])
        }
    }
}
