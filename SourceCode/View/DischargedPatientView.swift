//
//  DischargedPatientView.swift
//  PatientList
//
//  Created by Sazza on 14/2/24.
//

import SwiftUI
import SwiftData

struct DischargedPatientView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var patientData: [LoggedInPatientDataModel]
    @Query private var dischargedPatientData: [DischargedPatientDataModel]
    @State private var isAuthenticating = false
    @State private var isAuthenticated = false
    @State private var authenticationFailed = false
    @State var showingAlert = false
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var selectedPatientForDelete: DischargedPatientDataModel?
    @State private var searchText = ""
    var searchResults: [DischargedPatientDataModel] {
        if searchText.isEmpty {
            return dischargedPatientData
        } else {
            return dischargedPatientData.filter { $0.patient.name.contains(searchText) }
        }
    }
    var body: some View {
        Section{
            List{
                ForEach(searchResults, id: \.id) { item in
                    NavigationLink(value: item) {
                        ItemRow(item: item.patient)
                    }
                    
                    .swipeActions(edge: .leading) {
                        Button {
                            reEntry(item)
                        } label: {
                            Label("ReEntry", systemImage: "arrowshape.turn.up.backward.2.circle")
                        }
                        .tint(.indigo)
                    }
                    
                }
                .onDelete(perform: deleteDestinations)
            }
            .listStyle(.grouped)
            
        }
        .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .automatic))
        .navigationTitle("Discharged Patients")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: DischargedPatientDataModel.self) { item in
            ItemDetail(item: item.patient)
        }
        .alert("Delete Patient", isPresented: $showingAlert, actions: {
            TextField("Username", text: $username)
            
            SecureField("Password", text: $password)
            
            Button("Delete", action: {
                isAuthenticating = true
                isAuthenticated = validateCredentials()
                if validateCredentials() == false{
                    authenticationFailed = true
                    showingAlert = false
                }
                if isAuthenticated{
                    if selectedPatientForDelete != nil {
                        modelContext.delete(selectedPatientForDelete!)
                    }
                }
                isAuthenticating = false
                
            })
            Button("Cancel", role: .cancel, action: {})
        }, message: {
            Text("Please enter your username and password.")
        })
        .alert("Error", isPresented: $authenticationFailed) {
            Button("Ok", role: .cancel, action: {})
        } message: {
            Text("User name or password doesn't match")
        }
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        showingAlert.toggle()
        for index in indexSet {
            let destination = dischargedPatientData[index]
            selectedPatientForDelete = destination
        }
    }
    func reEntry(_ patient: DischargedPatientDataModel){
        modelContext.insert(LoggedInPatientDataModel(patient: patient.patient))
        modelContext.delete(patient)
    }
    
    func validateCredentials() -> Bool {
        for credential in AppConfig.validCredentials {
                if credential.username == username && credential.password == password {
                    return true
                }
            }
            return false
        }
}

#Preview {
    DischargedPatientView()
}
