//
//  GalleryData.swift
//  PhotoGalleryApp
//
//  Created by Prachi Bile on 01/06/21.
//

import Foundation

// MARK: - GalleryData
struct GalleryData: Decodable {
    let title: String
    let link: String
    let galleryDescription: String
    let modified: String
    let generator: String
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case title, link
        case galleryDescription = "description"
        case modified, generator, items
    }
}

// MARK: - Item
struct Item: Decodable {
    let title: String
    let link: String
    let media: Media
    let dateTaken: String
    let itemDescription: String
    let published: String
    let tags: String

    enum CodingKeys: String, CodingKey {
        case title, link, media
        case dateTaken = "date_taken"
        case itemDescription = "description"
        case published
        case tags
    }
}

// MARK: - Media
struct Media: Decodable {
    let m: String
}
