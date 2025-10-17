//
//  PostsPaginationPolicy.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/09/2025.
//

protocol PaginationPolicy {
    var itemsPerPage: Int { get }
}

struct DefaultPaginationPolicy: PaginationPolicy {
    var itemsPerPage: Int = 5
}
