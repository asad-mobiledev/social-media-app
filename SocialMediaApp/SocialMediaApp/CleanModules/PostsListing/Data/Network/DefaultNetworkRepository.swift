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
    
    
   let db = Firestore.firestore()
    let baseURL = "https://firestore.googleapis.com/v1/"
    let projectID = "socialmediaapp-44bab"
    var postsEndPoint: String {
        "projects/\(projectID)/databases/(default)/documents/posts"
    }
    var documentName: String? = nil
    var url: URL {
        return URL(string: baseURL + postsEndPoint + (documentName == nil ? "" : "/\(documentName!)"))!
    }
    var paginatedURL: URL {
        return URL(string: baseURL + "projects/socialmediaapp-44bab/databases/(default)/documents:runQuery")!
    }
        
    func getPosts(limit: Int, startAt: String?) async throws -> [PostDTO] {
        
        // Query params depends on the server what it requires, so below is what firebase requires.
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
        
        return try await apiDataTransferService.request(request: postsListNetworkRequest)
    }

    
    func createPost(mediaType: MediaType, mediaName: String) async throws -> PostDTO {
        
        let date = Utility.getISO8601Date()
        self.documentName = UUID().uuidString
        let post = PostDTO(id: self.documentName!, postType: mediaType.rawValue, mediaName: mediaName, date: date)
        
        
        let token = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCvG6H6U0bY2I9o\n5Zm0u6cOLzSqCSkxExiS88hzXVCZsEBym5AF+DwbPOK589X95K9aDkOvXIgyDmw7\nU6aWzZHZ1ycVetb5BGzpgme9HhuCaT3cwb8xNjFZbuwcQXHQs0mw/YTxfG9KmW2z\n5uhNAy8n79Oi/y1HNlFsihffWWBW61TXyGRGWZo0ZkN1KInMpDRNvLgo0jQY5k2K\nok4IlNfLzorNbVFURyiM8F10KnSio+Sv4eUti1ttUQ6nJvj4wzj1C7IpkOux18z7\nrQLAT7tvo8ddCdRY/1TC1pCO13jnbp9e6uLVCyeZwf3JWpcRLnQQKAqmvf66y6YO\nDXCOIEBlAgMBAAECggEAASy/aYeR9T0S2Dgj9KiVvbw4/F+hlLOLgwJOY60bp1m7\n3cUtvAYlTNE+ixz0C60ZSnqlDeTjPmvhuROp7Qq54HIxhCm5LogWhLNAc7f/cNOa\nWjKxYXBWLCr7dEFQHRu3OtwI+Rp/SSg0ce7FGxO1GGlNXrTCVE3NKqxlhaw6yntM\nJoqmrtFJ6GMs8JHgtGrKT8UYHIwPTLlh6qmOSp3ew9pid34u3O2r0E02ovliPloA\ntm3X4FL/ELaXIdU6ZZcr882ONSMX8fJqh/BD74+57kRr6l40WnQ2OxQMPT2fY8nv\nHesLGJcY+58qS4md3lkekIVSlaJmTKy5inuCzrI3ZwKBgQDuExc7Xl5N4P3Kc2k+\n/qvOHU8dfyqSHh8dbJQ7nUhcFLPKVjABRLWNUerp8/9Q97W5Tch9vns1Xu8sr92R\nCBgiRQIogW8z4B0ISVVjOeQOv/9WXwLEQwNhfqARYVeDFt+yZB0BjVkWyNzM0Bvj\nwlXmU6uxxpXWP4SsimNydfpjzwKBgQC8Stq2iQ4Bc2MpGRfuyHtA7kGmhCdtp7Qr\nKX0aYtYWYV1seTW20Hho35XFu6cpVA3N+XZMt2h9il3ZA//lZMJeJ305KXQ0RnCF\nlFFj87PB8kA+wbEQgHhgXq4xVf3ADJYim0YoOtP13HVpWNJvX/6IllYTWTYdroi+\nvHNsqYPBiwKBgGmSoay8DkmuyhxqzXMX8Av4x0qnR7OAFAAyVBGTj7D1pTzGt4b4\ndyHx/6A7iS7YigdgTNYmD/D85kcEvdZApqMbwvc/Xpa8fWNdUbYsx8sarRoaC9oI\ndYlYY5cReYMyM4SiDJLRoX4PGIrihlubpAf9dpfhHjTh+e2heLQbSSvVAoGBALJi\nGCKmZWZqcp8U7t+Bf4NcNUYUHWZ9YushOywsRradN2z0yDaR+gEhETtrNEqrHwjs\nNW8osw18cLyQVXZ1ps6cir4Ez9pWgXOLuDABSWOMpeDOj3kavPBPwqdq2COByRqw\nEB883GIoofNT+skZIIM2KgXalrI4D8TjtFZVokVRAoGBANfnSI410upepyF1s/E0\nt7sr1XHRwKe1jq5JD04eiLR5LusUP9Y8MOEFC0sdfXFCC+fIv4FLMoPDieKLMcoj\nQgMgqubVuCbmi8KhNi4wkzTATWb/4gwcS7vBQYeS1c4NSzOXTf2YfwcOiv81HeOF\nDl7U/eDZuyGx1p2cCaMt22Hg"
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let jsonBody: [String: Any] = [
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
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: jsonBody)
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                let message = String(data: data, encoding: .utf8) ?? "Unknown error"
                print(message)
            }
            print("Document added via REST API")
        } catch {
            throw CustomError.message(error.localizedDescription)
        }
        return post
    }
}
