//
//  EditMedicationView.swift
//  PatientList
//
//  Created by Sazza on 20/2/24.
//

import SwiftUI

struct EditMedicationView: View {
    @EnvironmentObject var vm: MedicationApiViewModel
    @State private var isSearching = false
    @FocusState var isTextFieldFocused: Bool
    @Bindable var patientData:PatientDataModel
    var body: some View {
        VStack{
            SearchBar(vm: vm, isSearching: $isSearching,isTextFieldFocused: _isTextFieldFocused)
            if isSearching {
                EditSearchResultsView(vm: vm, isSearching: $isSearching, isTextFieldFocused: _isTextFieldFocused, patientData: patientData)
            }
            else {
                EditMedicationList(patientData: patientData)
            }
        }
        .navigationTitle("Search Drug")
    }
}

#Preview {
    EditMedicationView( patientData: PatientDataModel(name: ""))
}


struct EditSearchResultsView: View {
    @ObservedObject var vm: MedicationApiViewModel
    @Binding var isSearching: Bool
    @FocusState var isTextFieldFocused: Bool
    @Bindable var patientData: PatientDataModel
    var body: some View {
        VStack{
            ScrollView {
                if vm.drugs != nil {
                    if (vm.drugs!.drugGroup.conceptGroup == nil) {
                        Text("No Result Found")
                            .padding()
                    } else {
                        VStack(alignment: .leading, spacing: 10) {
                            if vm.drugs != nil && vm.drugs?.drugGroup.conceptGroup != nil {
                                ForEach (((vm.drugs?.drugGroup.conceptGroup)!), id:\.self){ item in
                                    if item.conceptProperties != nil {
                                        ForEach(item.conceptProperties!, id: \.self){ drug in
                                            VStack(alignment:.leading){
                                                Button {
                                                    if (patientData.Medications?.append(drug.name)) == nil {
                                                        patientData.Medications = [drug.name]
                                                    }
                                                    print(patientData.Medications ?? [])
                                                    isTextFieldFocused = false
                                                } label: {
                                                    HStack{
                                                        Text("Name:")
                                                        Text(drug.name)
                                                            .padding()
                                                    }
                                                }
                                            }
                                            Divider()
                                                .padding(.all,10)
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct EditMedicationList: View {
    @Bindable var patientData: PatientDataModel
    var body: some View {
        VStack{
            Text("List Of Drugs")
                .padding()
                .font(.headline)
            Divider()
            List{
                ForEach(patientData.Medications ?? [], id: \.self) { drug in
                    Text("\(drug)")
                }
                .onDelete { index in
                    deleteDrug(at: index)
                }
                
            }
            .listStyle(.plain)
            .toolbar(content: {
                EditButton()
            })
        }
    }
    
    func deleteDrug(at offsets: IndexSet) {
        patientData.Medications?.remove(atOffsets: offsets)
    }
}


