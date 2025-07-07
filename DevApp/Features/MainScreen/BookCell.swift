import UIKit

final class BookCell: UITableViewCell {
    static let reuseId = "BookCell"
    
    private lazy var bookNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray5
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.image = UIImage(systemName: "photo")
        imageView.tintColor = .placeholderText
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(bookNameLabel)
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(bookImage)
        contentView.addSubview(genreLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bookImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: BookCellLayout.booksLeading),
            bookImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            bookImage.widthAnchor.constraint(equalToConstant: BookCellLayout.bookImageWidth),
            bookImage.heightAnchor.constraint(equalToConstant: BookCellLayout.bookImageHeight),
            
            bookNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: BookCellLayout.bookNameTop),
            bookNameLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: BookCellLayout.bookNameTop),
            bookNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -BookCellLayout.booksLeading),
            
            authorNameLabel.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: BookCellLayout.labelsSpace),
            authorNameLabel.leadingAnchor.constraint(equalTo: bookNameLabel.leadingAnchor),
            authorNameLabel.trailingAnchor.constraint(equalTo: bookNameLabel.trailingAnchor),
            authorNameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -BookCellLayout.bookNameTop),
            
            genreLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: BookCellLayout.labelsSpace),
            genreLabel.leadingAnchor.constraint(equalTo: bookNameLabel.leadingAnchor),
            genreLabel.trailingAnchor.constraint(equalTo: bookNameLabel.trailingAnchor)
            
        ])
    }

    func configure(title: String, author: String, genre: String) {
        bookNameLabel.attributedText = createAttributedText(boldPart: "Название:", normalPart: title)
        authorNameLabel.attributedText = createAttributedText(boldPart: "Автор:", normalPart: author)
        genreLabel.attributedText = createAttributedText(boldPart: "Жанр:", normalPart: genre)
    }

    private func createAttributedText(boldPart: String, normalPart: String) -> NSAttributedString {
        let fullText = "\(boldPart) \(normalPart)"
        let attributedString = NSMutableAttributedString(string: fullText)
        let boldRange = (fullText as NSString).range(of: boldPart)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: boldRange)
        return attributedString
    }
}
