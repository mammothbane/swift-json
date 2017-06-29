public func parseJson(s: Data): JValue {
    
}

public protocol JValue {
    toString() -> String
}

public struct JArray: JValue {
    var children: [JValue]
}

public struct JObject: JValue {
    var elems: [JString:JValue]
}

public struct JString: JValue, StringLiteralConvertible {
    var value: String

    init(stringLiteral: String) {
       	value = stringLiteral
    }
}

public struct JNumber: JValue, IntLiteralConvertible, FloatLiteralConvertible {
    var value: Double

    init(intLiteral: Int) {
       	value = Double(intLiteral)
    }

    init(floatLiteral: Float) {
	value = Double(floatLiteral)
    }
}

public struct JBool: JValue, BoolLiteralConvertible {
    var value: Bool

    init(boolLiteral: Boolean) {
       	value = boolLiteral
    }
}

public struct JNull: JValue, NilLiteralConvertible {
    init(nilLiteral: ()) {}
}
