import Foundation

protocol BooksServiceProtocol {
    func fetchBooks(completion: @escaping (Result<[Book], Error>) -> Void)
}

final class BooksService: BooksServiceProtocol {
    func fetchBooks(completion: @escaping (Result<[Book], any Error>) -> Void) {
        guard let url = URL(string: "https://fakerapi.it/api/v1/books") else {
            completion(.failure(NSError(domain: "wrong url", code: -1)))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "no data", code: -2)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(BooksResponce.self, from: data)
                completion(.success(decoded.data))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
