//
//  ImageView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI
import Zoomable

struct NamedImageView: View {
    @ObservedObject var viewModel: ImageViewModel
    let imageName: String
    
    var body: some View {
        Group {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height:200)
                    .clipShape(.rect())
                    .zoomable(minZoomScale: 0.5)
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundStyle(.red)
            } else {
                ZStack {
                    Image("placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .clipShape(.rect())
                        .zoomable(minZoomScale: 0.5)
                    ProgressView()
                }
            }
        }
        .onAppear {
            viewModel.fetchImage(imageName: imageName)
        }
    }
}

#Preview {
//    ImageView(imageName: "post-image")
}
