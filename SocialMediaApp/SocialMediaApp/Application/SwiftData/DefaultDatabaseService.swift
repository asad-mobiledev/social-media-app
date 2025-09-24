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
        let schema = Schema([PostModel.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: isStoredInMemoryOnly)
        self.container = try ModelContainer(for: schema, configurations: [config])
    }

    func create<T: PersistentModel>(item: T) {
        context.insert(item)
    }

    func fetch<T: PersistentModel>(descriptor: FetchDescriptor<T>) throws -> [T] {
        return try context.fetch(descriptor)
    }
}
