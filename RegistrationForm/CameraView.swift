//
//  CameraView.swift
//  RegistrationForm
//
//  Created by Sudheshna Tholikonda on 11/07/25.
//

import SwiftUI
import UIKit

struct CameraView: View {
     @State private var showImagePicker = false
     @State private var uploadingimage: UIImage? = nil
     @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    @State private var showAlert = false
    
    @State private var isFormValid = true
    @State private var alertMessage = "Please take a picture to register"
    @Environment(\.dismiss) private var dismiss


    
    var body: some View {
        VStack {
            if let selectedImage = uploadingimage {
               Image(uiImage: selectedImage)
                   .resizable()
                   .scaledToFit()
                   .frame(width: 300, height: 350)
                   .clipShape(RoundedRectangle(cornerRadius: 15))
            } else {
                Image(systemName: "person.circle.fill")
                   .resizable()
                   .frame(width: 300, height: 350)
                   .clipShape(Circle())
                   .foregroundColor(.gray)
                   .background(
                       Circle()
                           .fill(Color.gray)
                           .frame(width: 330, height: 330, alignment: .center)
                           .opacity(0.5)
                   )
                   .background(
                       Circle()
                           .fill(Color.gray)
                           .frame(width: 350, height: 350, alignment: .center)
                           .opacity(0.3)
                   )
                }
            
            VStack {
                // OPEN CAMERA
               Button("Open Camera") {
                   isFormValid = true
                   sourceType = .camera
                   showImagePicker = true
               }
               .padding()
                
                
                // OPEN GALLERY
               Button("Choose from Photos Gallery") {
                   isFormValid = true
                   sourceType = .photoLibrary
                   showImagePicker = true
               }
                
                
                // SUBMIT BUTTON
                Button(action: {
                    // Do something
                    guard uploadingimage != nil else {
                        isFormValid = false
                        return
                    }
                    isFormValid = true
                    showAlert = true
                    alertMessage = "Registration Successful!!!"
                }) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isFormValid ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .font(.title3)
                }
                .alert("Registration", isPresented: $showAlert) {
                    Button("Okay", role: .cancel) {
                        // You can perform an action here, e.g., dismiss or navigate
                        dismiss()
                    }
                } message: {
                    Text("✅ \(alertMessage)")
                }
             .buttonStyle(PlainButtonStyle()) // Removes gray tap background
                .padding(.top)
                // Inline error if no image
                      if !isFormValid {
                          Text("Please upload a picture")
                              .foregroundColor(.red)
                              .font(.caption)
                              .transition(.opacity)
                      }
            }
            .padding()
            
           
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: sourceType, selectedImage: $uploadingimage)
        }
        
    }
}

#Preview {
    CameraView()
}
