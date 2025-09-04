//
//  UploadMediaBottomSheet.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import SwiftUI

struct UploadMediaBottomSheet: View {
    var body: some View {
        VStack(spacing: 10) {
            UploadMediaListRow(row: ListRowModel(title: AppText.selectFromGallery, imageName: "photo.on.rectangle.angled", action: {
                print("Gallery Tapped!")
            }))
            UploadMediaListRow(row: ListRowModel(title: AppText.selectFromFiles, imageName: "doc.fill", action: {
                print("Files Tapped!")
            }))
        }
    }
}

#Preview {
    UploadMediaBottomSheet()
}
