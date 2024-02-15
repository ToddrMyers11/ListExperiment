//
//  ItemDetail.swift
//
//
//

import SwiftUI

struct ItemDetail: View {
    let item: PatientDataModel

    var body: some View {
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

//                Text("Photo: \(item.photoCredit)")
//                    .padding(4)
//                    .background(Color.black)
//                    .font(.caption)
//                    .foregroundColor(.white)
//                    .offset(x: -5, y: -5)
            }

            Text(item.name)
                .padding()
            VStack(alignment: .leading){
                Text("Medication:")
                List{
                    ForEach(item.Medications ?? [], id: \.self){ medication in
                        Text(medication)
                    }
                }
            }

            Spacer()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
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
