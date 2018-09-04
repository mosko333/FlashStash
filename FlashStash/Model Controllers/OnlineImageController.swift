//
//  OnlineImageController.swift
//  FlashStash
//
//  Created by Adam on 02/09/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class OnlineImageController {
    struct Constants {
        static let baseURL = URL(string: "https://contextualwebsearch.com/api/Search/ImageSearchAPI")
    }
    //
    // MARK: - Methods
    //
    static func fetchImageSearchResultWith(searchTerm: String, completion: @escaping (([ImageSearchResult]?) -> Void)) {
        // URL
        guard let url = Constants.baseURL else { completion(nil) ; return }
        // Query
        let urlParamaters = [ "q" : searchTerm,
                              "count" : "200",
                              "autoCorrect" : "true",
                              "safeSearch" : "true" ]
        var componets = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let queryItems = urlParamaters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        componets?.queryItems = queryItems
        guard let finalUrl = componets?.url else {
            print("❌ Error creating complete url")
            completion(nil) ; return }
        print("📡 \(finalUrl.absoluteString) 📡")
        
        //DataTask
        URLSession.shared.dataTask(with: finalUrl) { (data, _, error) in
            if let error = error {
                print("❌ Error downloading ImageSearchResult with DataTask \(error.localizedDescription)")
                completion(nil) ; return }
            guard let data = data else { completion(nil) ; return }
            do {
                let jsonDecoder = JSONDecoder()
                let topLevelData = try jsonDecoder.decode(TopLevelData.self, from: data)
                let imageSearchResults = topLevelData.value
                completion(imageSearchResults) ; return
            } catch {
                print("❌ Error decoding fetched ImageSearchResults: \(error.localizedDescription)")
                completion(nil)
            }
            }.resume()
    }
    
    static func fetchImageWith(urlString: String, completion: @escaping ((UIImage?) -> Void)) {
        // URL
        guard let url = URL(string: urlString) else { completion(nil) ; return }
        print(" 📡 \(url.absoluteString) 📡")
        
        //DataTask
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(" ❌ Error downloading image with DataTask \(error.localizedDescription)")
                completion(nil) ; return }
            guard let data = data,
                let image = UIImage(data: data) else { completion(nil) ; return }
            completion(image)
            }.resume()
    }
}
