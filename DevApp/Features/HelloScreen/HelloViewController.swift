import UIKit

final class HelloViewController: UIViewController {
    private let userDefaults: UserDefaultsManagerProtocol = UserDefaultsManager()
    
    private let helloLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground
        setupViews()
        setupConstraints()
        setupUserName()
    }
    
    private func setupViews() {
        view.addSubview(helloLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            helloLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupUserName() {
        guard let user = userDefaults.getUser() else {
            helloLabel.text = "Привет, пользователь!"
            return
        }
        helloLabel.text = "Привет, \(user.firstName) \(user.lastName)!"
    }
}
