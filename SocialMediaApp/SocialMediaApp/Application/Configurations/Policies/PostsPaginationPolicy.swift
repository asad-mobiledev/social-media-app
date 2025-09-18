//
//  PostsPaginationPolicy.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/09/2025.
//

protocol PostsPaginationPolicy {
    var itemsPerPage: Int { get }
}

struct DefaultPostsPaginationPolicy: PostsPaginationPolicy {
    var itemsPerPage: Int = 5
}
