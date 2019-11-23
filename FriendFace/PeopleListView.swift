//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import SwiftUI
import CoreData

struct PeopleListView<Content: View>: View {

    var fetchRequest: FetchRequest<CDPerson>
    let content: (Person) -> Content
    var results: FetchedResults<CDPerson> { fetchRequest.wrappedValue }
    
    var body: some View {
        List(results, id: \.self) {
            self.content(Person(person: $0))
        }
    }
    
    init(@ViewBuilder content: @escaping (Person) -> Content) {
           fetchRequest = FetchRequest<CDPerson>(
               entity: CDPerson.entity(),
               sortDescriptors: [
                NSSortDescriptor(key: #keyPath(CDPerson.name), ascending: true)
               ])
        self.content = content
    }
}

struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleListView() { (person: Person) in
            Text("\(person.name)")
        }
    }
}
