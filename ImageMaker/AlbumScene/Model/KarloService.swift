//
//  KarloService.swift
//  ImageMaker
//
//  Created by 이정민 on 2023/07/30.
//

import Foundation

struct KarloService {
    private let baseURL = "https://api.kakaobrain.com/v2/inference/karlo/t2i"
    
    func perfromImageGeneration(_ imageConfiguration: ImageConfiguration, _ completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(imageConfiguration)
            if let apiKey = fetchAPIKEY() {
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue(apiKey, forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
            }
        } catch {
            print("Error encoding to JSON: \(error)")
        }
    }
}

private extension KarloService {
    func fetchAPIKEY() -> String? {
        if let plistPath = Bundle.main.path(forResource: "APIKey", ofType: "plist"),
           let xml = FileManager.default.contents(atPath: plistPath) {
            do {
                if let plistData = try PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil) as? [String: Any] {
                    if let apiKey = plistData["REST_API_KEY"] as? String {
                        return apiKey
                    }
                }
            } catch {
                print("Error reading plist: \(error)")
            }
        }
        return nil
    }
}
