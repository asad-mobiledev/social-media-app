//
//  FilesRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 11/09/2025.
//

import Foundation
import UIKit

protocol FileService {
    var fileManager: FileManager { get }
    func save(mediaType: MediaType, mediaURL: URL?) throws -> String
    func createFolder(name: String) -> URL?
    func getDataOf(fileName: String, folder: String) throws -> Data
    func getFileURL(name: String, folder: String) -> URL?
    func listFiles(folder: String) -> [URL]
    func saveFileFrom(sourceURL: URL, folder: String) throws -> String?
    func getData(from url: URL) throws -> Data
    func deleteFile(name: String, folder: String, directory: Directory) throws 
}
