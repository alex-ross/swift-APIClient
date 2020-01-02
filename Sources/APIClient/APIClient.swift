import Foundation

public typealias APIResult<Body> = Result<APIResponse<Body>, APIError>

public struct APIClient {
    public typealias APIClientCompletion = (APIResult<Data?>) -> Void

    private let session: URLSession
    private let baseURL: URL

    public init(baseUrl url: URL, session: URLSession = .shared) {
        baseURL = url
        self.session = session
    }

    /// Execute the api request
    /// - Parameters:
    ///   - request: The request to execute.
    ///   - encodePlusSignInUrlQuery: Set to true if you would like to encode plus sign in url.
    ///     Otherwise it will not be encoded and it will then be decoded as a space in the server
    ///   - completion: Completion block that will be executed when the URL did finish.
    public func perform(_ request: APIRequest, encodePlusSignInUrlQuery: Bool = false, _ completion: @escaping APIClientCompletion) {
        var urlComponents = URLComponents()
        urlComponents.scheme = baseURL.scheme
        urlComponents.host = baseURL.host
        urlComponents.path = baseURL.path
        urlComponents.port = baseURL.port
        urlComponents.queryItems = request.queryItems

        if encodePlusSignInUrlQuery {
            urlComponents.percentEncodedQuery = urlComponents
                .percentEncodedQuery?
                .replacingOccurrences(of: "+", with: "%2B")
        }

        guard let url = urlComponents.url?.appendingPathComponent(request.path) else {
            completion(.failure(.invalidURL)); return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body

        request.headers?.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.field) }

        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(error)))
                return
            }
            completion(.success(APIResponse<Data?>(statusCode: httpResponse.statusCode, body: data)))
        }
        task.resume()
    }
}
