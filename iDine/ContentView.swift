//
//  ContentView.swift
//  iDine
//
//  Created by Paul Hudson on 08/02/2021.
//



import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    @State var showingAlert = false
    @State var menu = Bundle.main.decode([HPItem].self, from: "HP.json")
    @State var name = "Enter Name"
    @State private var addPatientToggle = false
    @State private var deleteIndexSet: IndexSet?

    var body: some View {
       
        NavigationStack {
            
            List {
                Section{
                    ForEach(expenses.items, id: \.id) { item in
                        NavigationLink(value: item) {
                            ItemRow(item: item)
                            
                        }
                        //}
                    }//.onDelete(perform: delete)

                    .swipeActions(allowsFullSwipe: false) {
//Archive Button
                        Button(role: .cancel) {
                            //Toggle("Toggle switch", isOn: $showingAlert)
                                   //showingAlert = true
                            //AlertView()
                            //showingAlert = true
                        } label: {
                            Label("Archive", systemImage: "file.fill")
                        }
                        .tint(.indigo)
//Delete Button
                        Button(role: .destructive) {
                            print("Deleting conversation")
                            showingAlert = true
                            //menu.remove(atOffsets: offsets)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                    
                    //.onDelete(perform: delete)
                    //.onMove(perform: onMove)
                    .alert(isPresented:$showingAlert) {
                                Alert(
                                    title: Text("Are you sure you want to delete this?"),
                                    message: Text("There is no undo"),
                                    primaryButton: .destructive(Text("Delete")) {
                                        print("Deleting...")
                                       
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                    
                    //.swipeActions {
//                               Button("Delete") {
//                                   
//                               }
//                               .tint(.green)
//                           }
                }header: {
                    Text("Patients")
                  } footer: {
                    Text("\(menu.count) patients")
                  }
            }
            .navigationDestination(for: HPItem.self) { item in
                ItemDetail(item: item)
            }
            .navigationTitle("Patient")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
            .navigationBarTitle("Resident", displayMode: .inline)
            .listStyle(.grouped)
//            .navigationBarItems(trailing: Button("Add") {
//                            addPatientToggle.toggle()
//                        }
}
        
    }
    private func addItemToRow() {
        self.menu.append(HPItem(id: UUID(), name: name, Location: "VM", Room: 5, Diagnosis1: "", Restrictions: ["D", "V"], Physician: "", CC: "testCC", HPI: "", MedHx: "", SurgHx: "", SocHx: "", FamHx: "", ROS: "", Allergies: "", Medications: "", Vaccinations: "", PE: "", Assess: "", Plan: ""))
    }
//        private func onDelete(offsets: IndexSet) {
//            menu.remove(atOffsets: offsets)
//            
//        }
//    func deleteConversion(at offsets: IndexSet) { menu.remove(atOffsets: offsets) }
//        private func onMove(source: IndexSet, destination: Int) {
//            menu.move(fromOffsets: source, toOffset: destination)
//        }
//    private func add() {
//        menu.append("New Item")
    //}

    private func delete(at offsets: IndexSet) {
        menu.remove(atOffsets: offsets)
    }

//    private func onMove(source: IndexSet, destination: Int) {
//        menu.move(fromOffsets: source, toOffset: destination)
//    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
