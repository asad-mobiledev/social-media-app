//
//  SendImageView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import SwiftUI
import Zoomable

struct SendImageView: View {
    @ObservedObject var viewModel: ImageViewModel
    let imageURL: URL
    
    var body: some View {
        if let image = viewModel.image {
            Image(uiImage: image)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .frame(width: 150, height: 150)
                .zoomable(minZoomScale: 0.5)
        } else if let error = viewModel.errorMessage {
            Text("Error: \(error)")
                .foregroundStyle(.red)
        } else {
            ProgressView()
        }
    }
}

#Preview {
//    SendImageView(image: Image(Images.postImage))
}
