//
//  KarloServiceTests.swift
//  ImageMaker
//
//  Created by 이정민 on 2023/07/30.
//

import XCTest

final class KarloServiceTests: XCTestCase {
    var karloService: KarloService!
    var mockImageConfiguration: ImageConfiguration!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        karloService = .init()
        mockImageConfiguration = .init(prompt: "running horse in the sunset",
                                       negetivePrompt: "",
                                       imageQuality: 70,
                                       imageCount: 1,
                                       noiseRemoveSteps: 25,
                                       noiseRemoveScale: 5.0,
                                       decoder: "decoder_ddim_v_prediction",
                                       noiseRemoveStepsByDecoder: 50,
                                       noiseRemoveScaleByDecoder: 5.0)
    }

    func testImageGenerationSuccess() throws {
        let expectation = XCTestExpectation(description: "Image Generation Success Test")
        
        karloService.perfromImageGeneration(mockImageConfiguration) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(success.count, 1)
            case .failure(let failure):
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation])
    }
}
