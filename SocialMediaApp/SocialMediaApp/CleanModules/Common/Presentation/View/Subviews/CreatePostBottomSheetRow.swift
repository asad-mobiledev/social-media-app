//
//  UploadMediaListRow.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import SwiftUI

struct CreatePostBottomSheetRow: View {
    let row: ListRowModel

    var body: some View {
        Button(action: row.action) {
            HStack(spacing: 12) {
                Image(systemName: row.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.primary)

                Text(row.title)
                    .foregroundColor(.black)
                    .font(.title3)

                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal,10)
        }
    }
}

#Preview {
    CreatePostBottomSheetRow(row: ListRowModel(title: "Gallery", imageName: "photo.on.rectangle.angled", action: {
        print("Gallery Tapped!")
    }))
}
