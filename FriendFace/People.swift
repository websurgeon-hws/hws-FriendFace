//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import Foundation

class People: ObservableObject {
    @Published var items: [Person]
    
    init(items: [Person] = []) {
        self.items = items
    }
}
