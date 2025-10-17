//
//  Untitled.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 16/10/2025.
//
import SwiftUI
@testable import SocialMediaApp

struct SnapshotTestView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack {
            content
        }
    }
}
