//
//  FilesManager.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 10/09/2025.
//
import Foundation

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


class FilesRepository: FilesRepositoryProtocol {
    
    let fileManager = FileManager.default
    
    func createFolder(name: String, directory: Directory) -> URL? {
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
    
    func saveFile(name: String, data: Data, folder: String, directory: Directory) -> URL? {
        guard let folderURL = createFolder(name: folder, directory: directory) else { return nil }
        let fileURL = folderURL.appendingPathComponent(name)
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("\(AppText.failedSaveFile) \(name): \(error)")
            return nil
        }
    }
    
    func readFile(name: String, folder: String, directory: Directory) -> Data? {
        guard let folderURL = directory.url?.appendingPathComponent(folder) else { return nil }
        let fileURL = folderURL.appendingPathComponent(name)
        do {
            return try Data(contentsOf: fileURL)
        } catch {
            print("\(AppText.failedReadFile) \(name): \(error)")
            return nil
        }
    }
    
    func getFileURL(name: String, folder: String, directory: Directory) -> URL? {
        var folderURL = directory.url
        folderURL = folderURL?.appendingPathComponent(folder)
        return folderURL?.appendingPathComponent(name)
    }
    
    func listFiles(folder: String, directory: Directory) -> [URL] {
        guard let folderURL = directory.url?.appendingPathComponent(folder) else { return [] }


        do {
            return try fileManager.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
        } catch {
            print("\(AppText.failedListFilesFromFolder): \(folder) \(error)")
            return []
        }
    }
}

