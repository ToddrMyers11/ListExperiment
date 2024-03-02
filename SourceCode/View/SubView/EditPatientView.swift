//
//  EditPatientView.swift
//  PatientList
//
//  Created by Sazza on 20/2/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditPatientView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @Bindable var patientData: PatientDataModel
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var isExpanded: Bool = false
    
    var body: some View {
        Form {
            VStack(alignment: .center){
                if let patientImage = patientData.patientImage, let uiImage = UIImage(data: patientImage){
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 65, height: 65, alignment: .center)
                        .scaledToFill()
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
                    EditMedicationView(patientData: patientData)
                } label: {
                    Text("Medication")
                }
                TextField("Vaccinations", text: $patientData.Vaccinations.toUnwrapped(defaultValue: ""))
                TextField("PE", text: $patientData.PE.toUnwrapped(defaultValue: ""))
                TextField("Assess", text: $patientData.Assess.toUnwrapped(defaultValue: ""))
                TextField("Plan", text: $patientData.Plan.toUnwrapped(defaultValue: ""))
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    if patientData.name != "" {
                        try? modelContext.save()
                        dismiss()
                    }
                }
            }
            
        }
        .navigationTitle("Edit patient")
        .navigationBarTitleDisplayMode(.inline)
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

#Preview {
    EditPatientView(patientData: PatientDataModel(name: ""))
}
