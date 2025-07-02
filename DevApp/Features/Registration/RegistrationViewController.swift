import UIKit

final class RegistrationViewController: UIViewController {

    private lazy var firstNameTextField: CustomTextField = {
        let textField = CustomTextField(icon: UIImage(systemName: "person") ,placeholder: "Имя")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var lastNameTextField: CustomTextField = {
        let textField = CustomTextField(icon: UIImage(systemName: "person.fill"), placeholder: "Фамилия")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(icon: UIImage(systemName: "key.horizontal.fill"), placeholder: "Пароль")
        textField.textContentType = .newPassword
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var confirmPasswordTextField: CustomTextField = {
        let textField = CustomTextField(icon: UIImage(systemName: "key.horizontal"), placeholder: "Подтвердите пароль")
        textField.textContentType = .newPassword
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            firstNameTextField,
            lastNameTextField,
            passwordTextField,
            confirmPasswordTextField
        ])
        stack.axis = .vertical
        stack.spacing = 20
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
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
