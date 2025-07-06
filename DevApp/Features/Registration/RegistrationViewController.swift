import UIKit

final class RegistrationViewController: UIViewController {

    private lazy var firstNameTextField: CustomTextField = {
        let textField = CustomTextField(icon: UIImage(systemName: "person"), placeholder: RegistrationStrings.firstNamePlaceholder)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var lastNameTextField: CustomTextField = {
        let textField = CustomTextField(icon: UIImage(systemName: "person.fill"), placeholder: RegistrationStrings.lastNamePlaceholder)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var birthDateTextField: CustomTextField = {
        let textField = CustomTextField(icon: UIImage(systemName: "calendar"), placeholder: RegistrationStrings.datePlaceholder)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        textField.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDatePicker))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        
        return textField
    }()

    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(icon: UIImage(systemName: "key.horizontal.fill"), placeholder: RegistrationStrings.passwordPlaceholder)
        textField.textContentType = .newPassword
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var confirmPasswordTextField: CustomTextField = {
        let textField = CustomTextField(icon: UIImage(systemName: "key.horizontal"), placeholder: RegistrationStrings.confirmPasswordPlaceholder)
        textField.textContentType = .newPassword
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            firstNameTextField,
            lastNameTextField,
            birthDateTextField,
            passwordTextField,
            confirmPasswordTextField
        ])
        stack.axis = .vertical
        stack.spacing = RegistrationLayout.stackSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        view.addSubview(stackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: RegistrationLayout.stackLeading),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -RegistrationLayout.stackLeading),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RU")
        birthDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc private func dismissDatePicker() {
        view.endEditing(true)
    }
}
