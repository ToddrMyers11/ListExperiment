//
//  Extensions.swift
//  PatientList
//
//  Created by Sazza on 7/2/24.
//

import Foundation
import SwiftUI


extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
