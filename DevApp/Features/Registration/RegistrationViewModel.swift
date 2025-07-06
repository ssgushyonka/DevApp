import Foundation

protocol RegistrationViewModelProtocol {
    func validateRegistration(firstName: String?,
                            lastName: String?,
                            birthDate: String?,
                            password: String?,
                            confirmPassword: String?) -> (isValid: Bool, error: String?)
    func registerUser(data: User)
}

final class RegistrationViewModel: RegistrationViewModelProtocol {
    private let userdefaults = UserDefaults.standard
    private let minPasswordLength = 6
    private let minNameLength = 2

    func validateRegistration(firstName: String?,
                              lastName: String?,
                              birthDate: String?,
                              password: String?,
                              confirmPassword: String?) -> (isValid: Bool, error: String?) {
        guard let firstName = firstName, !firstName.isEmpty else {
            return (false, "Введите имя")
        }
        
        guard firstName.count >= minNameLength else {
            return (false, "Имя должно содержать минимум \(minNameLength) символа")
        }
        
        guard let lastName = lastName, !lastName.isEmpty else {
            return (false, "Введите фамилию")
        }
        
        guard lastName.count >= minNameLength else {
            return (false, "Фамилия должна содержать минимум \(minNameLength) символа")
        }
        
        guard let birthDate = birthDate, !birthDate.isEmpty else {
            return (false, "Выберите дату рождения")
        }
        
        guard let password = password, !password.isEmpty else {
            return (false, "Введите пароль")
        }
        
        guard password.count >= minPasswordLength else {
            return (false, "Пароль должен содержать минимум \(minPasswordLength) символов")
        }
        
        guard password.rangeOfCharacter(from: .decimalDigits) != nil else {
            return (false, "Пароль должен содержать цифры")
        }
        
        guard password.rangeOfCharacter(from: .uppercaseLetters) != nil else {
            return (false, "Пароль должен содержать заглавные буквы")
        }
        
        guard let confirmPassword = confirmPassword, !confirmPassword.isEmpty else {
            return (false, "Подтвердите пароль")
        }
        
        guard password == confirmPassword else {
            return (false, "Пароли не совпадают")
        }
        
        return (true, nil)
    }
    
    func registerUser(data: User) {
        userdefaults.set(data.firstName, forKey: "firstName")
        userdefaults.set(data.lastName, forKey: "lastName")
        userdefaults.set(data.birthDate, forKey: "birthDate")
    }
}
