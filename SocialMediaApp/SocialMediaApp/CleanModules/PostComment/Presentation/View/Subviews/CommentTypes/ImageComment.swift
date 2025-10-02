//
//  ImageComment.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI
import Zoomable

struct ImageComment: View {
    @StateObject var viewModel: ImageViewModel
    @StateObject var postCommentsViewModel: PostCommentsViewModel
    let comment: CommentEntity
    
    var body: some View {
        VStack(alignment: .trailing) {
            Group {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 150, minHeight: 10)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .zoomable(minZoomScale: 0.5)
                        .clipped()
                }
                else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundStyle(.red)
                } else {
                    ZStack {
                        Rectangle()
                            .fill(Color.gray)
                            .frame(maxWidth: 150, minHeight: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .clipped()
                        ProgressView()
                    }
                }
            }
            
            if comment.depth! < 2 {
                Button(AppText.reply) {
                    postCommentsViewModel.replyToComment = comment
                }
                .font(.system(size: 12))
                .foregroundStyle(Color.black)
                .padding(.trailing, 5)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .onAppear {
            viewModel.fetchImage(imageName: comment.mediaName!)
        }
    }
}

#Preview {
//    ImageComment(imageName: "post-image", depth: 1)
}
