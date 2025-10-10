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


/*
     func createFolder(name: String) -> URL? {
         guard let baseURL = directory.url else { return nil }
         let folderURL = baseURL.appendingPathComponent(name)
         
         if !fileManager.fileExists(atPath: folderURL.path) {
             do {
                 try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
             } catch {
                 print("\(AppText.failedCreateFolder) \(name): \(error)")
                 return nil
             }
         }
         return folderURL
     }
     
     func getDataOf(fileName: String, folder: String) throws -> Data {
         guard let folderURL = directory.url?.appendingPathComponent(folder) else {
             throw CustomError.message(AppText.unableToInitializeFolderURL + ": \(folder)")
         }
         let fileURL = folderURL.appendingPathComponent(fileName)
         return try Data(contentsOf: fileURL)
     }
     
     func getFileURL(name: String, folder: String) -> URL? {
         var folderURL = directory.url
         folderURL = folderURL?.appendingPathComponent(folder)
         return folderURL?.appendingPathComponent(name)
     }
     
     func listFiles(folder: String) -> [URL] {
         guard let folderURL = directory.url?.appendingPathComponent(folder) else { return [] }


         do {
             return try fileManager.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
         } catch {
             print("\(AppText.failedListFilesFromFolder): \(folder) \(error)")
             return []
         }
     }
     
     func saveFileFrom(sourceURL: URL, folder: String) throws -> String? {
         
         guard let folderURL = createFolder(name: folder) else { return nil }
         
         let sourceFileExtension = sourceURL.pathExtension
         let newFileName = UUID().uuidString
         let fullFileName = "\(newFileName).\(sourceFileExtension)"
         
         let destinationURL = folderURL.appendingPathComponent(fullFileName)
         
         if !fileManager.fileExists(atPath: destinationURL.path) {
             do {
                 try fileManager.copyItem(at: sourceURL, to: destinationURL)
             } catch {
                 if sourceURL.startAccessingSecurityScopedResource() {
                     defer { sourceURL.stopAccessingSecurityScopedResource() }
                     try fileManager.copyItem(at: sourceURL, to: destinationURL)
                 } else {
                     throw CustomError.message(AppText.filesPermissionIssue)
                 }
             }
         } else {
             throw RepositoryError.fileAlreadyExist
         }
         return fullFileName
     }
     
     func getData(from url: URL) throws -> Data {
         do {
             return try Data(contentsOf: url)
         } catch {
             if url.startAccessingSecurityScopedResource() {
                 defer { url.stopAccessingSecurityScopedResource() }
                 return try Data(contentsOf: url)
             } else {
                 throw CustomError.message(AppText.failLoadDataAtGivenURL)
             }
         }
         
     }
 }


 */
