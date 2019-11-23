//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import Foundation

struct Friend {
    let id: String
    let name: String
}

extension Friend: Decodable {}

extension Friend {
    init(friend: CDFriend) {
        self.id = friend.wrappedId
        self.name = friend.wrappedName
    }
}
