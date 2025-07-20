//
//  TextFieldWithIcon.swift
//  RegistrationForm
//
//  Created by Sudheshna Tholikonda on 18/07/25.
//

import SwiftUI

struct TextFieldWithIcon: View {
    
    // MARK: - PROPERITIES
    var systemName: String
    var placeholder: String
    
    @Binding var text: String
    
    // MARK: - BODY
       var body: some View {
           HStack {
               Image(systemName: systemName)
                   .foregroundColor(.gray)
               TextField(placeholder, text: $text)
           }
       }
}

#Preview {
    TextFieldWithIconPreviewWrapper()
}
struct TextFieldWithIconPreviewWrapper: View {
    @State private var textEdit = "First Name"

    var body: some View {
        TextFieldWithIcon(systemName: "person.fill", placeholder: "First Name", text: $textEdit)
    }
}
