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

class CreatePostBottomSheetViewModel: ObservableObject {
    
    @Published var loadState: LoadState = .unknown
    
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    
    @Published var isImporting = false
    
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    var resolvedMediaURL: URL? {
        guard case let .loaded(url) = loadState, let url = url else {
            return nil
        }
        return url
    }
    
    private var resolvedMediaType: MediaType? {
        if let url = resolvedMediaURL {
            return mediaType(url: url)
        }
        return nil
    }
    
    var mediaAttachment: MediaAttachment? {
        guard let type = resolvedMediaType else { return nil }
        return MediaAttachment(mediaType: type, url: resolvedMediaURL)
    }
    
    init() {
        $loadState
            .sink { [weak self] newState in
                Task { @MainActor in
                    self?.handleLoadStateChange(newState)
                }
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
    @MainActor
    private func handleLoadStateChange(_ state: LoadState) {
        switch state {
        case .unknown:
            hideError()
            isLoading = false
        case .failed:
            handleError()
            isLoading = false
        case .loaded(_):
            isLoading = false
        case .loading:
            isLoading = true
        }
    }
    
    func updateData(_ result: Result<[URL], any Error>) {
        switch result {
        case .success(let urls):
            if let firstURL = urls.first {
                loadState = .loaded(firstURL)
            }
        case .failure(let error):
            errorMessage = "\(AppText.failPickingDocument) \(error.localizedDescription)"
            loadState = .failed
        }
    }
    
    func mediaType(url: URL) -> MediaType? {
        if url.startAccessingSecurityScopedResource() {
            defer { url.stopAccessingSecurityScopedResource() }
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
                Task { @MainActor in
                    errorMessage = "\(AppText.errorGettingResourceTypeFromURL)\(error)"
                    loadState = .failed
                }
            }
        } else {
            Task { @MainActor in
                errorMessage = AppText.filesPermissionIssue
                loadState = .failed
            }
        }
        return nil
    }
    
    func validateAndSetMedia(url: URL?) async {
        guard url != nil  else {
            await handleGalleryPickingError()
            return
        }
        await MainActor.run {
            loadState = .loaded(url)
        }
    }

    @MainActor
    func handleGalleryPickingError() {
        errorMessage = AppText.failPickingFromGallery
        loadState = .failed
    }
    
    @MainActor
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
