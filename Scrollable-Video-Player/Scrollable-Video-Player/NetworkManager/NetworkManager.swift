//
//  NetworkManager.swift
//  Scrollable-Video-Player
//
//  Created by Mohammad Sameer on 01/09/23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL: String = "https://zshorts-dev.zee5.com/v1/zShorts"
    
    private init() {}
    
    // Function to fetch videos
    func fetchVideos(completion: @escaping ([Asset]?, Error?) -> Void) {
        guard let url = URL(string: "\(baseURL)") else {
            completion(nil, NSError(domain: "Invalid URL", code: 1, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: 2, userInfo: nil))
                return
            }
            
            do {
                // Decode the JSON data as a dictionary
                if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // Extract the array of videos from the dictionary
                    if let videosData = jsonDictionary["assets"] as? [[String: Any]] {
                        // Convert the array of dictionaries to an array of Video objects
                        let decoder = JSONDecoder()
                        let videos = try decoder.decode([Asset].self, from: JSONSerialization.data(withJSONObject: videosData))
                        completion(videos, nil)
                    } else {
                        completion(nil, NSError(domain: "Invalid JSON structure", code: 3, userInfo: nil))
                    }
                } else {
                    completion(nil, NSError(domain: "Invalid JSON format", code: 3, userInfo: nil))
                }
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
