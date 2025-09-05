//
//  SelectedMediaSendView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import SwiftUI

struct SendMediaView: View {
    let mediaType: MediaType
    @Binding var loadState: LoadState
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            HStack(alignment: .bottom) {
                ZStack(alignment: .topTrailing) {
                    switch mediaType {
                    case .image:
                        SendImageView(image: Image(Images.postImage))
                    case .audio:
                        SendAudioView(videoURL: Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!)
                            .padding(.bottom, 60)
                    case .video:
                        SendVideoView(videoURL: Bundle.main.url(forResource: "sample-video", withExtension: "mp4")!)
                    }
                    Button(action: {
                        loadState = .unknown
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 30, height: 30)
                            .background(Color.gray)
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .padding(.trailing, -10)
                    .padding(.top, -10)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            
            Button(action: {
            }) {
                HStack(spacing: 5){
                    Text(AppText.post)
                        .foregroundStyle(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                    Image(systemName: Images.send)
                        .rotationEffect(.degrees(45))
                        .foregroundStyle(.white)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(5)
            .background(Color.primary)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
//    StatefulPreviewWrapper(false) { binding in
//        SendMediaView(mediaType: .image, showSendMediaView: binding)
//        }
}
