//
//  DOBPickerView.swift
//  RegistrationForm
//
//  Created by Sudheshna Tholikonda on 12/07/25.
//

import SwiftUI

struct DOBPickerView: View {
    // MARK: - PROPERITIES
     @Binding var dateOfBirth: Date
     @Binding var dobText: String

    // MARK: - BODY
    // ✅ Valid range: between 0 and 100 years ago
       var validDOBRange: ClosedRange<Date> {
           let calendar = Calendar.current
           let now = Date()
           let hundredYearsAgo = calendar.date(byAdding: .year, value: -100, to: now)!
           return hundredYearsAgo...now
       }

       // ✅ Format the date to dd/MM/yyyy
       func formattedDate(_ date: Date) -> String {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd/MM/yyyy"
           return formatter.string(from: date)
       }

    var body: some View {
        
     let pickerView = DatePicker("",
                 selection: $dateOfBirth,
                 in: validDOBRange,
                 displayedComponents: .date)
        pickerView.background(Color.clear)
      .datePickerStyle(.compact)
      .labelsHidden() // hides the default label
        
          
    }
}

#Preview {
    DOBPickerPreviewWrapper()
}

struct DOBPickerPreviewWrapper: View {
    @State private var dateOfBirth: Date = Date()
    @State private var dobText: String = "12/07/2015"

    var body: some View {
        DOBPickerView(dateOfBirth: $dateOfBirth, dobText: $dobText)
    }
}
