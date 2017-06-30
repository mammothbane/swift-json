import Foundation

//public func parseJson<T: JValue>(s: Data) -> T {
//    return nil
//}

public class JValue:
  Equatable {
    fileprivate init() {}
    public func toJsonString() -> String {return ""}

    public func toJson(with encoding: String.Encoding = .utf8) -> Data? {
        return self.toJsonString().data(using: encoding)
    }
}

public class JArray:
  JValue {
    var elems: [JValue]
    
    public override func toJsonString() -> String {
        return "[" + elems.map { $0.toJsonString() }.joined(separator: ",") + "]"
    }

    public override init() {
        elems = []
        super.init()
    }
    
    public init(elems: JValue...) {
        self.elems = elems
        super.init()
    }
}

public class JObject:
  JValue {
    var elems: [JString:JValue]

    public override func toJsonString() -> String {
        return "{" + elems.map { "\($0.toJsonString()): \($1.toJsonString())" }.joined(separator: ",\n") + "}"
    }

    public override init() { 
       elems = [:]
       super.init()
    }

    public init(elems: [JString:JValue]) {
        self.elems = elems
        super.init()
    }
}

public class JString:
  JValue,
  ExpressibleByStringLiteral,
  Hashable {
    public var value: String

    required public init(stringLiteral: String) {
       	value = stringLiteral
    }
    
    required public init(extendedGraphemeClusterLiteral: String) {
        value = extendedGraphemeClusterLiteral
    }

    required public init(unicodeScalarLiteral: String) {
        value = unicodeScalarLiteral
    }

    public var hashValue: Int {
        return value.hashValue
    }

    public override func toJsonString() -> String {
        return "\"\(value)\""
    }
}

public class JNumber:
  JValue,
  ExpressibleByIntegerLiteral,
  ExpressibleByFloatLiteral,
  Hashable,
  Comparable {
    public var value: Double

    required public init(integerLiteral: Int) {
       	value = Double(integerLiteral)
    }

    required public init(floatLiteral: Float) {
	value = Double(floatLiteral)
    }

    public var hashValue: Int {
        return value.hashValue
    }

    public override func toJsonString() -> String {
        return "\(value)"
    }
}

public class JBool:
  JValue,
  ExpressibleByBooleanLiteral,
  Hashable {
    public var value: Bool

    required public init(booleanLiteral: Bool) {
       	value = booleanLiteral
    }

    public var hashValue: Int {
        return value.hashValue
    }

    public override func toJsonString() -> String {
        return "\(value)"
    }
}

public class JNull:
  JValue,
  ExpressibleByNilLiteral,
  Hashable {
    required public init(nilLiteral: ()) {}

    public var hashValue: Int {
        return 0
    }

    public override func toJsonString() -> String {
        return "null"
    }
}
