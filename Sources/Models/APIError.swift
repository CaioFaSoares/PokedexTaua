import Foundation

enum APIError: Error {
    case invalidURL
    case notFound
    case decodingError(Error)
    case unknownError(Error)
}