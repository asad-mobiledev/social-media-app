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
    func create<T: PersistentModel>(item: T)
    func fetch<T: PersistentModel>(descriptor: FetchDescriptor<T>) throws -> [T]
}
