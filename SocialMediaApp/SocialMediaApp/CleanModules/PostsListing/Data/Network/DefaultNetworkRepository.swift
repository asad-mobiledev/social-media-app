//
//  DefaultNetworkRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/09/2025.
//
import FirebaseFirestore
import FirebaseAuth

class DefaultNetworkRepository: NetworkRepository {
    
    private let apiDataTransferService: DataTransferService
    
    init(apiDataTransferService: DataTransferService) {
        self.apiDataTransferService = apiDataTransferService
    }
        
    func getPosts(limit: Int, startAt: String?) async throws -> [PostDTO] {
        
        // Firebase Needs following Query Params
        var structuredQuery: [String: Any] = [
            "from": [["collectionId": "posts"]],
            "orderBy": [[
                "field": ["fieldPath": "date"],
                "direction": "DESCENDING"
            ]],
            "limit": limit
        ]
        if let startAt = startAt {
            structuredQuery["startAt"] = [
                "values": [
                    ["stringValue": startAt]
                ]
            ]
        }
        let body: [String: Any] = [
            "structuredQuery": structuredQuery
        ]
        
        let postsListNetworkRequest = DefaultNetworkRequest(path: AppConfiguration.APIEndPoint.fetchPosts, method: .post, headerParameters: ["Authorization": "Bearer \(AppConfiguration.token)", "Content-Type": "application/json"], bodyParameters: body)
        
        let firstorePosts: [FirestorePostsDocumentWrapper] = try await apiDataTransferService.request(request: postsListNetworkRequest)
        let posts = firstorePosts.compactMap { post in
            PostDTO(from: post.document)
        }
        return posts
    }
    
    func createPost(mediaType: MediaType, mediaName: String) async throws -> PostDTO {
        let date = Utility.getISO8601Date()
        let documentName = UUID().uuidString
        let post = PostDTO(id: documentName, postType: mediaType.rawValue, mediaName: mediaName, date: date)
        let body: [String: Any] = [
            "fields": [
                "postType": [
                    "stringValue": post.postType
                ],
                "mediaName": [
                    "stringValue": post.mediaName
                ],
                "date": [
                    "stringValue": post.date
                ]
            ]
        ]
        let createPostNetworkRequest = DefaultNetworkRequest(path: AppConfiguration.APIEndPoint.createPost + "/\(post.id!)", method: .patch, headerParameters: ["Authorization": "Bearer \(AppConfiguration.token)", "Content-Type": "application/json"], bodyParameters: body)
        try await apiDataTransferService.request(request: createPostNetworkRequest)
        return post
    }
    
    private func updateParentCommentsReplyCounts(_ parentCommentId: String?) async throws {
        if let id = parentCommentId {
            let comment = try await fetchComment(commentId: id)
            var replyCount = Int(comment.replyCount ?? "0") ?? 0
            replyCount += 1
            
            var fields: [String: Any] = [
                "type": ["stringValue": comment.type],
                "createdAt": ["stringValue": comment.createdAt],
                "postId": ["stringValue": comment.postId],
                "replyCount": ["integerValue": "\(replyCount)"]
            ]
            
            if let parentCommentId = comment.parentCommentId {
                fields["parentCommentId"] = ["stringValue": parentCommentId]
                if let parentCommentDepth = comment.parentCommentDepth {
                    fields["parentCommentDepth"] = ["stringValue": parentCommentDepth]
                }
            }
            if let text = comment.text {
                fields["text"] = ["stringValue": text]
            }
            
            if let mediaName = comment.mediaName {
                fields["mediaName"] = ["stringValue": mediaName]
            }
            
            if let depth = comment.depth {
                fields["depth"] = ["stringValue": depth]
            }
            
            let body: [String: Any] = [ "fields": fields ]
            
            let updateCommentNetworkRequest = DefaultNetworkRequest(path: AppConfiguration.APIEndPoint.updateComment + "\(id)", method: .patch, headerParameters: ["Authorization": "Bearer \(AppConfiguration.token)", "Content-Type": "application/json"], bodyParameters: body)
            try await apiDataTransferService.request(request: updateCommentNetworkRequest)
        }
    }
    private func getCommentEntity(postId: String, mediaAttachement: MediaAttachment?, fileName: String?, commentText: String?, parentCommentId: String?, parentCommentDepth: String?) -> CommentEntity? {
                        // Give precedence to media comments over text comments if both are there.
        var commentText: String? = commentText
        var mediaType: CommentType = CommentType.text
        if mediaAttachement?.url != nil {
            switch mediaAttachement!.mediaType {
            case .image:
                mediaType = CommentType.image
            case .audio:
                mediaType = CommentType.audio
            case .video:
                mediaType = CommentType.video
            }
            commentText = nil
        }
        let parentCommentDepth = parentCommentDepth ?? "0"
        
        var replyCommentDepth = 0
        if parentCommentId != nil {
            replyCommentDepth = Int(parentCommentDepth)! + 1
        }
        
        let commentEntity = CommentEntity(id: UUID().uuidString, postId: postId, parentCommentId: parentCommentId, text: commentText, type: mediaType.rawValue, mediaName: fileName, createdAt: Utility.getISO8601Date(), replyCount: "0", parentCommentDepth: parentCommentDepth, depth: "\(replyCommentDepth)")
        return commentEntity
    }
    
