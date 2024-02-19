//
//  ItemDetail.swift
//  iDine
//
//  SHows the Patient's name, detail, and photo more largely
//

import SwiftUI

struct PatientDetail: View {
    let patient: Patient
    
    // Photo options
    @State private var showActionSheet = false
    @State private var showImagePicker = false
    @State private var useCamera = false
    
    var body: some View {
        VStack {
                // MARK: Take Photo Options
                Button(action: {
                    // This will toggle the action sheet on tap
                    self.showActionSheet = true
                }) {
                    // MARK: - Patient Photo
                    ZStack(alignment: .bottomTrailing) {
                        patient.currentImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250, height: 250) // Set the frame size as needed
                            .clipShape(Circle()) // Clip the image to a circle
                            .overlay(
                                Circle().stroke(.black, lineWidth: 2) // Optional: Adds a white stroke to the circle
                            )
                            .foregroundColor(.black) // This ensures the symbol color is black

                        // MARK: Pencil Icon
                        // Overlay the pencil/edit icon at the bottom right corner
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 20)) // Adjust the size as needed
                            .foregroundColor(.blue) // Set the foreground color as needed
                            .background(Color.white) // Set a background to make the icon stand out
                            .clipShape(Circle()) // Clip the background to a circle
                            .offset(x: 20, y: 20) // Adjust the offset to position the icon correctly
                            .padding(10) // Add padding to ensure the icon is not touching the edges
                    }
                }
             // MARK: Actions for Photo
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text("Update Patient Photo"),
                    message: Text("Choose a photo option"),
                    buttons: [
                        .default(Text("Take Photo")) {
                            self.useCamera = true
                            self.showImagePicker = true
                        },
                        .default(Text("Choose from Library")) {
                            self.useCamera = false
                            self.showImagePicker = true
                        },
                        .cancel()
                    ]
                )
            }
            .sheet(isPresented: $showImagePicker) {
                // TODO: Implement Camera Option
                // TODO: Implement Photo Library
                // This should be your ImagePicker component that handles taking a photo or choosing from the library
                Text("Photo option")
            }
            
            // MARK: - Patient Name
            Text(patient.name)
                .padding()
            
            Spacer()
        }
        .navigationTitle(patient.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


//struct ItemDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            ItemDetail(item: HPItem.example)
//                .environmentObject(Order())
//        }
//    }
//}
