//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var people = People()

    @State private var showingError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            List(people.items, id: \.id) {
                Text("\($0.name)")
            }
            .navigationBarTitle("FriendFace")
            .navigationBarItems(trailing: Button("Fetch") {
                    self.fetch()
            })
        }
    }
    
    func fetch() {
        PeopleFetcher().fetch { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(people):
                     self.people.items = people
                case let .failure(error):
                    self.showingError = true
                        self.errorMessage = " \(error)"
                }
           }
       }
    }
}

struct ContentView_Previews: PreviewProvider {    
    static var previews: some View {
        ContentView(people: People(items: [
            Person(id: "id-1", isActive: true, name: "a name", age: 23, company: "a company", email: "address@email.com", address: "address", about: "about info", registered: "registered", tags: ["tag 1"], friends: [])
        ]))
    }
}
