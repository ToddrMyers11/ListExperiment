//
//  ContentView.swift



import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showingAddPatient = false
    @State private var showingMoreSheet = false
    @State var name = "Enter Name"
    @State private var addPatientToggle = false
    @State private var deleteIndexSet: IndexSet?
    @State private var searchText = ""
    @State private var showDischargeAlert = false
    @State private var dischargableItem: LoggedInPatientDataModel = LoggedInPatientDataModel(patient: PatientDataModel(name: ""))
    
    @Query(FetchDescriptor(predicate: #Predicate <LoggedInPatientDataModel>{ $0.isPinned == false })) private var patientData: [LoggedInPatientDataModel]
    @Query(FetchDescriptor(predicate: #Predicate <LoggedInPatientDataModel>{ $0.isPinned == true })) private var pinnedPatients: [LoggedInPatientDataModel]
    @Query private var dischargedPatientData: [DischargedPatientDataModel]
    @Query private var loggedPatientData: [LoggedInPatientDataModel]
    
    var body: some View {
        
        NavigationStack {
            
            List {
                if searchText.isEmpty{
                    if !dischargedPatientData.isEmpty{
                        NavigationLink(value: dischargedPatientData) {
                            Text("Discharged Patients")
                        }
                    }
                    if !pinnedPatients.isEmpty{
                        Section{
                            ForEach(pinnedPatients, id: \.id) { item in
                                NavigationLink(value: item) {
                                    ItemRow(item: item.patient)
                                }
                                .swipeActions(allowsFullSwipe: false) {
                                    // MARK: Discharge Button
                                    Button(role: .cancel) {
//                                        dischargePatient(item: item)
                                        dischargableItem = item
                                        showDischargeAlert = true
                                    } label: {
                                        Label("Discharge", systemImage: "accessibility.badge.arrow.up.right")
                                    }.imageScale(.small)
                                        .tint(.indigo)
                                        
                                    
                                    // MARK: More Button
                                    Button {
                                        print("More")
                                        showingMoreSheet = true
                                        
                                    } label: {
                                        Label("More", systemImage: "ellipsis")
                                    }
                                }
                                .swipeActions(edge: .leading) {
                                    Button {
                                        item.isPinned = false
                                    } label: {
                                        Label("UnPin", systemImage: "pin.slash.fill")
                                    }
                                    .tint(.indigo)
                                }
                            }
                        }
                    header: {
                        Text("Pinned Patients")
                    }
                    }
                    Section{
                        ForEach(patientData, id: \.id) { item in
                            NavigationLink(value: item) {
                                ItemRow(item: item.patient)
                            }
                            .swipeActions(allowsFullSwipe: false) {
                                // MARK: Discharge Button
                                Button(role: .cancel) {
//                                    dischargePatient(item: item)
                                    dischargableItem = item
                                    showDischargeAlert = true
                                } label: {
                                    Label("Discharge", systemImage: "accessibility.badge.arrow.up.right")
                                }.imageScale(.small)
                                    .tint(.indigo)
                                
                                // MARK: More Button
                                Button {
                                    print("More")
                                    showingMoreSheet = true
                                    
                                } label: {
                                    Label("More", systemImage: "ellipsis")
                                }
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    item.isPinned = true
                                } label: {
                                    Label("Pin", systemImage: "pin.fill")
                                }
                                .tint(.indigo)
                            }
                        }
                        .onMove(perform: onMove)
                        
                        .sheet(isPresented: $showingMoreSheet) {
                            Text("More")
                                .presentationDetents([.fraction(0.50)])
                        }
                    }header: {
                        Text("Patients")
                    } footer: {
                        HStack{
                            Text("\(patientData.count + pinnedPatients.count) patients")
                            Spacer()
                            Text("Discharged: \(dischargedPatientData.count) patients")
                        }
                    }
                } else {
                    Section{
                        ForEach(searchResults, id: \.id) { item in
                            NavigationLink(value: item) {
                                ItemRow(item: item.patient)
                            }
                            .swipeActions(allowsFullSwipe: false) {
                                // MARK: Discharge Button
                                Button(role: .cancel) {
                                    dischargePatient(item: item)
                                } label: {
                                    Label("Discharge", systemImage: "accessibility.badge.arrow.up.right")
                                }.imageScale(.small)
                                    .tint(.indigo)
                                
                                // MARK: More Button
                                Button {
                                    print("More")
                                    showingMoreSheet = true
                                    
                                } label: {
                                    Label("More", systemImage: "ellipsis")
                                }
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    item.isPinned = true
                                } label: {
                                    Label("Pin", systemImage: "pin.fill")
                                }
                                .tint(.indigo)
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationDestination(for: LoggedInPatientDataModel.self) { item in
                ItemDetail(item: item.patient)
            }
            .navigationDestination(for: [DischargedPatientDataModel].self) { item in
                DischargedPatientView()
            }
            .toolbar {
                Button {
                    showingAddPatient = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddPatient) {
                AddView()
            }
            .navigationBarTitle("Resident", displayMode: .inline)
            .listStyle(.grouped)
            
            .alert("Do you want to discharge this patient?", isPresented: $showDischargeAlert) {
                Button("Yes", action: { dischargePatient(item: dischargableItem)})
                Button("Cancel", role: .cancel, action: {})
            } message: {
                Text("Their information can be accessed or they can be readmitted in the discharged patients list.")
            }
        }
        
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        var newArray = patientData
        newArray.move(fromOffsets: source, toOffset: destination)
    }
    
    private func dischargePatient(item: LoggedInPatientDataModel){
        let dischargedPatient = DischargedPatientDataModel(patient: item.patient)
        modelContext.insert(dischargedPatient)
        try? modelContext.save()
        modelContext.delete(item)
    }
    
    private func delete(_ indexSet: IndexSet) {
        for i in indexSet {
            let student = patientData[i]
            modelContext.delete(student)
        }
    }
    var searchResults: [LoggedInPatientDataModel] {
        if searchText.isEmpty {
            return []
        } else {
            return loggedPatientData.filter { $0.patient.name.contains(searchText) }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
