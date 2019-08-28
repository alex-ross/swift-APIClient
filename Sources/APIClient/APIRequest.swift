import Foundation

public class APIRequest {
    public let method: HTTPMethod
    public let path: String
    public var queryItems: [URLQueryItem]?
    public var headers: [HTTPHeader]?
    public var body: Data?

    public init(method: HTTPMethod, path: String) {
        self.method = method
        self.path = path
    }

    public init<Body: Encodable>(method: HTTPMethod, path: String, body: Body) throws {
        self.method = method
        self.path = path
        self.body = try JSONEncoder().encode(body)
    }

    public func useBasicAuthentication(withUsername username: String, password: String) {
        let loginString = "\(username):\(password)"
        let loginData = loginString.data(using: .utf8)!
        let base64LoginString = loginData.base64EncodedString()

        let header = HTTPHeader(field: "Authorization", value: "Basic \(base64LoginString)")

        if headers == nil {
            headers = [header]
        } else {
            headers?.append(header)
        }
    }
}
