import Foundation

public struct APIResponse<Body> {
    public let statusCode: Int
    public let body: Body
}

extension APIResponse where Body == Data? {
    public func decode<BodyType: Decodable>(to type: BodyType.Type,
                                            keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) throws -> APIResponse<BodyType> {
        guard let data = body else {
            throw APIError.decodingFailure
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        let decodedJSON = try decoder.decode(BodyType.self, from: data)
        return APIResponse<BodyType>(statusCode: self.statusCode,
                                     body: decodedJSON)
    }
}
