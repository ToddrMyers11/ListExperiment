//
//  PatientDataModel.swift
//  PatientList
//
//  Created by Sazza on 7/2/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class PatientDataModel {
    @Attribute(.unique)
    var id: String
    var name: String
    var Location: String?
    var Room: Int?
    var Diagnosis1: String?
    var Restrictions: [String]?
    var Physician: String?
    var CC: String?
    var HPI: String?
    var MedHx: String?
    var SurgHx: String?
    var SocHx: String?
    var FamHx: String?
    var ROS: String?
    var Allergies: String?
    var Medications: [String]?
    var Vaccinations: String?
    var PE: String?
    var Assess: String?
    var Plan: String?
    
    /// When working with larger or many images, it might be a good idea to separate them from the model storage and store them in an external file. For that, SwiftData provides the .externalStorage attribute:
    /// Source: https://tanaschita.com/20231127-swift-data-images/
    @Attribute(.externalStorage)
    var patientImage: Data?
    
    
    init(name: String, Location: String? = nil, Room: Int? = nil, Diagnosis1: String? = nil, Restrictions: [String]? = nil, Physician: String? = nil, CC: String? = nil, HPI: String? = nil, MedHx: String? = nil, SurgHx: String? = nil, SocHx: String? = nil, FamHx: String? = nil, ROS: String? = nil, Allergies: String? = nil, Medications: [String]? = nil, Vaccinations: String? = nil, PE: String? = nil, Assess: String? = nil, Plan: String? = nil, patientImage: Data? = nil) {
        self.id = UUID().uuidString
        self.name = name
        self.Location = Location
        self.Room = Room
        self.Diagnosis1 = Diagnosis1
        self.Restrictions = Restrictions
        self.Physician = Physician
        self.CC = CC
        self.HPI = HPI
        self.MedHx = MedHx
        self.SurgHx = SurgHx
        self.SocHx = SocHx
        self.FamHx = FamHx
        self.ROS = ROS
        self.Allergies = Allergies
        self.Medications = Medications
        self.Vaccinations = Vaccinations
        self.PE = PE
        self.Assess = Assess
        self.Plan = Plan
        self.patientImage = patientImage
    }
}
