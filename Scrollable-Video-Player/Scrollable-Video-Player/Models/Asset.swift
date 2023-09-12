//
//  Asset.swift
//  Scrollable-Video-Player
//
//  Created by Mohammad Sameer on 01/09/23.
//

import Foundation

struct Asset: Codable {
    let videoDetails: VideoDetails
    
    enum CodingKeys: String, CodingKey {
        case videoDetails = "assetDetails"
    }
}

struct VideoDetails: Codable {
    let id: String
    let title: String
    let description: String
    let duration: Int
    let thumbnails: [Thumbnail]
    let videoUri: VideoUri
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case duration = "duration"
        case thumbnails = "thumbnails"
        case videoUri = "videoUri"
    }
}

struct Thumbnail: Codable {
    let mainThumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case mainThumbnail = "mainThumbnail"
    }
}

struct VideoUri: Codable {
    let avcUri: String
    let hevcUri: String
    
    enum CodingKeys: String, CodingKey {
        case avcUri = "avcUri"
        case hevcUri = "hevcUri"
    }
}
