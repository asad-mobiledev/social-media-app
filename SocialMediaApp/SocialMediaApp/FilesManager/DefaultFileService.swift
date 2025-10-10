//
//  FilesManager.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 10/09/2025.
//
import Foundation
import UIKit

enum Directory {
    case documents
    case caches
    case temporary

    var url: URL? {
        let fileManager = FileManager.default

        switch self {
        case .documents:
            return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        case .caches:
            return fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
        case .temporary:
            return fileManager.temporaryDirectory
        }
    }
}


class DefaultFileService: FileService {
    let fileManager = FileManager.default
    let directory: Directory
    
    init(directory: Directory) {
        self.directory = directory
    }
    
    func save(mediaType: MediaType, mediaURL: URL?) throws -> String {
        guard mediaURL != nil else {
            throw RepositoryError.urlNil
        }
        return try saveFileFrom(sourceURL: mediaURL!, folder: mediaType.rawValue) ?? ""
    }
    
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
