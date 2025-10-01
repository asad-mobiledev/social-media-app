//
//  Utility.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/09/2025.
//

import Foundation
import UniformTypeIdentifiers

struct Utility {
    static func getISO8601Date() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: Date())
    }
    
    static func saveDataToTempDirectory(data: Data, fileExtension: String) throws -> URL? {
        let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let fileName = UUID().uuidString + "." + fileExtension
        let fileURL = tempDirectoryURL.appendingPathComponent(fileName)
        try data.write(to: fileURL)
        return fileURL
    }
    
    static func mediaTypeForAccessingSecurityScopedResource(url: URL) throws -> MediaType? {
        if url.startAccessingSecurityScopedResource() {
            defer { url.stopAccessingSecurityScopedResource() }
            return try getMediaTypeFrom(url: url)
        } else {
            throw CustomError.message(AppText.filesPermissionIssue)
        }
    }
    
    static func getMediaTypeFrom(url: URL) throws -> MediaType? {
        let resourceValues = try url.resourceValues(forKeys: [.typeIdentifierKey])
        guard let typeIdentifier = resourceValues.typeIdentifier else {
            return nil
        }
        
        if let utType = UTType(typeIdentifier) {
            if utType.conforms(to: .image) {
                return .image
            } else if utType.conforms(to: .audio) {
                return .audio
            } else if utType.conforms(to: .movie) {
                return .video
            }
        }
        return nil
    }
}
