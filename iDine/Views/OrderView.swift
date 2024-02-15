//
//  OrderView.swift
//  iDine
//
//  Created by Paul Hudson on 08/02/2021.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order: Order

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(order.patients) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            //Text("$\(item.price)")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }

                Section {
                    NavigationLink("Place Order") {
                       // CheckoutView()
                    }
                }
                .disabled(order.patients.isEmpty)
            }
            .navigationTitle("Order")
            .listStyle(.insetGrouped)
            .toolbar {
                EditButton()
            }
        }
    }

    func deleteItems(at offsets: IndexSet) {
        order.patients.remove(atOffsets: offsets)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(Order())
    }
}
