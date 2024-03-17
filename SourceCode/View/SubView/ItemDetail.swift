//
//  ItemDetail.swift
//
//
//

import SwiftUI

struct ItemDetail: View {
    let item: PatientDataModel
    @State var isDischargedPatient = false
    @State private var showingAlert = false
    
    @State private var isAuthenticating = false
    @State private var isAuthenticated = false
    @State private var authenticationFailed = false
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isShowingDetailView = false
    var body: some View {
        ScrollView{
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    if let patientImage = item.patientImage, let uiImage = UIImage(data: patientImage){
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 65, height: 65, alignment: .center)
                            .scaledToFill()
                            .clipped()
                            .clipShape(Rectangle())
                            .overlay(Rectangle().stroke(Color.gray, lineWidth: 2))
                    }
                }
                
                Text(item.name)
                    .padding()
                VStack(alignment: .leading){
                    Group{
                        itemRow(name: "Location", item: item.Location ?? "")
                        itemRow(name: "Room", item: "\(item.Room ?? 0)")
                        itemRow(name: "Diagnosis1", item: item.Diagnosis1 ?? "")
                        VStack(alignment: .leading){
                            Text("Restrictions:")
                                .font(.headline)
                                .fontWeight(.bold)
                            List{
                                ForEach(item.Restrictions ?? [], id:\.self){ restriction in
                                    Text(restriction)
                                }
                            }
                            .frame(height: 150)
                            .listStyle(.plain)
                        }
                        itemRow(name: "Physician", item: item.Physician ?? "")
                        itemRow(name: "CC", item: item.CC ?? "")
                        itemRow(name: "HPI", item: item.HPI ?? "")
                    }
                    Group{
                        itemRow(name: "MedHx", item: item.MedHx ?? "")
                        itemRow(name: "SurgHx", item: item.SurgHx ?? "")
                        itemRow(name: "SocHx", item: item.SocHx ?? "")
                        itemRow(name: "FamHx", item: item.FamHx ?? "")
                        itemRow(name: "ROS", item: item.ROS ?? "")
                        itemRow(name: "Allergies", item: item.Allergies ?? "")
                        VStack(alignment: .leading){
                            Text("Medication:")
                                .font(.headline)
                                .fontWeight(.bold)
                            List{
                                ForEach(item.Medications ?? [], id: \.self){ medication in
                                    Text(medication)
                                }
                            }
                            .frame(height: 150)
                            .listStyle(.plain)
                        }
                    }
                    Group{
                        itemRow(name: "Vaccinations", item: item.Vaccinations ?? "")
                        itemRow(name: "PE", item: item.PE ?? "")
                        itemRow(name: "Assess", item: item.Assess ?? "")
                        itemRow(name: "Plan", item: item.Plan ?? "")
                    }
                }
                
                Spacer()
            }
            .padding()
            
//            NavigationLink(destination: Text("Second View"), isActive: $isShowingDetailView) { EmptyView() }
        }
        .navigationDestination(isPresented: $isShowingDetailView, destination: {
            EditPatientView(patientData: item)
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if isDischargedPatient{
                    Button {
                        showingAlert = true
                    } label: {
                        Text("Edit")
                    }
                }
                NavigationLink {
                    EditPatientView(patientData: item)
                } label: {
                    Text("Edit")
                }
            }
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Edit Patient", isPresented: $showingAlert, actions: {
            TextField("Username", text: $username)
            
            SecureField("Password", text: $password)
            
            Button("Edit", action: {
                isAuthenticating = true
                isAuthenticated = validateCredentials()
                if validateCredentials() == false{
                    authenticationFailed = true
                    showingAlert = false
                }
                if isAuthenticated{
                    isShowingDetailView = true
//                    if selectedPatientForDelete != nil {
//                        modelContext.delete(selectedPatientForDelete!)
//                    }
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
    private func itemRow(name: String, item: String) -> some View{
        HStack{
            Text("\(name):")
                .font(.headline)
                .fontWeight(.bold)
            Text(item)
        }
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

//struct ItemDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            ItemDetail(item: HPItem.example)
//                .environmentObject(Order())
//        }
//    }
//}
