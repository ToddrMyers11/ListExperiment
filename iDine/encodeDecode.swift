//
//  encodeDecode.swift
//  iDine
//
//  Created by Todd Myers on 12/28/23.
//

//import Foundation
//
//class Expenses1: ObservableObject {
//    @Published var items = [HPItem]() {
//        didSet {
//            let encoder = JSONEncoder()
//            
//            if let encoded = try? JSONEncoder().encode(items) {
//                UserDefaults.standard.set(encoded, forKey: "Items")
//            }
//        }
//    }
//    
//    init() {
//        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
//            if let decodedItems = try? JSONDecoder().decode([HPItem].self, from: savedItems) {
//                items = decodedItems
//                return
//            }
//        }
//        
//        items = []
//    }
//}
