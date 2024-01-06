//
//  AlertView.swift
//  PatientList
//
//  Created by Todd Myers on 1/3/24.
//

import SwiftUI

struct AlertView: View {
    @State var showingAlert = false
    var body: some View {
        Button("show alert") {
                    showingAlert.toggle()
                }
            .alert(isPresented:$showingAlert) {
            Alert(
                title: Text("Are you sure you want to delete this?"),
                message: Text("There is no undo"),
                primaryButton: .destructive(Text("Delete")) {
                    print("Deleting...")
                },
                secondaryButton: .cancel()
            )
        }
    }
}

#Preview {
    AlertView()
}
