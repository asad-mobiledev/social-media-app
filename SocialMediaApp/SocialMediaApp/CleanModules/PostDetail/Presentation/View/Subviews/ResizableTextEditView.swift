//
//  ResizableTextEditView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct ResizableTextEditView: View {
    @State private var text: String = AppText.typeHere
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
        TextEditor(text: $text)
            .focused($isFocused)
            .onChange(of: isFocused) { _, isNowFocused in
                if isNowFocused && text == AppText.typeHere {
                    text = ""
                } else if !isNowFocused && text == "" {
                    text = AppText.typeHere
                }
            }
            .frame(maxHeight: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            .padding(8)
    }
}

#Preview {
    ResizableTextEditView()
}
