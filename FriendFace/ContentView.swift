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
            List {
                ForEach(people.items, id: \.id) { person in
                    VStack(alignment: .leading) {
                        Text("\(person.name)")
                            .font(.headline)

                        Text("Age: \(person.age)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationBarTitle("FriendFace")
            .navigationBarItems(trailing: Button("Fetch") {
                    self.fetch()
            })
        }
        .alert(isPresented: self.$showingError) {
            Alert(title: Text("Error"), message: Text(self.errorMessage), dismissButton: .default(Text("ok")))
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
