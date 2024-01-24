//
//  ContentView.swift



import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddPatient = false
    @State var showingAlert = false
    @State var menu = Bundle.main.decode([HPItem].self, from: "HP.json")
    @State var name = "Enter Name"
    @State private var addPatientToggle = false
    @State private var deleteIndexSet: IndexSet?
    @State private var username: String = "Todd Myers"
    @State private var password: String = "1234"
    
    var body: some View {
        
        NavigationStack {
            
            List {
                Section{
                    ForEach(expenses.items, id: \.id) { item in
                        NavigationLink(value: item) {
                            ItemRow(item: item)
                            
                        }
                        
                    }
                    .onMove(perform: onMove)
                    .swipeActions(edge: .leading) {
                        Button {
                            
                        } label: {
                            Label("Pin", systemImage: "pin.fill")
                        }
                        .tint(.indigo)
                    }
                    .swipeActions(allowsFullSwipe: false) {
                        // MARK: Discharge Button
                        
                        Button(role: .cancel) {
                            showingAddPatient = true
                        } label: {
                            Label("Discharge", systemImage: "accessibility.badge.arrow.up.right")
                        }.imageScale(.small)
                            .tint(.indigo)
                    
                    
//                    }.sheet(isPresented: $showingAddPatient) {
//                        AddView(expenses: expenses)}
                        // MARK: Delete Button
                        Button(role: .destructive) {
                            print("Deleting conversation")
                            showingAlert = true
                                                        
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                        }.sheet(isPresented: $showingAddPatient) {
                            AddView(expenses: expenses)}
                    //.font(.footnote)
                    
                    .alert("Delete Patient", isPresented: $showingAlert, actions: {
                        TextField("Username", text: $username)
                        
                        SecureField("Password", text: $password)
                        
                        Button("Delete", action: {})
                        //Button("Delete", action: {delete(offsets: IndexSet)})
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Please enter your username and password.")
                    })
                    
                    
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
                    showingAddPatient = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddPatient) {
                AddView(expenses: expenses)
            }
            .navigationBarTitle("Resident", displayMode: .inline)
            .listStyle(.grouped)
        }
        
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        menu.move(fromOffsets: source, toOffset: destination)
    }
    
    
    private func delete(at offsets: IndexSet) {
        menu.remove(atOffsets: offsets)
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
