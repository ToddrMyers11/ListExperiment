//
//  HPViewModel.swift
//
//
//  Created by Todd Myers on 12/21/23.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [HPItem]()

    
    init() {
        
        // Create an instance of data service and get the data
        /// We can use this same class to get our data.
        if let localData = self.getLocalData(){
            self.items = localData
        }
        print(items)
        
    }
    
 
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) -> [HPItem]? {
        do {
            let decodedData = try JSONDecoder().decode([HPItem].self, from: jsonData)
            return decodedData
        } catch {
            print("decode error\(error.localizedDescription)")
        }
        return nil
    }
    
    func getLocalData() -> [HPItem]? {
        if let localData = self.readLocalFile(forName: "HP") {
            if let recipe = self.parse(jsonData: localData){
                return recipe
            }
        }
        return nil
    }
}

