//
//  ItemRow.swift

//

import SwiftUI

struct ItemRow: View {
    let colors: [String: Color] = ["D": .purple, "G": .black, "N": .red, "S": .blue, "V": .green]

    let item: PatientDataModel
    @State private var showingAlert = true
    var body: some View {
        VStack{
        HStack {
            if let patientImage = item.patientImage, let uiImage = UIImage(data: patientImage){
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 65, height: 65, alignment: .center)
                    .scaledToFill()
                    .clipped()
                    .clipShape(Rectangle())
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 2))
            }
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                HStack{
                    Text(item.Location ?? "")
                    Text("\(item.Room ?? 0)")
                }
                Text(item.Diagnosis1 ?? "")
            }
            }

            
        }
            Spacer()
            
        ForEach(item.Restrictions ?? [], id: \.self) { restriction in
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

