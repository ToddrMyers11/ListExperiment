//
//  ItemDetail.swift
//  iDine
//
//  SHows the Patient's name, detail, and photo more largely
//

import SwiftUI

struct ItemDetail: View {
    let item: HPItem
    // Assuming `order` is defined elsewhere if you're using the commented-out order button

    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                // Use the currentImage computed property or equivalent
                item.currentImage
                    .resizable()
                    .scaledToFit()

                // If you're including photo credits or similar, adjust accordingly
                // Text("Photo: \(item.photoCredit)")
                //     .padding(4)
                //     .background(Color.black)
                //     .font(.caption)
                //     .foregroundColor(.white)
                //     .offset(x: -5, y: -5)
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
