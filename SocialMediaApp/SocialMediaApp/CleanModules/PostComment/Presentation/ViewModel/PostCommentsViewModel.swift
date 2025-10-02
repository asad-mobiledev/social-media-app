//
//  Untitled.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 26/09/2025.
//

import Foundation
import Combine

class PostCommentsViewModel: ObservableObject {
    let post: PostEntity
    let postCommentUseCase: PostCommentUseCase
    
    @Published var commentText: String = AppText.typeHere
    @Published var errorMessage: String = ""
    @Published var comments: [CommentEntity] = []
    @Published var isLoading = false
    @Published var isSendCommentLoading = false
    @Published var showBottomSheet = false
    @Published var commentMediaLoadState: LoadState = .unknown
    
    private let paginationPolicy: PaginationPolicy
    var lastFetchedCommentsCount = -1
    private let pageLimit = 5
    var refreshing = false
    private var cancellables = Set<AnyCancellable>()
    
    init(post: PostEntity, postCommentUseCase: PostCommentUseCase, paginationPolicy: PaginationPolicy) {
        self.post = post
        self.postCommentUseCase = postCommentUseCase
        self.paginationPolicy = paginationPolicy
        
        NotificationCenter.default.publisher(for: .newCommentAdded)
            .compactMap { $0.object as? CommentEntity }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newComment in
                self?.comments.insert(newComment, at: 0)
            }
            .store(in: &cancellables)
    }
    
    func addComment(mediaAttachement: MediaAttachment?, parentCommentId: String? = nil, parentCommentDepth: String? = nil) async {
        guard !commentText.isEmpty || mediaAttachement?.url != nil else {
            return
        }
        await MainActor.run {
            isSendCommentLoading = true
        }
        do {
            let comment = try await postCommentUseCase.addComment(postId: self.post.id, mediaAttachement: mediaAttachement, commentText: self.commentText, parentCommentId: parentCommentId, parentCommentDepth: parentCommentDepth)
            NotificationCenter.default.post(name: .newCommentAdded, object: comment)
            await MainActor.run {
                isSendCommentLoading = false
            }
        } catch {
            await MainActor.run {
                isSendCommentLoading = false
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func fetchComments(isRefreshing: Bool = false) async {
        guard canHaveMoreComments() else { return }
        guard !isLoading else { return }
        await MainActor.run {
            isLoading = true
        }
        do {
            var startIndex = comments.last?.createdAt
            if isRefreshing {
                startIndex = nil
            }
            let comments = try await postCommentUseCase.fetchComments(postId: post.id, limit: 5, startAt: startIndex)
            lastFetchedCommentsCount = comments.count
            await MainActor.run {
                if isRefreshing {
                    self.comments = []
                }
                self.comments += comments
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
            }
        }
        await MainActor.run {
            isLoading = false
        }
    }
    
    func refreshComments() async {
        await MainActor.run {
            errorMessage = ""
        }
        await fetchComments(isRefreshing: true)
    }
    
    private func canHaveMoreComments() -> Bool {
        lastFetchedCommentsCount != 0
    }
    
    func mediaType(url: URL) -> MediaType? {
            do {
                return try Utility.getMediaTypeFrom(url: url)
            } catch {
                do {
                    return try Utility.mediaTypeForAccessingSecurityScopedResource(url: url)
                } catch {
                    Task { @MainActor in
                        errorMessage = "\(error)"
                        commentMediaLoadState = .failed
                    }
                }
            }
        return nil
    }
}
