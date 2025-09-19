//
//  Utility.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/09/2025.
//

import Foundation

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
}
