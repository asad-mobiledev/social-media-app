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

// We can read error message in case of API failure of Firebase, we can devise some generic way to decode failed API.
//struct FirestoreErrorWrapper: Codable {
//    let error: FirestoreError
//}
//
//struct FirestoreError: Codable {
//    let code: Int
//    let message: String
//    let status: String
//}
