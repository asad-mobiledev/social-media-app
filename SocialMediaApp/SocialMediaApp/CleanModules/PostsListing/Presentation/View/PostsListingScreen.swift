//
//  HomeScreen.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 02/09/2025.
//

import SwiftUI

struct PostsListingScreen: View {
    @Environment(\.appDIContainer) private var appDIContainer
    @EnvironmentObject var router: Router
    @ObservedObject var postsListingViewModel: PostsListingViewModel
    
    var body: some View {
            VStack(spacing: 0) {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(postsListingViewModel.posts) { post in
                            VStack{
                                switch post.postType {
                                case .image:
                                    ImagePost(imageName: post.mediaName)
                                case .audio:
                                    AudioPost(audioName: post.mediaName)
                                case .video:
                                    VideoPost(videoName: post.mediaName)
                                }
                            }
                            .onAppear {
                                if post == postsListingViewModel.posts.last {
                                    Task {
                                        await postsListingViewModel.fetchPosts()
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                    
                    
                    if postsListingViewModel.isLoading {
                        ProgressView()
                            .padding()
                    }
                }
                .refreshable {
                    if !postsListingViewModel.isLoading {
                        Task {
                            await postsListingViewModel.refreshPosts()
                        }
                    }
                }
                
                HStack {
                    Button(AppText.createPost) {
                        router.present(sheet: .createPost)
                    }
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.primary)
                }
            }
            .navigationTitle(AppText.posts)
            .sheet(item: $router.activeSheet) { sheet in
                switch sheet {
                case .createPost:
                    appDIContainer.createPostBottomSheet()
                    .presentationDetents([.height(250)])
                    .presentationDragIndicator(.visible)
                }
            }
        .onAppear {
            Task {
                await postsListingViewModel.fetchPosts()
            }
        }
        .environmentObject(postsListingViewModel)
    }
}

#Preview {
//    PostsListingScreen(homeScreenViewModel: PostsListingViewModel())
}
