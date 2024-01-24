//
//  ItemDetail.swift
//
//
//

import SwiftUI

struct ItemDetail: View {
    @EnvironmentObject var order: Order
    let item: HPItem

    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()

//                Text("Photo: \(item.photoCredit)")
//                    .padding(4)
//                    .background(Color.black)
//                    .font(.caption)
//                    .foregroundColor(.white)
//                    .offset(x: -5, y: -5)
            }

            Text(item.name)
                .padding()


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
