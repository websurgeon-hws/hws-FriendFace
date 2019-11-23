//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import SwiftUI

struct PersonDetailView: View {
    let person: Person
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("ID")
                    Spacer()
                    Text(person.id)
                }
                HStack {
                    Text("Age")
                    Spacer()
                    Text("\(person.age)")
                }
                HStack {
                    Text("Company")
                    Spacer()
                    Text(person.company)
                }
                HStack {
                    Text("Address")
                    Spacer()
                    Text(person.address)
                }
            }
            .navigationBarTitle("\(person.name)")
        }
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: Person(id: "id-1", isActive: true, name: "a name", age: 23, company: "a company", email: "address@email.com", address: "address", about: "about info", registered: "registered", tags: ["tag 1"], friends: [])
        )
    }
}
