//
//  TransferrableAsset.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import SwiftUI

struct TransferableAsset: Transferable {
    let url: URL?
    let image: Image?
    
    enum TransferError: Error {
        case importFailed
    }
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            guard let uiImage = UIImage(data: data) else {
                throw TransferError.importFailed
            }
            let image = Image(uiImage: uiImage)
            return TransferableAsset(url: nil, image: image)
        }
        FileRepresentation(importedContentType: .movie) { data in
            guard
                let directoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            else {
                print("Cannot access local file domain")
                throw TransferError.importFailed
            }
            
            let filePath = directoryPath
                .appendingPathComponent("movie")
                .appendingPathExtension("mp4")
            do {
                if FileManager.default.fileExists(atPath: filePath.path()) {
                    try FileManager.default.removeItem(at: filePath)
                }
                try FileManager.default.copyItem(at: data.file, to: filePath)
            } catch(let error) {
                print(error)
                throw TransferError.importFailed
            }
            return TransferableAsset(url: filePath, image: nil)
            
        }
    }
}
