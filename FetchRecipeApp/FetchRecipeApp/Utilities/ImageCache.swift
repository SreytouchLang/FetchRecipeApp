//
//  ImageCache.swift
//  FetchRecipeApp
//
//  Created by Sreytouch(Jessica) on 1/29/25.
//

import SwiftUI

actor ImageCache {
    static let shared = ImageCache()

    private var cache: [URL: Image] = [:]

    func getImage(for url: URL) async throws -> Image {
        if let cachedImage = cache[url] {
            return cachedImage
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        guard let uiImage = UIImage(data: data) else {
            throw URLError(.badURL)
        }

        let image = Image(uiImage: uiImage)
        cache[url] = image
        return image
    }
}

