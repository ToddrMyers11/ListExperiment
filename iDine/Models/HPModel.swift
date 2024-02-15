//
//  HPModel.swift
//  iDine
//
//  Created by Todd Myers on 12/21/23.
//

import SwiftUI
struct Patient: Codable, Hashable, Identifiable {
    var id: UUID
    var name: String
    var Location: String
    var Room: Int
    var Diagnosis1: String
    var Restrictions: [String]
    var Physician: String
    var CC: String
    var HPI: String
    var MedHx: String
    var SurgHx: String
    var SocHx: String
    var FamHx: String
    var ROS: String
    var Allergies: String
    var Medications: String
    var Vaccinations: String
    var PE: String
    var Assess: String
    var Plan: String
    
    // Image handling
    var mainImageName: String? // Name of the image in the bundle/assets
    var userSelectedImage: UIImage? // Dynamically selected or stored image
    
    enum CodingKeys: String, CodingKey {
        case id, name, Location, Room, Diagnosis1, Restrictions, Physician, CC, HPI, MedHx, SurgHx, SocHx, FamHx, ROS, Allergies, Medications, Vaccinations, PE, Assess, Plan
        // Add other property keys but omit `userSelectedImage` as UIImage is not directly Codable
        case mainImageName
    }
    
    // Provide a computed property to determine the current image source
    var currentImage: Image {
        if let userImage = userSelectedImage {
            return Image(uiImage: userImage)
        } else if let imageName = mainImageName, UIImage(named: imageName) != nil {
            // Check if the image exists in the assets and return it if so
            return Image(imageName)
        } else {
            // The old logic to generate image names can still be used here as a secondary fallback
            let generatedImageName = name.replacingOccurrences(of: " ", with: "-").lowercased() + "-thumb"
            // Check if the generated image exists in the assets
            if UIImage(named: generatedImageName) != nil {
                return Image(generatedImageName)
            } else {
                // If the image does not exist in the assets, default to a system image
                return Image(systemName: "person.fill") // Example system image
            }
        }
    }

    
}

