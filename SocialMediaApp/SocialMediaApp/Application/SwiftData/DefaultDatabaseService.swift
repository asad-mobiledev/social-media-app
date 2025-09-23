//
//  SwiftDataManager.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/09/2025.
//
import Foundation
import SwiftData

@MainActor
class DefaultDatabaseService: DatabaseService {
    
    let container: ModelContainer
    var context: ModelContext {
        container.mainContext
    }
    
    init(isStoredInMemoryOnly: Bool = false) throws {
        let schema = Schema([PostModel.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: isStoredInMemoryOnly)
        self.container = try ModelContainer(for: schema, configurations: [config])
    }
    func create<T>(item: T) where T : PersistentModel {
        context.insert(item)
    }
    
    func fetch<T>(descriptor: FetchDescriptor<T>) throws -> [T] where T : PersistentModel {
        return try context.fetch(descriptor)
    }
}
