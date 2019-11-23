//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//
//

import Foundation
import CoreData


extension CDFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFriend> {
        return NSFetchRequest<CDFriend>(entityName: "CDFriend")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var friends: NSSet?

    var wrappedId: String {
        return id ?? ""
    }

    var wrappedName: String {
        return name ?? ""
    }
    
    var friendsArray: [CDPerson] {
        let set = friends as? Set<CDPerson> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for friends
extension CDFriend {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CDPerson)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CDPerson)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}
