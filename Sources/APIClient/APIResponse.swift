import Foundation

public struct APIResponse<Body> {
    public let statusCode: Int
    public let body: Body
}

extension APIResponse where Body == Data? {
    public func decode<BodyType: Decodable>(to _: BodyType.Type,
                                            keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) throws -> APIResponse<BodyType> {
        guard let data = body else {
            throw APIError.decodingFailed
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        let decodedJSON = try decoder.decode(BodyType.self, from: data)
        return APIResponse<BodyType>(statusCode: statusCode,
                                     body: decodedJSON)
    }
}
