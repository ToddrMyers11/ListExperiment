//
//  Enums.swift
//  PatientList
//
//  Created by Sazza on 12/2/24.
//

import Foundation
import SwiftUI

// Begin by declaring the data as enums
enum LocationTypes: String, CaseIterable, Identifiable {
    case RRC, VM
    var id: Self { self }
}

enum RestrictionTypes: String, CaseIterable, Identifiable {
    case D, G, N, S, V
    var id: Self { self }
}

