//
//  ImageConfiguration.swift
//  ImageMaker
//
//  Created by 이정민 on 2023/07/29.
//

import Foundation

struct ImageConfiguration: Codable {
    let prompt: String
    let negetivePrompt: String
    let imageQuality: Int
    let imageCount: Int
    let noiseRemoveSteps: Int
    let noiseRemoveScale: Double
    let decoder: String
    let noiseRemoveStepsByDecoder: Int
    let noiseRemoveScaleByDecoder: Double
    
    enum CodingKeys: String, CodingKey {
        case prompt
        case negetivePrompt = "negative_prompt"
        case imageQuality = "image_quality"
        case imageCount = "samples"
        case noiseRemoveSteps = "prior_num_inference_steps"
        case noiseRemoveScale = "prior_guidance_scale"
        case decoder = "scheduler"
        case noiseRemoveStepsByDecoder = "num_inference_steps"
        case noiseRemoveScaleByDecoder = "guidance_scale"
    }
}
