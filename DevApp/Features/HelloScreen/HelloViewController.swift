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

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "xmark")
        button.setImage(image, for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            helloLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: HelloScreenLayout.closeButtonSpaces),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -HelloScreenLayout.closeButtonSpaces),
            closeButton.widthAnchor.constraint(equalToConstant: HelloScreenLayout.closeButtonSize),
            closeButton.heightAnchor.constraint(equalToConstant: HelloScreenLayout.closeButtonSize)
        ])
    }
    
    private func setupUserName() {
        guard let user = userDefaults.getUser() else {
            helloLabel.text = "Привет, пользователь!"
            return
        }
        helloLabel.text = "Привет, \(user.firstName) \(user.lastName)!"
    }

    @objc private func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
}
