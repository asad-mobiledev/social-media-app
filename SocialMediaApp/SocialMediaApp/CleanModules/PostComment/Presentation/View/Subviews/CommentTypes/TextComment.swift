//
//  TextComment.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct TextComment: View {
    let text: String
    let depth: Int
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text(text)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .font(.body)
                .foregroundStyle(Color.primary)
            
            if depth < 2 {
                Button(AppText.reply) {
                    print("Reply Pressed")
                }
                .font(.system(size: 12))
                .foregroundStyle(Color.black)
                .padding(.trailing, 5)
            }
        }
        
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(Color.lightGray)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    TextComment(text: "Test Comment ", depth: 1)
}
