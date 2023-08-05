//
//  ImageConfiguration.swift
//  ImageMaker
//
//  Created by 이정민 on 2023/07/29.
//

import Foundation

struct ImageConfiguration: Encodable {
    let prompt: String
    let negetivePrompt: String
    let imageQuality: Int
    let imageCount: Int
    let noiseRemoveSteps: Int
    let noiseRemoveScale: Double
    let decoder: String
    let imageFormat: String = "png"
    let returnType: String = "base64_string"
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
        case imageFormat = "image_format"
        case returnType = "return_type"
        case noiseRemoveStepsByDecoder = "num_inference_steps"
        case noiseRemoveScaleByDecoder = "guidance_scale"
    }
}
