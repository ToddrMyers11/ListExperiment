//
//  ItemDetail.swift
//  iDine
//
//  SHows the Patient's name, detail, and photo more largely
//

import SwiftUI
import PhotosUI

struct PatientDetail: View {
    let patient: Patient
    
    // Photo options
    @State private var showActionSheet = false
    @State private var showImagePicker = false
    @State private var useCamera = false
    
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    @State private var selectedPhotosPickerItem: PhotosPickerItem? = nil
    @State private var pickedImageData: Data? = nil
    @State private var pickedUIImage: UIImage? = nil  // Store the picked UIImage here
    // Computed property to determine the current image
        var currentImage: Image {
            if let uiImage = pickedUIImage {
                return Image(uiImage: uiImage)
            } else {
                // If the image does not exist, return a default system image
                return Image(systemName: "person.fill")
            }
        }
    
    var body: some View {
        VStack {
            // MARK: Take Photo Options
            Button(action: {
                // This will toggle the action sheet on tap
                self.showActionSheet = true
            }) {
                // MARK: - Patient Photo
                ZStack(alignment: .bottomTrailing) {
                    currentImage
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
            
            // MARK: - Patient Name
            Text(patient.name)
                .padding()
            
            Spacer()
        }
        .navigationTitle(patient.name)
        .navigationBarTitleDisplayMode(.inline)
        // Present the photo library picker
        PhotosPicker(
            selection: $selectedPhotosPickerItem,
            matching: .images,
            photoLibrary: .shared()
        ) {
            // Present the picker UI
            Text("Select Photo")
        }
        .onChange(of: selectedPhotosPickerItem) { newItem in
            // Handle the selected photo
            Task {
                // Retrieve selected photo in the form of Data
                guard let newItem = newItem else { return }
                if let data = try? await newItem.loadTransferable(type: Data.self), let uiImage = UIImage(data: data) {
                    pickedUIImage = uiImage  // Update the pickedUIImage
                }
            }
        }
        
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
