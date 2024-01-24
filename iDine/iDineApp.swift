//
//  PatientList.swift
//
//
//

import SwiftUI

@main
struct iDineApp: App {
    @StateObject var order = Order()

    var body: some Scene {
        WindowGroup {
            MainView()
            //ContentView()
                .environmentObject(order)
            //SettingView()
        }
    }
}
