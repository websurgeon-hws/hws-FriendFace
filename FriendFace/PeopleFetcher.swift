//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import Foundation

enum PeopleFetcherError: Error {
    case unhandled(error: Error?)
}

class PeopleFetcher {
    func fetch(completion: @escaping (Result<[Person], PeopleFetcherError>) -> Void) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil

        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)

        URLSession(configuration: config).dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.unhandled(error: error)))
                return
            }
            
            do {
                let decodedPeople = try JSONDecoder().decode([Person].self, from: data)
                completion(.success(decodedPeople))
            } catch {
                completion(.failure(.unhandled(error: error)))
            }
        }.resume()
    }
}
