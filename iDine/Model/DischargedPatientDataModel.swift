//
//  DischargedPatientDataModel.swift
//  PatientList
//
//  Created by Sazza on 8/2/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class DischargedPatientDataModel{
    var patient: PatientDataModel
    init(patient: PatientDataModel) {
        self.patient = patient
    }
}
