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
    func save(mediaType: MediaType, mediaURL: URL?, directory: Directory) throws -> String
    func createFolder(name: String, directory: Directory) -> URL?
    func getDataOf(fileName: String, folder: String, directory: Directory) throws -> Data
    func getFileURL(name: String, folder: String, directory: Directory) -> URL?
    func listFiles(folder: String, directory: Directory) -> [URL]
    func saveFileFrom(sourceURL: URL, folder: String, directory: Directory) throws -> String?
    func getData(from url: URL) throws -> Data
}
