import UIKit

final class MainViewController: UIViewController {
    private lazy var helloButton: UIButton = {
        let button = UIButton()
        button.setTitle(MainViewStrings.helloButtonTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.tintColor = .white
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = MainViewLayout.viewsCornerRadius
        button.addTarget(self, action: #selector(helloButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(helloButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            helloButton.heightAnchor.constraint(equalToConstant: 50),
            helloButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            helloButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            helloButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc
    private func helloButtonTapped() {
        let helloVc = HelloViewController()
        helloVc.modalPresentationStyle = .formSheet
        present(helloVc, animated: true, completion: nil)
    }
}
