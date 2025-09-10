//
//  UploadMediaBottomSheetViewModel.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 05/09/2025.
//

import Foundation
import UniformTypeIdentifiers
import Combine
import UIKit

class UploadMediaSheetViewModel: ObservableObject {
    
    @Published var loadState: LoadState = .unknown
    
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    
    @Published var isImporting = false
    
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    var resolvedUIImage: UIImage? {
        guard case let .loaded(_, data) = loadState, let data = data, let uiImage = UIImage(data: data) else {
            return nil
        }
        return uiImage
    }
    
    var resolvedMediaURL: URL? {
        guard case let .loaded(url, _) = loadState, let url = url else {
            return nil
        }
        return url
    }
    
    var resolvedMediaType: MediaType? {
        if resolvedUIImage != nil {
            return .image
        } else if let url = resolvedMediaURL {
            return mediaType(url: url)
        }
        return nil
    }
    
    
    init() {
        $loadState
            .sink { [weak self] newState in
                self?.handleLoadStateChange(newState)
            }
            .store(in: &cancellables)
        
        $isImporting
            .sink { [weak self] flag in
                if flag {
                    self?.loadState = .loading
                } else {
                    if case .loading = self?.loadState {
                        self?.loadState = .unknown
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func handleLoadStateChange(_ state: LoadState) {
        switch state {
        case .unknown:
            hideError()
            isLoading = false
        case .failed:
            handleError()
            isLoading = false
        case .loaded(let url, let image):
            isLoading = false
        case .loading:
            isLoading = true
        }
    }
    
    func updateData(_ result: Result<[URL], any Error>) {
        switch result {
        case .success(let urls):
            if let firstURL = urls.first {
                if let mediaType = mediaType(url: firstURL), mediaType == .image {
                    do {
                        let imageData = try Data(contentsOf: firstURL)
                        loadState = .loaded(firstURL, imageData)
                    } catch {
                        errorMessage = "\(AppText.failToPickImageFromURL) \(error.localizedDescription)"
                        loadState = .failed
                    }
                } else {
                    loadState = .loaded(firstURL, nil)
                }
            }
        case .failure(let error):
            errorMessage = "\(AppText.failPickingDocument) \(error.localizedDescription)"
            loadState = .failed
        }
    }
    
    func mediaType(url: URL) -> MediaType? {
        do {
            let resourceValues = try url.resourceValues(forKeys: [.typeIdentifierKey])
            guard let typeIdentifier = resourceValues.typeIdentifier else {
                return nil
            }
            
            if let utType = UTType(typeIdentifier) {
                if utType.conforms(to: .image) {
                    return .image
                } else if utType.conforms(to: .audio) {
                    return .audio
                } else if utType.conforms(to: .movie) {
                    return .video
                }
            }
        } catch {
            errorMessage = "\(AppText.errorGettingResourceTypeFromURL)\(error)"
            loadState = .failed
        }
        return nil
    }
    
    func validateAndSetMedia(url: URL?, imageData: Data?) async {
        guard (imageData != nil || url != nil)  else {
            await handleGalleryPickingError()
            return
        }
        await MainActor.run {
            loadState = .loaded(url, imageData)
        }
    }

    @MainActor
    func handleGalleryPickingError() {
        errorMessage = AppText.failPickingFromGallery
        loadState = .failed
    }
    
    func handleError() {
        if errorMessage.isEmpty || errorMessage.count == 0 {
            errorMessage = AppText.mediaTypeUnknown
        }
        showErrorAlert = true
    }
    
    func hideError() {
        showErrorAlert = false
        errorMessage = ""
    }
}
