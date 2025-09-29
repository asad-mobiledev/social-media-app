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
    
    func addComment(commentEntity: CommentEntity) async throws -> CommentDTO {
        var fields: [String: Any] = [
            "type": ["stringValue": commentEntity.type],
            "createdAt": ["stringValue": commentEntity.createdAt],
            "postId": ["stringValue": commentEntity.postId]
        ]
        if let parentCommentId = commentEntity.parentCommentId {
            fields["parentCommentId"] = ["stringValue": parentCommentId]
        }
        if let text = commentEntity.text {
            fields["text"] = ["stringValue": text]
        }
        
        if let mediaName = commentEntity.mediaName {
            fields["mediaName"] = ["stringValue": mediaName]
        }
        let body: [String: Any] = [ "fields": fields ]
        
        let addCommentNetworkRequest = DefaultNetworkRequest(path: AppConfiguration.APIEndPoint.addComment + "/\(String(describing: commentEntity.id))", method: .patch, headerParameters: ["Authorization": "Bearer \(AppConfiguration.token)", "Content-Type": "application/json"], bodyParameters: body)
        try await apiDataTransferService.request(request: addCommentNetworkRequest)
        
        return CommentDTO(id: commentEntity.id, postId: commentEntity.postId, parentCommentId: commentEntity.parentCommentId, text: commentEntity.text, type: commentEntity.type, mediaName: commentEntity.mediaName, createdAt: commentEntity.createdAt)
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
