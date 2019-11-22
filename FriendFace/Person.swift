//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import Foundation

struct Person {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
}

extension Person: Decodable {}
