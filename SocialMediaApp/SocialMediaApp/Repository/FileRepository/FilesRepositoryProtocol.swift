//
//  FilesRepositoryProtocol.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 11/09/2025.
//

protocol FilesRepositoryProtocol {
    var fileManager: FileManager { get }
    func createFolder(name: String, directory: Directory) -> URL?
    func saveFile(name: String, data: Data, folder: String, directory: Directory) -> URL?
    func readFile(name: String, folder: String, directory: Directory) -> Data?
    func getFileURL(name: String, folder: String, directory: Directory) -> URL?
    func listFiles(folder: String, directory: Directory) -> [URL]
}
