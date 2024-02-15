//
//  ItemDetail.swift
//  iDine
//
//  SHows the Patient's name, detail, and photo more largely
//

import SwiftUI

struct PatientDetail: View {
    let item: Patient
    // Assuming `order` is defined elsewhere if you're using the commented-out order button

    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                // Use the currentImage computed property or equivalent
                item.currentImage
                    .resizable()
                    .scaledToFit()
            }

            Text(item.name)
                .padding()

            // If you're reintroducing the order button
            // Button("Order This") {
            //     order.add(item: item)
            // }
            // .buttonStyle(.borderedProminent)

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
