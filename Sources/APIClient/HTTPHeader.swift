public struct HTTPHeader {
    public let field: String
    public let value: String

    public init(field: String, value: String) {
        self.field = field
        self.value = value
    }
}
