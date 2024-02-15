//
//  ItemRow.swift

//

import SwiftUI

struct ItemRow: View {
    let colors: [String: Color] = ["D": .purple, "G": .black, "N": .red, "S": .blue, "V": .green]
    
    let item: HPItem

    var body: some View {
        VStack {
            HStack {
                // Use the computed property to obtain the appropriate image
                item.currentImage
                    .resizable()
                    .frame(width: 65, height: 65)
                    .scaledToFill()
                    .clipped()
                    .clipShape(Rectangle())
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: 2))
                
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    HStack {
                        Text(item.Location)
                        Text("\(item.Room)")
                    }
                    Text(item.Diagnosis1)
                }
            }
        }
        .padding() // Add padding to ensure the content is not too cramped.
        Spacer()
        
        // Displaying restrictions if any
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
