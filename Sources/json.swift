import Foundation

public class JValue:
  Equatable {
    fileprivate init() {}
    public func jsonString() -> String {return ""}

    public func json(with encoding: String.Encoding = .utf8) -> Data? {
        return self.jsonString().data(using: encoding)
    }
}

public class JArray:
  JValue {
    var elems: [JValue]
    
    public override func jsonString() -> String {
        return "[" + elems.map { $0.jsonString() }.joined(separator: ",") + "]"
    }

    public override init() {
        elems = []
        super.init()
    }
    
    public init(_ elems: [JValue]) {
        self.elems = elems
    }
}

public class JObject:
  JValue {
    var elems: [JString:JValue]

    public override func jsonString() -> String {
        return "{" + elems.map { "\($0.jsonString()):\($1.jsonString())" }.joined(separator: ",") + "}"
    }

    public override init() { 
       elems = [:]
       super.init()
    }

    public init(_ elems: [JString:JValue]) {
        self.elems = elems
    }
}

public class JString:
  JValue,
  ExpressibleByStringLiteral,
  Hashable {
    public var value: String

    public init(_ value: String) {
        self.value = value
    }
    
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

    // TODO: handle unicode, escaping, etc.
    public override func jsonString() -> String {
        return "\"\(value)\""
    }
}

let formatter: NumberFormatter = NumberFormatter()
var initialized = false

func getFormatter() -> NumberFormatter {
    if initialized { return formatter }
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 30
    formatter.minimumIntegerDigits = 1 

    return formatter
}

public class JNumber:
  JValue,
  ExpressibleByIntegerLiteral,
  ExpressibleByFloatLiteral,
  Hashable,
  Comparable {
    public var value: Double

    public init(_ value: Double) {
        self.value = value
    }

    public init(_ value: Float) {
        self.value = Double(value)
    }

    public init(_ value: Int) {
        self.value = Double(value)
    }

    required public init(integerLiteral: Int) {
       	value = Double(integerLiteral)
    }

    required public init(floatLiteral: Float) {
	value = Double(floatLiteral)
    }

    public var hashValue: Int {
        return value.hashValue
    }

    public override func jsonString() -> String {
        return getFormatter().string(from: NSNumber(value: value)) ?? "\(value)"
    }
}

public class JBool:
  JValue,
  ExpressibleByBooleanLiteral,
  Hashable {
    public var value: Bool

    public init(_ value: Bool) {
        self.value = value
    }
    
    required public init(booleanLiteral: Bool) {
       	value = booleanLiteral
    }

    public var hashValue: Int {
        return value.hashValue
    }

    public override func jsonString() -> String {
        return "\(value)"
    }
}

public class JNull:
  JValue,
  ExpressibleByNilLiteral,
  Hashable {
    required public init(nilLiteral: ()) {}

    override public init() {
        super.init()
    }
    
    public var hashValue: Int {
        return 0
    }

    public override func jsonString() -> String {
        return "null"
    }
}
