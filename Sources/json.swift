import Foundation

let formatter: NumberFormatter = NumberFormatter()
var initialized = false

func getFormatter() -> NumberFormatter {
    if initialized { return formatter }
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 30
    formatter.minimumIntegerDigits = 1 

    return formatter
}

public enum Json {
    indirect case array([Json])
    indirect case object([String:Json])
    case string(String)
    case number(Double)
    case bool(Bool)
    case null

    public func jsonString() -> String {
        switch self {
        case let .array(ary):
            return "[" + ary.map { $0.jsonString() }.joined(separator: ",") + "]"

        case let .object(obj):
            return "{" + obj.map { "\"\($0)\":\($1.jsonString())" }.joined(separator: ",") + "}"

        case let .string(str):
            return "\"\(str)\""

        case let .number(num):
            return getFormatter().string(from: NSNumber(value: num)) ?? "\(num)"

        case let .bool(bool):
            return "\(bool)"

        case .null:
            return "null"
        }
    }
}
