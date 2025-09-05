//
//  UploadMediaBottomSheetViewModel.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 05/09/2025.
//

import Foundation
import SwiftUICore
import UniformTypeIdentifiers
import Combine
import _PhotosUI_SwiftUI

class UploadMediaSheetViewModel: ObservableObject {
    
    @Published var loadState: LoadState = .unknown
    
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    
    @Published var isImporting = false
    
    @Published var selectedFileURL: URL?
    @Published var selectedImage: Image?
    
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    var resolvedMediaType: MediaType? {
        if selectedImage != nil {
            return .image
        } else if let url = selectedFileURL {
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
        
        // Following code worked fine but the behaviour when manually Files screen get closed without selecting any file need to be handled, and this seems unnecessary right now.
//        $isImporting
//            .sink { [weak self] flag in
//                if flag {
//                    self?.loadState = .loading
//                }
//            }
//            .store(in: &cancellables)
    }
    
    private func handleLoadStateChange(_ state: LoadState) {
        switch state {
        case .unknown:
            hideError()
            selectedFileURL = nil
            selectedImage = nil
            isLoading = false
        case .failed:
            handleError()
            isLoading = false
        case .loaded(let url, let image):
            self.selectedFileURL = url
            self.selectedImage = image
            isLoading = false
        case .loading:
            isLoading = true
        }
    }
    
    func updateData(_ result: Result<[URL], any Error>) {
        switch result {
        case .success(let urls):
            if let firstURL = urls.first {
                loadState = .loaded(firstURL, nil)
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
    
    func loadMedia(from item: PhotosPickerItem) async {
       guard let loaded = try? await item.loadTransferable(type: TransferableAsset.self) else {
           await handleGalleryPickingError()
           return
        }
        guard (loaded.image != nil || loaded.url != nil)  else {
            await handleGalleryPickingError()
            return
        }
        await MainActor.run {
            loadState = .loaded(loaded.url, loaded.image)
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
