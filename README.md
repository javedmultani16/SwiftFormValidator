# ✅ SwiftFormValidator

**Modular, real-time form validation for SwiftUI.**  
Eliminate repetitive boilerplate and deliver a flawless user experience with reactive field validation using Combine and native SwiftUI.

---

## ✨ Why SwiftFormValidator?

Building forms is easy. Validating them? Not so much.

- ❌ Manual validation logic clutters your views
- ❌ Error messages scattered across the codebase
- ❌ No real-time feedback leads to poor UX

### ✅ Enter `SwiftFormValidator`
A clean, testable, and reusable solution to validate any form field declaratively using Combine and SwiftUI.

---

## 💡 Key Features

- 🔍 Built-in rules: `required`, `email`, `regex`, and more
- 🧪 Real-time validation via Combine publishers
- 💬 Localized & custom error support
- 🧱 Drop-in `ValidatedTextField` component
- 💡 Seamless integration with SwiftUI forms
- 🔌 Extensible with custom rules
- 📦 Zero third-party dependencies

---

## 📦 Installation

### Option 1: Swift Package Manager (Recommended)

```swift
.package(url: "https://github.com/javedmultani16/SwiftFormValidator.git", from: "1.0.0")
```

Then import it:

```swift
import SwiftFormValidator
```

### Option 2: Manual Integration

Simply drag and drop `SwiftFormValidator.swift` into your project.

---

## 🚀 Quick Start

### Step 1: Create a ValidatedField

```swift
@StateObject var email = ValidatedField(
    rules: [RequiredRule(), EmailRule()]
)
```

### Step 2: Use with `ValidatedTextField`

```swift
ValidatedTextField("Email", field: email)
```

### Step 3: Check if valid before submission

```swift
if email.isValid {
    // Proceed with login or submit
}
```

---

## 🧪 Live Demo

```swift
@StateObject private var password = ValidatedField(
    rules: [RequiredRule(message: "Password cannot be empty")]
)

Form {
    ValidatedTextField("Email", field: email)

    SecureField("Password", text: $password.value)
        .onChange(of: password.value) { _ in password.validate() }

    if let error = password.error {
        Text(error).font(.caption).foregroundColor(.red)
    }

    Button("Submit") {
        email.validate()
        password.validate()
    }
    .disabled(!email.isValid || !password.isValid)
}
```

---

## 🌟 What Makes It Stand Out?

| Feature                          | SwiftFormValidator ✅ | Manual Validation ❌ |
|----------------------------------|------------------------|----------------------|
| Combine-powered validation       | ✅                     | ❌                   |
| Reusable, testable rules         | ✅                     | ❌                   |
| Error messaging built-in         | ✅                     | ❌                   |
| SwiftUI-first integration        | ✅                     | ⚠️ workaround needed |
| Declarative, clean syntax        | ✅                     | ❌                   |

---

## 🔌 Custom Rule Example

```swift
struct MinLengthRule: ValidationRule {
    let length: Int
    let message: String

    func validate(_ value: String) -> Bool {
        value.count >= length
    }
}
```

---

## 🛡 License

MIT License — free to use in personal and commercial apps.

---

## 💬 Feedback

Found it useful? ⭐️ Star the repo, or contribute by opening an issue or PR!

---
