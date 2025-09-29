//
//  DataTransferService.swift
//  ProductListing
//
//  Created by Asad Mehmood on 30/11/2024.
//


import Foundation

protocol DataTransferService {
    func request<T: Decodable>(request: NetworkRequest) async throws -> T
    func request(request: NetworkRequest) async throws
}

final class DefaultDataTransferService: DataTransferService {
    
    private let networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    /// Method to fetch data from Network Manager and Decode the data using decode method
    /// - Parameter request:  Network request
    /// - Returns: Decodable type object
    func request<T>(request: NetworkRequest) async throws -> T where T : Decodable {
        let data = try await networkManager.fetch(request: request)
        return try decode(data: data)
    }
    
    func request(request: NetworkRequest) async throws {
        _ = try await networkManager.fetch(request: request)
    }
    
    /// Method to decode data using JSONDecoder
    /// - Parameter data: Data
    /// - Returns: Decodable type object
    func decode<T>(data: Data) throws -> T where T : Decodable {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.unableToDecode
        }
    }
    
    func decodeFirestoreResponse<T>(data: Data) throws -> T {
        do {
            // We now decode into an array of our new wrapper struct.
            let documentWrappers = try JSONDecoder().decode([FirestorePostsDocumentWrapper].self, from: data)
            
            // Then, we map the documents from the wrappers to our clean PostDTO model.
            let posts = documentWrappers.compactMap { wrapper in
                PostDTO(from: wrapper.document)
            }
            
            return posts as! T
        } catch {
            print("Failed to decode Firestore response: \(error.localizedDescription)")
            throw NetworkError.unableToDecode
        }
    }
}
