import UIKit

final class MainViewController: UIViewController {
    private let booksService = BooksService()
    private var books: [Book] = []

    private lazy var helloButton: UIButton = {
        let button = UIButton()
        button.setTitle(MainViewStrings.helloButtonTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.tintColor = .white
        button.backgroundColor = .systemTeal
        button.layer.cornerRadius = MainViewLayout.viewsCornerRadius
        button.addTarget(self, action: #selector(helloButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookCell.self, forCellReuseIdentifier: BookCell.reuseId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground
        setupViews()
        setupConstraints()
        fetchBooks()
    }
    
    private func setupViews() {
        view.addSubview(helloButton)
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            helloButton.heightAnchor.constraint(equalToConstant: MainViewLayout.helloButtonHeight),
            helloButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: MainViewLayout.helloButtonTopSpace),
            helloButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MainViewLayout.helloButtonPadding),
            helloButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MainViewLayout.helloButtonPadding),
            
            tableView.topAnchor.constraint(equalTo: helloButton.bottomAnchor, constant: MainViewLayout.tableViewTopSpace),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func fetchBooks() {
        loadingIndicator.startAnimating()
        booksService.fetchBooks { [weak self] result in
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                switch result {
                case .success(let books):
                    self?.books = books
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("ошибка загрузки книг:", error)
                }
            }
        }
    }
    
    @objc
    private func helloButtonTapped() {
        let helloVc = HelloViewController()
        helloVc.modalPresentationStyle = .formSheet
        present(helloVc, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.reuseId, for: indexPath) as? BookCell else {
            return UITableViewCell()
        }
        let book = books[indexPath.row]
        cell.configure(title: book.title, author: book.author, genre: book.genre, description: book.description)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let book = books[indexPath.row]

        let alert = UIAlertController(title: book.title,
                                      message: book.description,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
    }

}
