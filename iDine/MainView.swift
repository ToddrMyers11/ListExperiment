//
//  MainView.swift
//  PatientList
//
//

import SwiftUI

struct MainView: View {
    
    var body: some View {

        TabView {
            ContentView()
              
                .tabItem {
                    Label("Patients", systemImage: "list.dash")
                        
                }

            OrderView()
                .tabItem {
                    Label("Notes", systemImage: "square.and.pencil")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Order())
    }
}
