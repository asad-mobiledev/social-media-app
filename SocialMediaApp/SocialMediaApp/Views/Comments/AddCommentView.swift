//
//  AddCommentView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct AddCommentView: View {
    
    var body: some View {
        HStack(alignment: .center){
            ResizableTextEditView()
            
            Button(action: {
                print("Upload")
            }) {
                Image(systemName: "square.and.arrow.up")
                    .font(.title)
                    .foregroundColor(.black)
            }
            
            Button(action: {
            }) {
                Image(systemName: "paperplane.fill")
                    .rotationEffect(.degrees(45))
                    .foregroundColor(Color.primary)
                    .frame(width: 50, height: 50)
            }
        }
        .padding(8)
        .background(Color.gray.opacity(0.1))
    }
}

#Preview {
    AddCommentView()
}
