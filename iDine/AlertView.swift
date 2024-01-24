//
//  AlertView.swift
//  PatientList
//
//  Created by Todd Myers on 1/3/24.
//
//import SwiftUI
//
//struct AlertView: View {
//    @State private var presentAlert = false
//    @State private var username: String = ""
//    @State private var password: String = ""
//    
//    var body: some View {
//        Button("Show Alert") {
//            presentAlert = true
//        }
//        .alert("Login", isPresented: $presentAlert, actions: {
//            TextField("Username", text: $username)
//
//            SecureField("Password", text: $password)
//
//            
//            Button("Login", action: {})
//            Button("Cancel", role: .cancel, action: {})
//        }, message: {
//            Text("Please enter your username and password.")
//        })
//    }
//}
