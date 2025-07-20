//
//  ContentView.swift
//  RegistrationForm
//
//  Created by Sudheshna Tholikonda on 11/07/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERITIES
    @State private var firstName: String = ""
    @State private var lastName: String = ""
  
    @State private var email: String = ""
    @State private var isValidEmailAddress: Bool = true

    @State private var mobileNumber: String = ""
    @State private var address: String = ""
    
    @State private var userName: String = ""
    @State private var password: String = ""
    
    @State private var agreeToTerms: Bool = false
    @State private var goToNextView = false
    
    @State private var dateOfBirth: Date = Date()
    @State private var dobText: String = ""
    @State private var showDatePicker: Bool = false
   
    @State private var showAlert = false



    // MARK: - BODY
    func formattedDate(_ date: Date) -> String {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd/MM/yyyy"
           return formatter.string(from: date)
       }
    
    //  MARK: - Email validator function
        func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
            return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
        }
    
    // MARK: - Form Validation
    var isFormValid: Bool {
        return !firstName.isEmpty &&
               !lastName.isEmpty &&
               isValidEmail(email) &&
               !email.isEmpty &&
               !mobileNumber.isEmpty &&
               mobileNumber.count == 10 &&
               CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: mobileNumber)) &&
               !address.isEmpty &&
               !userName.isEmpty &&
               password.count >= 6 &&
               agreeToTerms
    }

    
    
    var body: some View {
   
        NavigationStack {
            Form {
                Section(header: Text("Personal Information")) {
                    TextFieldWithIcon(systemName: "person.fill", placeholder: "First Name", text: $firstName)
                    TextFieldWithIcon(systemName: "person.fill", placeholder: "Last Name", text: $lastName)
                    
                    HStack {
                        Image(systemName: "mail.fill")
                            .foregroundColor(.gray)
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .onChange(of: email) { newValue in
                                isValidEmailAddress = isValidEmail(newValue)
                                           }
                        if !isValidEmailAddress && !email.isEmpty {
                                        Text("Invalid email address")
                                            .foregroundColor(.red)
                                            .font(.caption)
                        }
                    }
                    
                    HStack {
                        Image(systemName: "calendar.circle.fill")
                            .foregroundColor(.gray)
                        DOBPickerView(dateOfBirth: $dateOfBirth, dobText: $dobText)
                                   .transition(.opacity)
                    }

                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.gray)
                        TextField("Mobile Number", text: $mobileNumber)
                            .keyboardType(.numberPad)
                    }
                    
                    TextFieldWithIcon(systemName: "location.circle", placeholder: "Address", text: $address)
                }
                
                Section(header: Text("Account Details")) {
                    TextFieldWithIcon(systemName: "person.fill", placeholder: "Username", text: $userName)

                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.gray)
                        SecureField("Password", text: $password)
                                .keyboardType(.asciiCapable)
                                .textContentType(.password)
                                .autocapitalization(.none)
                                
                    }
                    if !password.isEmpty && password.count < 6 {
                                            Text("Password must be at least 6 characters")
                                                .foregroundColor(.red)
                                                .font(.caption)
                                                .padding(.leading, 30)
                    }
                    
                }
                Toggle(isOn: $agreeToTerms) {
                Label("I agree to the Terms & Conditions",
                      systemImage: agreeToTerms ? "checkmark.square" : "square")
                }
                // Footer or bottom-style button
                   Section(footer:
                       Button(action: {
                           // Do something
                       if !isFormValid {
                           goToNextView = false
                           showAlert = true
                         } else {
                             goToNextView = true
                         }
                       }) {
                           Text("Next")
                               .frame(maxWidth: .infinity)
                               .padding()
                               .background(isFormValid ? Color.blue : Color.gray)
                               .foregroundColor(.white)
                               .cornerRadius(8)
                               .font(.title3)
                       }
                    .alert("Error", isPresented: $showAlert) {
                        Button("Okay", role: .cancel) { }
                    } message: {
                        Text("Please fill the form.")
                    }
                   // .disabled(!isFormValid)
                    .buttonStyle(PlainButtonStyle()) // Removes gray tap background
                       .padding(.top)
                   ) {}
            } // FORM
            .onAppear {
                // Clear form when MainView appears again
                firstName = ""
                lastName = ""
                email = ""
                mobileNumber = ""
                address = ""
                userName = ""
                password = ""
                agreeToTerms = false
                
            }
            .navigationTitle("Registration Form")
            .navigationDestination(isPresented: $goToNextView) {
                CameraView()
            }
        } // NAVIGATION
    }
}

#Preview {
    ContentView()
}
