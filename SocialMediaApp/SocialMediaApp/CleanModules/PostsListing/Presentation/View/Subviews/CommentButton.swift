//
//  CommentButton.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 02/09/2025.
//

import SwiftUI

struct CommentButton: View {
    @EnvironmentObject var router: Router
    let post: PostEntity
    
    var body: some View {
        Button(AppText.comment) {
            router.navigate(to: .postCommments(post: post))
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
        .background(.purple)
        .foregroundStyle(.white)
        .font(.system(size: 18, weight: .medium))
        .clipShape(.buttonBorder)
    }
}

#Preview {
//    CommentButton(post: post)
}
