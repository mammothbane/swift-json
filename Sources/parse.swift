import jsmn
import Foundation

let TOKS_COUNT = 64

public func parseJson(s: Data) -> Json {
    let out = try? s.withUnsafeBytes { (pt: UnsafePointer<Int8>) throws -> Json in
        var parser: jsmn_parser = jsmn_parser()
        var toks: [jsmntok_t] = [jsmntok_t](repeating: jsmntok_t(), count: TOKS_COUNT)
        jsmn_init(&parser)
        jsmn_parse(&parser, pt, s.count, &toks, TOKS_COUNT)


        return .null        
    }

    return out ?? .null
}

