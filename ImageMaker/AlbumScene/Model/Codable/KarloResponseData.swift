//
//  KarloResponseData.swift
//  ImageMaker
//
//  Created by 이정민 on 2023/07/30.
//

//import Foundation

struct KarloResponseData: Decodable {
    let id, modelVersion: String
    let images: [ResultImage]

    enum CodingKeys: String, CodingKey {
        case id
        case modelVersion = "model_version"
        case images
    }
}

struct ResultImage: Decodable {
    let id: String
    let image: String
    let seed: Int
    let nsfwContentDetected: Bool?
    let nsfwScore: Double?

    enum CodingKeys: String, CodingKey {
        case id, image, seed
        case nsfwContentDetected = "nsfw_content_detected"
        case nsfwScore = "nsfw_score"
    }
}
