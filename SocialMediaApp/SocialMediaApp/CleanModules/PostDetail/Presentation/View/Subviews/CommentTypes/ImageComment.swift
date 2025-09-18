//
//  ImageComment.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI
import Zoomable

struct ImageComment: View {
    let imageName: String
    let depth: Int
    
    var body: some View {
        VStack(alignment: .trailing) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 150, minHeight: 10)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .zoomable(minZoomScale: 0.5)
            
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
    }
}

#Preview {
    ImageComment(imageName: "post-image", depth: 1)
}
