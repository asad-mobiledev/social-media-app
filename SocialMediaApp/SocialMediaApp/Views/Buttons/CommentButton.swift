//
//  CommentButton.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 02/09/2025.
//

import SwiftUI

struct CommentButton: View {
    var body: some View {
        Button(AppText.comment) {
            print("Comment button tapped")
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
    CommentButton()
}
