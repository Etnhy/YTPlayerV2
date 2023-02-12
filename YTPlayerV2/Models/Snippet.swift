//
//  Snippet.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 09.02.2023.
//

import Foundation

 //MARK: - Snippet
/// относистся ко всем Snippet
struct Snippet: Codable {
    let publishedAt: String
    let title: String
    let thumbnails: Thumbnails
    let resourceId: ResourceId?
    let localized: Localized?
}
