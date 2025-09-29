//
//  Firestore.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 29/09/2025.
//

struct FirestoreValue: Codable {
    var stringValue: String?
    var integerValue: String?
    var booleanValue: Bool?
    var arrayValue: FirestoreArray?
    var mapValue: FirestoreMap?
}

/// A container for Firestore's array values.
struct FirestoreArray: Codable {
    var values: [FirestoreValue]?
}

/// A container for Firestore's map values.
struct FirestoreMap: Codable {
    var fields: [String: FirestoreValue]?
}