    func addComment(postId: String, mediaAttachement: MediaAttachment?, fileName: String?, commentText: String?, parentCommentId: String? = nil, parentCommentDepth: String? = nil) async throws -> CommentDTO {
        let comment = getCommentEntity(postId: postId, mediaAttachement: mediaAttachement, fileName: fileName, commentText: commentText, parentCommentId: parentCommentId, parentCommentDepth: parentCommentDepth)
        guard let commentEntity = comment else {
            throw CustomError.message(AppText.invalidComment)
        }
        
        var fields: [String: Any] = [
            "type": ["stringValue": commentEntity.type],
            "createdAt": ["stringValue": commentEntity.createdAt],
            "postId": ["stringValue": commentEntity.postId],
            "replyCount": ["integerValue": commentEntity.replyCount]
        ]
        if let parentCommentId = commentEntity.parentCommentId {
            fields["parentCommentId"] = ["stringValue": parentCommentId]
            if let parentCommentDepth = commentEntity.parentCommentDepth {
                fields["parentCommentDepth"] = ["stringValue": parentCommentDepth]
            }
        }
        if let text = commentEntity.text {
            fields["text"] = ["stringValue": text]
        }
        
        if let mediaName = commentEntity.mediaName {
            fields["mediaName"] = ["stringValue": mediaName]
        }
        
        if let depth = commentEntity.depth {
            fields["depth"] = ["stringValue": depth]
        }
        
        let body: [String: Any] = [ "fields": fields ]
        
        let addCommentNetworkRequest = DefaultNetworkRequest(path: AppConfiguration.APIEndPoint.addComment + "/\(String(describing: commentEntity.id))", method: .patch, headerParameters: ["Authorization": "Bearer \(AppConfiguration.token)", "Content-Type": "application/json"], bodyParameters: body)
        try await apiDataTransferService.request(request: addCommentNetworkRequest)
        
        if commentEntity.parentCommentId != nil {
            do {
                try await updateParentCommentsReplyCounts(commentEntity.parentCommentId)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return CommentDTO(id: commentEntity.id, postId: commentEntity.postId, parentCommentId: commentEntity.parentCommentId, text: commentEntity.text, type: commentEntity.type, mediaName: commentEntity.mediaName, createdAt: commentEntity.createdAt, replyCount: commentEntity.replyCount, depth: commentEntity.depth, parentCommentDepth: commentEntity.parentCommentDepth)
    }
    
    func fetchComment(commentId: String) async throws -> CommentDTO {
        let fetchCommentNetworkRequest = DefaultNetworkRequest(path: AppConfiguration.APIEndPoint.fetchAComment + "\(commentId)", method: .get, headerParameters: ["Authorization": "Bearer \(AppConfiguration.token)", "Content-Type": "application/json"])
        
        let firestoreComment: FirestoreCommentDocument = try await apiDataTransferService.request(request: fetchCommentNetworkRequest)
        let commentDTO = CommentDTO(from: firestoreComment)
        if let comment = commentDTO {
            return comment
        }
        throw CustomError.message("Failed to fetch comment by comment ID")
    }
    
    func getComments(postId: String, limit: Int, startAt: String?) async throws -> [CommentDTO] {
        
        // Firebase Needs following Query Params
        var structuredQuery: [String: Any] = [
            "from": [["collectionId": "comments"]],
            "orderBy": [[
                "field": ["fieldPath": "createdAt"],
                "direction": "DESCENDING"
            ]],
            "limit": limit
        ]
        if let startAt = startAt {
            structuredQuery["startAt"] = [
                "values": [
                    ["stringValue": startAt]
                ]
            ]
        }
        let body: [String: Any] = [
            "structuredQuery": structuredQuery
        ]
        
        let fetchCommentsNetworkRequest = DefaultNetworkRequest(path: AppConfiguration.APIEndPoint.fetchComments, method: .post, headerParameters: ["Authorization": "Bearer \(AppConfiguration.token)", "Content-Type": "application/json"], bodyParameters: body)
        
        let firstoreComments: [FirestoreCommentssDocumentWrapper] = try await apiDataTransferService.request(request: fetchCommentsNetworkRequest)
        let comments = firstoreComments.compactMap { comment in
            if comment.document.fields.postId?.stringValue == postId && comment.document.fields.parentCommentId == nil{
                return CommentDTO(from: comment.document)
            }
            return nil
        }
        return comments
    }
}
