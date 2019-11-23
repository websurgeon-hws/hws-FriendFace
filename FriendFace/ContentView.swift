//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var showingError = false
    @State private var errorMessage = ""
    
    @State private var showingDetailView = false

    var body: some View {
        NavigationView {
            PeopleListView { person in
                NavigationLink(destination: PersonDetailView(person: person)) {
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
            .navigationBarItems(trailing:
                HStack {
                    Button("DeleteAll") {
                        self.deleteAll()
                    }
                    Button("Fetch") {
                        self.fetch()
                    }
                }
            )
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
                    self.savePeople(people: people)
                case let .failure(error):
                    self.showingError = true
                    self.errorMessage = " \(error)"
                }
            }
        }
    }
    
    func savePeople(people: [Person]) {
        moc.performAndWait {
            people.forEach { person in
                let cdPerson = CDPerson(context: moc)
                cdPerson.id = person.id
                cdPerson.name = person.name
                cdPerson.age = Int16(person.age)
            }
        }
        
        if moc.hasChanges {
            try? moc.save()
        }
    }
    
    func deleteAll() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()

        fetchRequest.entity = CDPerson.entity()
        fetchRequest.includesPropertyValues = false

        do
        {
            let results = try moc.fetch(fetchRequest)
            for managedObject in results
            {
                if let object = managedObject as? NSManagedObject {
                    moc.delete(object)
                }
            }
        } catch let error as NSError {
            print("Delete All Error : \(error) ")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let moc: NSManagedObjectContext = {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let person = CDPerson(context: context)
        person.id = "id-1"
        person.name = "name 1"
        person.age = 23

        try? context.save()

        return context
    }()
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, moc)
    }
}
