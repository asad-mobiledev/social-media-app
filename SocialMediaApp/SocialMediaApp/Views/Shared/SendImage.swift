//
//  SendImage.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import SwiftUI

struct SendImage: View {
    var body: some View {
        Image(systemName: Images.send)
            .rotationEffect(.degrees(45))
            .frame(width: 50, height: 50)
    }
}

#Preview {
    SendImage()
}
