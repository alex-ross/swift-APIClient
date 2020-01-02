import Foundation

public enum APIError: Error {
    case invalidURL
    case requestFailed(Error?)
    case decodingFailed
}
