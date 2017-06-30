import Foundation

public func parseJson<T: JValue>(s: Data) -> T {
    
}

public protocol JValue: Equatable {
    func toJsonString() -> String
}

public extension JValue {
    public func toJson(with encoding: String.Encoding = .utf8) -> Data? {
        return self.toJsonString().data(using: encoding)
    }
}

public struct JArray:
  JValue {
    var elems: [JValue]

    public func toJsonString() -> String {
        return "[" + elems.map { $0.toJsonString() }.joined(separator: ",") + "]"
    }
}

public struct JObject:
  JValue {
    var elems: [JString:JValue]

    public func toJsonString() -> String {
        return "{" + elems.map { "\($0.toJsonString()): \($1.toJsonString())" }.joined(separator: ",\n") + "}"
    }
}

public struct JString:
  JValue,
  ExpressibleByStringLiteral,
  Hashable {
    public var value: String

    public init(stringLiteral: String) {
       	value = stringLiteral
    }

    public init(extendedGraphemeClusterLiteral: String) {
        value = extendedGraphemeClusterLiteral
    }

    public init(unicodeScalarLiteral: String) {
        value = unicodeScalarLiteral
    }

    public var hashValue: Int {
        return value.hashValue
    }

    public func toJsonString() -> String {
        return "\"\(value)\""
    }
}

public struct JNumber:
  JValue,
  ExpressibleByIntegerLiteral,
  ExpressibleByFloatLiteral,
  Hashable,
  Comparable {
    public var value: Double

    public init(integerLiteral: Int) {
       	value = Double(integerLiteral)
    }

    public init(floatLiteral: Float) {
	value = Double(floatLiteral)
    }

    public var hashValue: Int {
        return value.hashValue
    }

    public func toJsonString() -> String {
        return "\(value)"
    }
}

public struct JBool:
  JValue,
  ExpressibleByBooleanLiteral,
  Hashable {
    public var value: Bool

    public init(booleanLiteral: Bool) {
       	value = booleanLiteral
    }

    public var hashValue: Int {
        return value.hashValue
    }

    public func toJsonString() -> String {
        return "\(value)"
    }
}

public struct JNull:
  JValue,
  ExpressibleByNilLiteral,
  Hashable {
    public init(nilLiteral: ()) {}

    public var hashValue: Int {
        return 0
    }

    public func toJsonString() -> String {
        return "null"
    }
}
