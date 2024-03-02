//
//  AddMedicationView.swift
//  PatientList
//
//  Created by Sazza on 14/2/24.
//

import SwiftUI

struct AddMedicationView: View {
    @EnvironmentObject var vm: MedicationApiViewModel
    @State private var isSearching = false
    @FocusState var isTextFieldFocused: Bool
    @Binding var patientData:PatientDataModel
    var body: some View {
        VStack{
            SearchBar(vm: vm, isSearching: $isSearching,isTextFieldFocused: _isTextFieldFocused)
            if isSearching {
                SearchResultsView(vm: vm, isSearching: $isSearching, isTextFieldFocused: _isTextFieldFocused, patientData: $patientData)
            }
            else {
                MedicationList(patientData: $patientData)
            }
        }
        .navigationTitle("Search Drug")
    }
}

#Preview {
    AddMedicationView( patientData: .constant(PatientDataModel(name: "Todd")))
}


struct SearchBar: View {
    @ObservedObject var vm: MedicationApiViewModel
    @Binding var isSearching: Bool
    @State var filter: String = ""
    @FocusState var isTextFieldFocused: Bool
    var body: some View {
        HStack {
            TextField("Search Drug Here", text: $filter)
                .focused($isTextFieldFocused)
                .onChange(of: isTextFieldFocused) { isFocused in
                    if isFocused {
                        // began editing...
                        isSearching = true
                    } else {
                        // ended editing...
                        isSearching = false
                    }
                }
                .onSubmit {
                    vm.fetchData(filter: filter)
                }
                .onChange(of: filter) { newValue in
                    vm.fetchData(filter: filter)
                }
            Button(action: {
                vm.fetchData(filter: filter)
            }, label: {
                HStack {
                    Image(systemName: "magnifyingglass")
                }
            })
            if isTextFieldFocused{
                Button {
                    isTextFieldFocused = false
                } label: {
                    Image(systemName: "xmark")
                }
                
            }
        }
        .padding()
    }
}

struct SearchResultsView: View {
    @ObservedObject var vm: MedicationApiViewModel
    @Binding var isSearching: Bool
    @FocusState var isTextFieldFocused: Bool
    @Binding var patientData: PatientDataModel
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

struct MedicationList: View {
    @Binding var patientData: PatientDataModel
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


