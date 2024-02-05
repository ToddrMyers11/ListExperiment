//
//  MoreView.swift
//  PatientList
//
//  Created by Todd Myers on 1/23/24.
//

import SwiftUI

struct MoreView: View {
   // @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    let info: HPItem
    @State private var location = ""
    @State private var room = 0
    @State private var diagnosis1 = ""
    @State private var restrictions = []
    
    
    let types = ["RRC", "VM"]
    
    var body: some View {
        //        NavigationView {
        //            Form {
        //                TextField("Name", text: $name)
        //
        //                Picker("Location", selection: $location) {
        //                    ForEach(types, id: \.self) {
        //                        Text($0)
        //                    }
        //                }
        //                TextField("Room", value: $room, format: .number)
        //                                  .keyboardType(.decimalPad)
        //                TextField("Diagnoses", text: $diagnosis1)
        //            }
        //            .navigationTitle("More")
        //            .font(.footnote)
        //            .toolbar {
        //                Button {
        //                    dismiss()
        //                } label: {
        //                    Label("", systemImage: "x.circle")
        //                }
        //            }
        //        }
        //    }
        //}
        Text(info.name)
        NavigationView {
            List {
                NavigationLink {
                    Text("one")
                    //AboutView()
                } label: {
                    Text("one")
                }
                
                NavigationLink {
                    Text("two")
                    //GettingStartedView()
                } label: {
                    Text("two")
                }
                
                NavigationLink {
                    Text("three")
                    //FaqView()
                } label: {
                    Text("three")
                }
            }
            .listStyle(.grouped)
            .navigationTitle(info.name)
            .navigationBarTitleDisplayMode(.inline)
            .font(.custom("Helvitica", size: 19))
        }
    }
}



//struct MoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddView(expenses: Expenses())
//    }
//}

