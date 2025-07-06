import UIKit

final class CustomTextField: UITextField {
    private let padding = UIEdgeInsets(top: 0, left: 55, bottom: 0, right: 20)

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    init(icon: UIImage?, placeholder: String) {
        super.init(frame: .zero)
        setupView(icon: icon, placeholder: placeholder)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView(icon: UIImage?, placeholder: String) {
        backgroundColor = .white
        layer.cornerRadius = 25
        layer.masksToBounds = true
        layer.borderWidth = 2
        layer.borderColor = UIColor.placeholderText.withAlphaComponent(0.1).cgColor
        textColor = UIColor.black
        font = .systemFont(ofSize: 15)
        
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.lightGray
            ]
        )
        iconImageView.image = icon?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = .systemGray2
        iconImageView.image = icon
        leftView = iconImageView
        leftViewMode = .always
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 27),
            iconImageView.heightAnchor.constraint(equalToConstant: 27)
        ])
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 50)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 15
        return rect
    }
}
