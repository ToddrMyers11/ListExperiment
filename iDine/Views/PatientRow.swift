//
//  ItemRow.swift

//

import SwiftUI

struct PatientRow: View {
    let colors: [String: Color] = ["D": .purple, "G": .black, "N": .red, "S": .blue, "V": .green]
    
    let patient: Patient

    var body: some View {
        VStack {
            HStack {
                // Use the computed property to obtain the appropriate image
                patient.currentImage
                    .resizable()
                    .aspectRatio(contentMode: .fit) // This will maintain the aspect ratio
                    .frame(width: 65, height: 65)
                    .clipped()
                    .clipShape(Circle()) // This will clip the image to a circle
                    .overlay(Circle()
                        .stroke(Color.gray, lineWidth: 2))
//                    .clipShape(Rectangle())
//                    .overlay(Rectangle()
//                        .stroke(Color.gray, lineWidth: 2)) // Use Circle() to match the clip shape

                
                VStack(alignment: .leading) {
                    Text(patient.name)
                        .font(.headline)
                    HStack {
                        Text(patient.Location)
                        Text("\(patient.Room)")
                    }
                    Text(patient.Diagnosis1)
                }
            }
        }
        .padding() // Add padding to ensure the content is not too cramped.
        Spacer()
        
        // Displaying restrictions if any
        ForEach(patient.Restrictions, id: \.self) { restriction in
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
