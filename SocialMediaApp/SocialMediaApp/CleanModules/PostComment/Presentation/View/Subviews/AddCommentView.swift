//
//  AddCommentView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//

import SwiftUI

struct AddCommentView: View {
    @Environment(\.appDIContainer) private var appDIContainer
    @EnvironmentObject var router: Router
    @ObservedObject var postCommentsViewModel: PostCommentsViewModel
    @ObservedObject var commentMediaBottomSheetViewModel: ImportMediaBottomSheetViewModel
    
    var body: some View {
        VStack {
            Group {
                if let replyToComment = postCommentsViewModel.replyToComment {
                    HStack {
                        Text("Replying to comment \(replyToComment.id)")
                            .padding(.trailing, 20)
                            .multilineTextAlignment(.leading)
                        Button(action: {
                            postCommentsViewModel.replyToComment = nil
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
                }
            }
            .frame(maxHeight: 70)
            .padding(.trailing, 20)
            Group {
                if commentMediaBottomSheetViewModel.loadState.isURLLoaded {
                    if let attachment = commentMediaBottomSheetViewModel.mediaAttachment {
                        VStack(spacing: 10) {
                            Spacer()
                            HStack(alignment: .bottom) {
                                ZStack(alignment: .topTrailing) {
                                    switch attachment.mediaType {
                                    case .image:
                                        appDIContainer.createSendImageView(imageURL: attachment.url!)
                                    case .audio:
                                        appDIContainer.createSendAudioView(audioURL: attachment.url!)
                                    case .video:
                                        appDIContainer.createSendVideoView(videoURL: attachment.url!)
                                    }
                                    Button(action: {
                                        commentMediaBottomSheetViewModel.loadState = .unknown
                                    }) {
                                        Image(systemName: Images.xmark)
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
                        }
                        .frame(maxWidth: .infinity)
                        
                        
                        
                    } else {
                        EmptyView().onAppear {
                            commentMediaBottomSheetViewModel.loadState = .failed
                        }
                    }
                }
            }
            .frame(height: commentMediaBottomSheetViewModel.mediaAttachment?.mediaType == .audio ? 90 : 170)
            
            HStack(alignment: .center){
                TextFieldView(postCommentsViewModel: postCommentsViewModel)
                
                Button(action: {
                    router.present(sheet: .importMediaComment)
                }) {
                    Image(systemName: Images.upload)
                        .font(.title)
                        .foregroundColor(.black)
                }
                
                Button(action: {
                    Task {
                        await postCommentsViewModel.addComment(mediaAttachement: commentMediaBottomSheetViewModel.mediaAttachment)
                    }
                }) {
                    SendImage()
                        .foregroundColor(Color.primary)
                }
            }
            .padding(8)
            
        }
        .background(Color.gray.opacity(0.1))
        
        .onChange(of: commentMediaBottomSheetViewModel.loadState) { _, newState in
            if newState.isURLLoaded {
                router.dismissSheet()
            }
        }
        .onChange(of: postCommentsViewModel.isSendCommentLoading) { _, newState in
            if commentMediaBottomSheetViewModel.loadState.isURLLoaded && newState == false && postCommentsViewModel.errorMessage.isEmpty{
                commentMediaBottomSheetViewModel.loadState = .unknown
            }
        }
        .animation(.easeInOut, value: postCommentsViewModel.isSendCommentLoading)
        .alert(AppText.error, isPresented: $postCommentsViewModel.showErrorAlert) {
            Button(AppText.OK, role: .cancel) { }
        } message: {
            Text(postCommentsViewModel.errorMessage)
        }
    }
}

#Preview {
//    StatefulPreviewWrapper(false) { binding in
//            AddCommentView(showBottomSheet: binding)
//        }
}



