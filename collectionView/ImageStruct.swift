//
//  ImageStruct.swift
//  collectionView
//
//  Created by Nurmukhanbet Sertay on 07.05.2023.
//

import Foundation

// MARK: - ImageElement
struct ImageElement: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}

typealias Image = [ImageElement]
