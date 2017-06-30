import jsmn
import Foundation

public enum ParseError: Error {
    case BadJson
    case OutOfMemory
    case Incomplete

    init(_ code: jsmnerr) throws {
        switch code {
        case JSMN_ERROR_INVAL:
            self = .BadJson
            break
        case JSMN_ERROR_NOMEM:
            self = .OutOfMemory
            break
        case JSMN_ERROR_PART:
            self = .Incomplete
            break
        default:
            throw "HELP"
        }
    }
}

public func parseJson(_ s: Data) throws -> Json {
    let toks = try? s.withUnsafeBytes { (pt: UnsafePointer<Int8>) throws -> [jsmntok_t] in
        var parser: jsmn_parser = jsmn_parser()
        jsmn_init(&parser)
        let count = jsmn_parse(&parser, pt, s.count, nil, 0)

        var toks: [jsmntok_t] = [jsmntok_t](repeating: jsmntok_t(), count: Int(count))
        jsmn_init(&parser)
        let result = jsmn_parse(&parser, pt, s.count, &toks, UInt32(count))

        if result < 0 {
            throw try! ParseError(jsmnerr(result))
        }
        return toks
    }

    let _ = recursiveParse(toks!)

    return .null
}

enum TokenType: Int {
    case undefined = 0
    case object = 1
    case array = 2
    case string = 3
    case primitive = 4
}

extension jsmntok_t {
    func string() -> String {
        return "Token: \(TokenType(rawValue: Int(self.type.rawValue))!). [\(self.start), \(self.end)](\(self.size))"
    }
}

/**
 *  Note: size counts *direct* children only
 */
func recursiveParse(_ toks: [jsmntok_t]) -> Int {
    for i in 0...10 {
        print(toks[i].string())
    }

    return 0
}
