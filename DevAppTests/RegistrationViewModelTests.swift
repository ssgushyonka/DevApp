import XCTest
@testable import DevApp

final class RegistrationViewModelTests: XCTestCase {
    var viewModel: RegistrationViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = RegistrationViewModel(userdefaults: UserDefaultsManager())
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testEmptyFirstName() {
        let result = viewModel.validateRegistration(
            firstName: "",
            lastName: "Борисова",
            birthDate: "01.01.2000",
            password: "Pass123",
            confirmPassword: "Pass123"
        )
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, "Введите имя")
    }

    func testShortLastName() {
        let result = viewModel.validateRegistration(
            firstName: "Элина",
            lastName: "И",
            birthDate: "01.01.2000",
            password: "Pass123",
            confirmPassword: "Pass123"
        )
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, "Фамилия должна содержать минимум 2 символа")
    }

    func testPasswordMissingUppercase() {
        let result = viewModel.validateRegistration(
            firstName: "Элина",
            lastName: "Борисова",
            birthDate: "01.01.2000",
            password: "password1",
            confirmPassword: "password1"
        )
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, "Пароль должен содержать заглавные буквы")
    }

    func testMismatchedPasswords() {
        let result = viewModel.validateRegistration(
            firstName: "Элина",
            lastName: "Борисова",
            birthDate: "01.01.2000",
            password: "Password1",
            confirmPassword: "Password2"
        )
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.error, "Пароли не совпадают")
    }

    func testValidRegistration() {
        let result = viewModel.validateRegistration(
            firstName: "Элина",
            lastName: "Борисова",
            birthDate: "01.01.2000",
            password: "Password1",
            confirmPassword: "Password1"
        )
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.error)
    }
}
