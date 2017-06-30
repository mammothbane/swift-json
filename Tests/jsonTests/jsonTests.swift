import XCTest
@testable import json

class jsonTests: XCTestCase {
    static var allTests = [
        ("testNumberSerialize", testNumberSerialize),
        ("testStringSerialize", testStringSerialize),
        ("testBoolSerialize", testBoolSerialize),
        ("testNullSerialize", testNullSerialize),
        ("testArraySerialize", testArraySerialize),
        ("testObjectSerialize", testObjectSerialize),
    ]

    func testNumberSerialize() {
        XCTAssertEqual(Json.number(4).jsonString(), "4")
        XCTAssertEqual(Json.number(0).jsonString(), "0")
        XCTAssertEqual(Json.number(1).jsonString(), "1")

        XCTAssertLessThan(Float(Json.number(4.1).jsonString())! - 4.1, 0.0000001)
        XCTAssertLessThan(Float(Json.number(0.5).jsonString())! - 0.5, 0.0000001)
        XCTAssertLessThan(Float(Json.number(1.23515).jsonString())! - 1.23515, 0.0000001)
    }

    func testStringSerialize() {
        XCTAssertEqual(Json.string("hello").jsonString(), "\"hello\"")
        XCTAssertEqual(Json.string("").jsonString(), "\"\"")
    }

    func testBoolSerialize() {
        XCTAssertEqual(Json.bool(true).jsonString(), "true")
        XCTAssertEqual(Json.bool(false).jsonString(), "false")
    }

    func testNullSerialize() {
        XCTAssertEqual(Json.null.jsonString(), "null")
    }

    func testArraySerialize() {
        let stuff = [Json.bool(true), Json.null, Json.string("herp"), Json.number(123), Json.number(-10), Json.string(""), Json.object(["herp": Json.number(345)])]

        let ary = Json.array(stuff)
        
        XCTAssertEqual(ary.jsonString(), "[true,null,\"herp\",123,-10,\"\",{\"herp\":345}]")
    }

    func testObjectSerialize() {
        let _ = Json.object([
                            "sup": Json.null,
                            "werp herpderp": Json.string("flermpwerp"),
                            "this is an array": Json.array([Json.number(3123),
                                                                 Json.null,
                                                                 Json.bool(false)]),
                            "hello": Json.object(["teib do go bobeil": Json.number(333)]),
                            "yo": Json.number(123)])
        //XCTAssertEqual(obj.jsonString(), "{\"sup\":null,\"werp herpderp\":\"flermpwerp\",\"this is an array\":[3123,null,false],\"hello\":{\"teib do go bobeil\":333},\"yo\":123}")
        XCTAssertEqual(Json.object([:]).jsonString(), "{}")
    }
}
