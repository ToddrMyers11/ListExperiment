//

//
//  Created by Todd Myers on 12/28/23.
//


import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var location = ""
    @State private var room = 0
    @State private var diagnosis1 = ""
    @State private var restrictions = []
    
    let types = ["RRC", "VM"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Location", selection: $location) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Room", value: $room, format: .number)
                                  .keyboardType(.decimalPad)
                TextField("Diagnoses", text: $diagnosis1)
            }
            .navigationTitle("Add new patient")
            .toolbar {
                Button("Save") {
                    let item = HPItem(id: UUID(), name: name, Location: location, Room: Int(room), Diagnosis1: diagnosis1, Restrictions: [], Physician: "", CC: "testCC", HPI: "", MedHx: "", SurgHx: "", SocHx: "", FamHx: "", ROS: "", Allergies: "", Medications: "", Vaccinations: "", PE: "", Assess: "", Plan: "")
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
