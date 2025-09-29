//
//  ListRowModel.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//
import Foundation

struct ListRowModel: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let action: () -> Void
}
