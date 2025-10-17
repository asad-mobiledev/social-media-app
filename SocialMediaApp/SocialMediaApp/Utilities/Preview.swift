//
//  Preview.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import SwiftUI

struct StatefulPreviewWrapper<T>: View {
    @State private var value: T
    var content: (Binding<T>) -> AnyView

    init(_ initialValue: T, @ViewBuilder content: @escaping (Binding<T>) -> some View) {
        _value = State(initialValue: initialValue)
        self.content = { binding in AnyView(content(binding)) }
    }

    var body: some View {
        content($value)
    }
}
