//

//
//  Created by Todd Myers on 12/28/23.
//


import SwiftUI
import PhotosUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var name = ""
    @State private var location = ""
    @State private var room = 0
    @State private var diagnosis1 = ""
    @State private var restrictions = []
    @State private var avatarItem: PhotosPickerItem?
    @State private var patientData: PatientDataModel = PatientDataModel(name: "")
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var isExpanded: Bool = false
    
    @State private var selectedTypes: Set<RestrictionTypes> = []
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .center){
                    if let selectedImageData,
                               let uiImage = UIImage(data: selectedImageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: 120, height: 120)
                                    
                            }
                        
                    PhotosPicker(
                               selection: $selectedItem,
                               matching: .images,
                               photoLibrary: .shared()) {
                                   Text("Select a photo")
                               }
                               .onChange(of: selectedItem, { oldValue, newValue in
                                   Task {
                                       // Retrieve selected asset in the form of Data
                                       if let data = try? await newValue?.loadTransferable(type: Data.self) {
                                           selectedImageData = data
                                           patientData.patientImage = data
                                       }
                                   }
                               })
                }
                Group{
                    TextField("Name", text: $patientData.name)
                    
                    Picker("Location", selection: $patientData.Location){
                        Text("No Option").tag(Optional<String>(nil))
                        ForEach(LocationTypes.allCases, id: \.self) {
                            Text($0.rawValue).tag(Optional($0.rawValue))
                        }
                    }
//                    Picker("Location", selection: $patientData.Location.toUnwrapped(defaultValue: LocationTypes.rrc.rawValue.uppercased())) {
//                        ForEach(LocationTypes.allCases, id: \.self) {
//                            Text($0.rawValue.uppercased())
//                        }
//                    }
                    TextField("Room", value: $patientData.Room, format: .number)
                        .keyboardType(.decimalPad)
                    
                    TextField("Diagnoses", text: $patientData.Diagnosis1.toUnwrapped(defaultValue: ""))
                    
                    DisclosureGroup("Select Restrictions", isExpanded: $isExpanded) {
                        VStack(alignment: .leading) {
                            ForEach(RestrictionTypes.allCases, id: \.id) { type in
                                    buttonForRestriction(type: type)
                            }
                        }
                    }
                    TextField("Physician", text: $patientData.Physician.toUnwrapped(defaultValue: ""))
                    
                }
                Group{
                    TextField("CC", text: $patientData.CC.toUnwrapped(defaultValue: ""))
                    TextField("HPI", text: $patientData.HPI.toUnwrapped(defaultValue: ""))
                    TextField("MedHx", text: $patientData.MedHx.toUnwrapped(defaultValue: ""))
                    TextField("SurgHx", text: $patientData.SurgHx.toUnwrapped(defaultValue: ""))
                    TextField("SocHx", text: $patientData.SocHx.toUnwrapped(defaultValue: ""))
                    TextField("FamHx", text: $patientData.FamHx.toUnwrapped(defaultValue: ""))
                    TextField("ROS", text: $patientData.ROS.toUnwrapped(defaultValue: ""))
                }
                Group{
                    TextField("Allergies", text: $patientData.Allergies.toUnwrapped(defaultValue: ""))
                    NavigationLink {
                        AddMedicationView(patientData: $patientData)
                    } label: {
                        Text("Medication")
                    }
                    TextField("Vaccinations", text: $patientData.Vaccinations.toUnwrapped(defaultValue: ""))
                    TextField("PE", text: $patientData.PE.toUnwrapped(defaultValue: ""))
                    TextField("Assess", text: $patientData.Assess.toUnwrapped(defaultValue: ""))
                    TextField("Plan", text: $patientData.Plan.toUnwrapped(defaultValue: ""))

                }
            }
            .navigationTitle("Add new patient")
            .toolbar {
                Button("Save") {
                    if patientData.name != "" {
                        modelContext.insert(LoggedInPatientDataModel(patient: patientData))
                        try? modelContext.save()
                        //                    let item = HPItem(id: UUID(), name: name, Location: location, Room: Int(room), Diagnosis1: diagnosis1, Restrictions: [], Physician: "", CC: "testCC", HPI: "", MedHx: "", SurgHx: "", SocHx: "", FamHx: "", ROS: "", Allergies: "", Medications: "", Vaccinations: "", PE: "", Assess: "", Plan: "")
                        //                    expenses.items.append(item)
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func toggleRestrictions(_ type: RestrictionTypes) {
        if var restrictions = patientData.Restrictions {
            if let index = restrictions.firstIndex(of: type.rawValue) {
                restrictions.remove(at: index)
            } else {
                restrictions.append(type.rawValue)
            }
            patientData.Restrictions = restrictions
        } else {
            patientData.Restrictions = [type.rawValue]
        }
    }
    
    private func buttonForRestriction(type: RestrictionTypes) -> some View{
        Button(action: {
            print("Button Pressed for \(type.rawValue)")
            toggleRestrictions(type)
            print("\(patientData.Restrictions)")
        }) {
            Text(type.rawValue)
                .foregroundColor((patientData.Restrictions?.contains(type.rawValue) == true) ? .blue : .black)
        }
        .padding(.vertical, 5)
        .buttonStyle(PlainButtonStyle())
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
