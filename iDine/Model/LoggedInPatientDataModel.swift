//
//  LoggedInPatientDataModel.swift
//  PatientList
//
//  Created by Sazza on 11/2/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class LoggedInPatientDataModel{
    var patient: PatientDataModel
    var isPinned: Bool
    init(patient: PatientDataModel, isPinned: Bool = false) {
        self.patient = patient
        self.isPinned = isPinned
    }
}
