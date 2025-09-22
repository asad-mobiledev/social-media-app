//
//  SelectedMediaSendView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import SwiftUI

struct SendMediaView: View {
    @Environment(\.appDIContainer) private var appDIContainer
    @ObservedObject var sendMediaViewModel: SendMediaViewModel
    
    @Binding var loadState: LoadState
    var mediaAttachement: MediaAttachment
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Spacer()
                HStack(alignment: .bottom) {
                    ZStack(alignment: .topTrailing) {
                        switch mediaAttachement.mediaType {
                        case .image:
                            appDIContainer.createSendImageView(imageURL: mediaAttachement.url!)
                        case .audio:
                            appDIContainer.createSendAudioView(audioURL: mediaAttachement.url!)
                                .padding(.bottom, 60)
                        case .video:
                            SendVideoView(videoURL: mediaAttachement.url!)
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
                    sendMediaViewModel.post(mediaType: mediaAttachement.mediaType, mediaURL: mediaAttachement.url)
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
            
            if sendMediaViewModel.isLoading {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                    .transition(.scale)
            }
        }
    }
}

#Preview {
//    StatefulPreviewWrapper(false) { binding in
//        SendMediaView(mediaType: .image, showSendMediaView: binding)
//        }
}
