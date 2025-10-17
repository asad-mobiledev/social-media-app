//
//  MockDatabaseService.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp
import SwiftData

class MockDatabaseService: DatabaseService {
    let container: ModelContainer
    var context: ModelContext
    var items: [Any] = []
    var errorToThrow: Error?
    var itemsToReturn: [Any] = []
    
    init(isStoredInMemoryOnly: Bool) throws {
        let schema = Schema([PostModel.self, PostCommentModel.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: isStoredInMemoryOnly)
        self.container = try ModelContainer(for: schema, configurations: [config])
        context = container.mainContext
    }
    
    func save<T>(item: T) throws where T : PersistentModel {
        if let error = errorToThrow {
            throw error
        }
        return self.items.append(item)
    }
    
    func batchSave<T>(items: [T]) throws where T : PersistentModel {
        if let error = errorToThrow {
            throw error
        }
        return self.items.append(contentsOf: items)
    }
    
    func fetch<T>(descriptor: FetchDescriptor<T>?) throws -> [T] where T : PersistentModel {
        if let error = errorToThrow {
            throw error
        }
        return self.itemsToReturn as? [T] ?? []
    }
    
    func deleteAll<T>(of type: T.Type, descriptor: FetchDescriptor<T>?) throws where T : PersistentModel {
        if let error = errorToThrow {
            throw error
        }
        return self.items.removeAll()
    }
}
