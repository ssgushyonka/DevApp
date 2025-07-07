import Foundation

struct BooksResponce: Decodable {
    let data: [Book]
}

struct Book: Decodable {
    let title: String
    let author: String
    let genre: String
    let image: String // не использую (в данных фейк картинка), но оставила на случай, если бы картинка была реальная
}
