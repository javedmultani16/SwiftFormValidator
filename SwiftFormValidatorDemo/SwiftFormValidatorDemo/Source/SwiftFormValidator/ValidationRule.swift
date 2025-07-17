
import SwiftUI
import Combine

// MARK: - Validation Rule

public protocol ValidationRule {
    var message: String { get }
    func validate(_ value: String) -> Bool
}

public struct RequiredRule: ValidationRule {
    public let message: String
    public init(message: String = "This field is required") {
        self.message = message
    }
    public func validate(_ value: String) -> Bool {
        !value.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

public struct EmailRule: ValidationRule {
    public let message: String
    public init(message: String = "Invalid email address") {
        self.message = message
    }
    public func validate(_ value: String) -> Bool {
        let regex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        return NSPredicate(format: "SELF MATCHES[c] %@", regex).evaluate(with: value)
    }
}

public struct RegexRule: ValidationRule {
    public let pattern: String
    public let message: String
    public init(pattern: String, message: String) {
        self.pattern = pattern
        self.message = message
    }
    public func validate(_ value: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: value)
    }
}

// MARK: - Form Field

public class ValidatedField: ObservableObject {
    @Published public var value: String = ""
    @Published public private(set) var error: String? = nil

    private var cancellables = Set<AnyCancellable>()
    private let rules: [ValidationRule]

    public init(initial: String = "", rules: [ValidationRule]) {
        self.value = initial
        self.rules = rules

        $value
            .sink { [weak self] newValue in
                self?.validate()
            }
            .store(in: &cancellables)
    }

    public func validate() {
        for rule in rules {
            if !rule.validate(value) {
                error = rule.message
                return
            }
        }
        error = nil
    }

    public var isValid: Bool {
        error == nil
    }
}
