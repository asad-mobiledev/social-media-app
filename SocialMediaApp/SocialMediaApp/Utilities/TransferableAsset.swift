//
//  TransferrableAsset.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import Foundation
import CoreTransferable

struct TransferableAsset: Transferable {
    let url: URL?
    
    enum TransferError: Error {
        case importFailed
    }
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            return TransferableAsset(url: try Utility.saveDataToTempDirectory(data: data, component: "image", fileExtension: "png"))
        }
        FileRepresentation(importedContentType: .movie) { data in
            let filePath = try getSavedFileURL(component: "movie", fileExtension: "mp4", data: data)
            return TransferableAsset(url: filePath)
            
        }
    }
    
    static func getSavedFileURL(component: String, fileExtension: String, data: ReceivedTransferredFile) throws -> URL {
        guard
            let directoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else {
            print("Cannot access local file domain")
            throw TransferError.importFailed
        }
        
        let filePath = directoryPath
            .appendingPathComponent(component)
            .appendingPathExtension(fileExtension)
        do {
            if FileManager.default.fileExists(atPath: filePath.path()) {
                try FileManager.default.removeItem(at: filePath)
            }
            try FileManager.default.copyItem(at: data.file, to: filePath)
            return filePath
        } catch(let error) {
            print(error)
            throw TransferError.importFailed
        }
    }
}
