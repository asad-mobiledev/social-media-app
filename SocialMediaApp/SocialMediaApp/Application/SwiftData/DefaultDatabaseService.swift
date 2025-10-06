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
    
    private static var _shared: DefaultDatabaseService?
    static var shared: DefaultDatabaseService {
        guard let instance = _shared else {
            fatalError("DefaultDatabaseService not configured. Call configure(isStoredInMemoryOnly:) before accessing shared.")
        }
        return instance
    }
    
    static func configure(isStoredInMemoryOnly: Bool = false) {
        do {
            _shared = try DefaultDatabaseService(isStoredInMemoryOnly: isStoredInMemoryOnly)
        } catch {
            fatalError("Failed to initialize DefaultDatabaseService: \(error)")
        }
    }

    let container: ModelContainer
    var context: ModelContext {
        container.mainContext
    }

    private init(isStoredInMemoryOnly: Bool) throws {
        let schema = Schema([PostModel.self, PostCommentModel.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: isStoredInMemoryOnly)
        self.container = try ModelContainer(for: schema, configurations: [config])
    }

    func save<T: PersistentModel>(item: T) throws {
        context.insert(item)
        try context.save()
    }
    
    func batchSave<T: PersistentModel>(items: [T]) throws {
        for item in items {
            context.insert(item)
        }
        try context.save()
    }

    func fetch<T: PersistentModel>(descriptor: FetchDescriptor<T>?) throws -> [T] {
        var fetchDescriptor: FetchDescriptor<T>
        if let _ = descriptor {
            fetchDescriptor = descriptor!
        } else {
            fetchDescriptor = FetchDescriptor<T>()
        }
        return try context.fetch(fetchDescriptor)
    }
    
    func deleteAll<T: PersistentModel>(of type: T.Type, descriptor: FetchDescriptor<T>?) throws {
        let allItems = try fetch(descriptor: descriptor)
        for item in allItems {
            context.delete(item)
        }
        try context.save()
    }
    
}
