//
//  encodeDecode.swift
//  iDine
//
//  Created by Todd Myers on 12/28/23.
//

import Foundation

class Expenses: ObservableObject {
    @Published var patients = [Patient]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? JSONEncoder().encode(patients) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        // Try to load saved data from the UserDefaults
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            // If that key exists, then try to decode the items from the UserDefaults into HPItems
            if let decodedItems = try? JSONDecoder().decode([Patient].self, from: savedItems) {
                patients = decodedItems
                if patients.count < 0 {
                    return
                }
            }
        }
        // If no items were found, then create new items from the JSON
        patients = Bundle.main.decode([Patient].self, from: "HP.json")
        
    }
}
