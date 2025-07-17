// SwiftFormValidator.swift
// Swift Package: SwiftFormValidator
// Modular, reactive form validation for SwiftUI

import SwiftUI

// MARK: - Validated TextField View

public struct ValidatedTextField: View {
    @ObservedObject var field: ValidatedField
    var title: String

    public init(_ title: String, field: ValidatedField) {
        self.title = title
        self.field = field
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField(title, text: $field.value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            if let error = field.error {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}

// MARK: - Demo Login/Signup View

#if DEBUG
struct DemoLoginForm: View {
    @StateObject private var email = ValidatedField(rules: [RequiredRule(), EmailRule()])
    @StateObject private var password = ValidatedField(rules: [RequiredRule(message: "Password cannot be empty")])

    var isFormValid: Bool {
        email.isValid && password.isValid
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Login")) {
                    ValidatedTextField("Email", field: email)
                    SecureField("Password", text: $password.value)
                        .onChange(of: password.value) { _ in password.validate() }
                    if let error = password.error {
                        Text(error).font(.caption).foregroundColor(.red)
                    }
                }
                Button("Submit") {
                    email.validate()
                    password.validate()
                }
                .disabled(!isFormValid)
            }
            .navigationTitle("Login Form")
        }
    }
}

@main
struct SwiftFormValidatorDemoApp: App {
    var body: some Scene {
        WindowGroup {
            DemoLoginForm()
        }
    }
}
#endif
