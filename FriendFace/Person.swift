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

extension Person {
    init(person: CDPerson) {
        self.id = person.wrappedId
        self.isActive = person.isActive
        self.name = person.wrappedName
        self.age = person.wrappedAge
        self.company = person.wrappedCompany
        self.email = person.wrappedEmail
        self.address = person.wrappedAddress
        self.about = person.wrappedAbout
        self.registered = person.wrappedRegistered
        self.tags = person.tagsArray
        self.friends = person.friendsArray.map { Friend.init(friend: $0) }
    }
}
