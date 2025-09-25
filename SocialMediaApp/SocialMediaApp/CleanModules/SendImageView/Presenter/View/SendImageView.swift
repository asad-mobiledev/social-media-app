//
//  SendImageView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import SwiftUI
import Zoomable

struct SendImageView: View {
    @StateObject var viewModel: ImageViewModel
    let imageURL: URL
    
    var body: some View {
        Group {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .frame(width: 150, height: 150)
                    .zoomable(minZoomScale: 0.5)
                    .clipped()
            }
            else if let error = viewModel.errorMessage {
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
                        .clipped()
                    ProgressView()
                }
            }
        }
        .onAppear {
            viewModel.fetchImage(localUrl: imageURL)
        }
    }
}

#Preview {
//    SendImageView(image: Image(Images.postImage))
}
