//
//  DatabaseRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/09/2025.
//
import SwiftData

@MainActor
protocol DatabaseService {
    
    var context: ModelContext { get }
    func save<T: PersistentModel>(item: T) throws
    func batchSave<T: PersistentModel>(items: [T]) throws
    func fetch<T: PersistentModel>(descriptor: FetchDescriptor<T>) throws -> [T]
    func deleteAll<T: PersistentModel>(of type: T.Type) throws 
}
