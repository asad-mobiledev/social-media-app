//
//  ImageView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI
import Zoomable

struct NamedImageView: View {
    @StateObject var viewModel: ImageViewModel
    let imageName: String
    
    var body: some View {
        Group {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .clipShape(.rect())
                    .zoomable(minZoomScale: 0.5)
                    .clipped()
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundStyle(.red)
            } else {
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .clipped()
                    ProgressView()
                }
            }
        }
        .background(.gray.opacity(0.1))
        .onAppear {
            viewModel.fetchImage(imageName: imageName)
        }
    }
}

#Preview {
//    ImageView(imageName: "post-image")
}
