//
//  ItemDetail.swift
//
//
//

import SwiftUI

struct ItemDetail: View {
    let item: PatientDataModel

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
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    EditPatientView(patientData: item)
                } label: {
                    Text("Edit")
                }
            }
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    private func itemRow(name: String, item: String) -> some View{
        HStack{
            Text("\(name):")
                .font(.headline)
                .fontWeight(.bold)
            Text(item)
        }
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
