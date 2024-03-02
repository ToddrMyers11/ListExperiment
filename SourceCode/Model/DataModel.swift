//
//  DataModel.swift
//  PatientList
//
//  Created by Sazza on 8/2/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class DataModel{
    var loggedInPatientData: [LoggedInPatientDataModel]
    var dischargedPatientData: [DischargedPatientDataModel]
    init(loggedInPatientData: [LoggedInPatientDataModel], dischargedPatientData: [DischargedPatientDataModel]) {
        self.loggedInPatientData = loggedInPatientData
        self.dischargedPatientData = dischargedPatientData
    }
}
