//
//  encodeDecode.swift
//  iDine
//
//  Created by Todd Myers on 12/28/23.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [HPItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        // Try to load saved data from the UserDefaults
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            // If that key exists, then try to decode the items from the UserDefaults into HPItems
            if let decodedItems = try? JSONDecoder().decode([HPItem].self, from: savedItems) {
                items = decodedItems
                if items.count < 0 {
                    return
                }
            }
        }
        // If no items were found, then create new items from the JSON
        items = Bundle.main.decode([HPItem].self, from: "HP.json")
        
    }
}
