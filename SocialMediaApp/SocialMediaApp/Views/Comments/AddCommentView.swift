//
//  AddCommentView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct AddCommentView: View {
    @Binding var showBottomSheet: Bool
    
    var body: some View {
        HStack(alignment: .center){
            ResizableTextEditView()
            
            Button(action: {
                showBottomSheet = true
            }) {
                Image(systemName: Images.upload)
                    .font(.title)
                    .foregroundColor(.black)
            }
            
            Button(action: {
            }) {
                SendImage()
                    .foregroundColor(Color.primary)
            }
        }
        .padding(8)
        .background(Color.gray.opacity(0.1))
    }
}

#Preview {
    StatefulPreviewWrapper(false) { binding in
            AddCommentView(showBottomSheet: binding)
        }
}



