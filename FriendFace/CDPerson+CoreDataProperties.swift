//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//
//

import Foundation
import CoreData


extension CDPerson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPerson> {
        return NSFetchRequest<CDPerson>(entityName: "CDPerson")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var isActive: Bool
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: String?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?
    
    var wrappedId: String {
        return id ?? ""
    }

    var wrappedName: String {
        return name ?? ""
    }
    
    var wrappedAge: Int {
        return Int(age)
    }
    
    var wrappedCompany: String {
        return company ?? ""
    }
    
    var wrappedEmail: String {
        return email ?? ""
    }
    
    var wrappedAddress: String {
        return address ?? ""
    }
    
    var wrappedAbout: String {
        return about ?? ""
    }
    
    var wrappedRegistered: String {
        return registered ?? ""
    }
    
    var tagsArray: [String] {
        return tags?.components(separatedBy: ",") ?? []
    }
    
    var friendsArray: [CDFriend] {
        let set = friends as? Set<CDFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for friends
extension CDPerson {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CDFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CDFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}
