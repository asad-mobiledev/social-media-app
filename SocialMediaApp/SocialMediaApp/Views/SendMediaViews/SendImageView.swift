//
//  SendImageView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import SwiftUI

struct SendImageView: View {
    let image: Image
    
    var body: some View {
        image
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .frame(width: 150, height: 150)
            .zoomable(minZoomScale: 0.5)
    }
}

#Preview {
    SendImageView(image: Image(Images.postImage))
}
