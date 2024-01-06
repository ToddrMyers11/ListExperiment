//
//  ItemRow.swift
//  iDine
//
//  Created by Paul Hudson on 08/02/2021.
//

import SwiftUI

struct ItemRow: View {
    let colors: [String: Color] = ["D": .purple, "G": .black, "N": .red, "S": .blue, "V": .green]

    let item: HPItem
    @State private var showingAlert = true
    var body: some View {
        VStack{
        HStack {
            Image(item.thumbnailImage)
                .resizable()
                .frame(width: 65, height: 65, alignment: .center)
                .scaledToFill()
                .clipShape(Rectangle())
                .overlay(Rectangle().stroke(Color.gray, lineWidth: 2))

            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                HStack{
                    Text(item.Location)
                    Text("\(item.Room)")
                }
                Text(item.Diagnosis1)
            }
            }
//        .swipeActions(allowsFullSwipe: false) {
//            Button {
//                
//                print("Muting conversation")
//            } label: {
//                Label("Archive", systemImage: "archivebox")
//            }
//            .tint(.indigo)
            
//            Button("Show Alert") {
//                showingAlert = true
//            }
//            .alert(isPresented:$showingAlert) {
//                Alert(
//                    title: Text("Are you sure you want to delete this?"),
//                    message: Text("There is no undo"),
//                    primaryButton: .destructive(Text("Delete")) {
//                        print("Deleting...")
//                    },
//                    secondaryButton: .cancel()
//                )
//            }
//        .alert(isPresented: $showingAlert) {
//            Alert(title: Text("I am the Egg Man"))}
            
        }
            Spacer()
            
            ForEach(item.Restrictions, id: \.self) { restriction in
                Text(restriction)
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(5)
                    .background(colors[restriction, default: .black])
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }
        }
    }

//struct AlertView: View {
//    // 1
//    @State private var showingAlert = false
//
//
//    var body: some View {
//        VStack {
//            // 2
//            Text(showingAlert ? "Presenting": "Dismissed")
//
//            Button("Alert") {
//                // 3
//                showingAlert = true
//
//            }
//            Spacer()
//        }
//        .padding()
//        .alert("Title", isPresented: $showingAlert, actions: {}) // 4
//
//    }
//}
//struct ItemRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemRow(item: MenuItem.example)
//    }
//}
