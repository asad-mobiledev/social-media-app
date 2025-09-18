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
    
    static func saveDataToTempDirectory(data: Data, component: String, fileExtension: String) throws -> URL? {
        let tempDirectory = FileManager.default.temporaryDirectory
        let fileName = UUID().uuidString + "/" + component + "." + fileExtension
        let fileURL = tempDirectory.appendingPathComponent(fileName)
        try data.write(to: fileURL)
        return fileURL
    }
}
