//
//  testList.swift
//  iDine
//
//  Created by Todd Myers on 12/28/23.
//

//import SwiftUI
//
//struct Item: Identifiable {
//    let id = UUID()
//    let title: String
//}
//
//struct ContentView1: View {
//    @State private var items : [Item] = (0..<1).map { Item(title: "Item #\($0)") }
//    @State var selection = Int?.none
//
//    var body: some View {
//        List(selection: $selection){
//            ForEach(items) { item in
//                Text(item.title).frame(maxWidth: .infinity, alignment: .leading)
//            }.onDelete(perform: onDelete)
//             .onMove(perform: onMove)
//             .onInsert(of: [String(kUTTypeFileURL)], perform: onInsert)
//        }
//    }
//
//    private func onDelete(offsets: IndexSet) {
//        items.remove(atOffsets: offsets)
//    }
//
//    private func onMove(source: IndexSet, destination: Int) {
//        items.move(fromOffsets: source, toOffset: destination)
//    }
//
//    private func onInsert(at offset: Int, itemProvider: [NSItemProvider]) {
//       for provider in itemProvider {
//            provider.loadItem(forTypeIdentifier: (kUTTypeFileURL as String), options: nil) {item, error in
//                guard let data = item as? Data, let url = URL(dataRepresentation: data, relativeTo: nil) else { return }
//
//                DispatchQueue.main.async {
//                    self.items.insert(Item(title: url.path), at: offset)
//                   // let bookMarkData = try url.bookmarkData(options: .securityScopeAllowOnlyReadAccess, includingResourceValuesForKeys: nil, relativeTo: nil)
//                }
//            }
//        }
//    }
//}
//#Preview {
//    testList()
//}
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
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = Patient(id: UUID(), name: name, Location: location, Room: Int(room), Diagnosis1: diagnosis1, Restrictions: [], Physician: "", CC: "testCC", HPI: "", MedHx: "", SurgHx: "", SocHx: "", FamHx: "", ROS: "", Allergies: "", Medications: "", Vaccinations: "", PE: "", Assess: "", Plan: "")
                    //expenses.items.append(item)
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
