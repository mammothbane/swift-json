import XCTest
@testable import json

class jsonTests: XCTestCase {
    static var allTests = [
        ("testJNumberSerialize", testJNumberSerialize),
        ("testJStringSerialize", testJStringSerialize),
        ("testJBoolSerialize", testJBoolSerialize),
        ("testJNullSerialize", testJNullSerialize),
        ("testJArraySerialize", testJArraySerialize),
        ("testJObjectSerialize", testJObjectSerialize),
    ]

    func testJNumberSerialize() {
        XCTAssertEqual(JNumber(4).jsonString(), "4")
        XCTAssertEqual(JNumber(0).jsonString(), "0")
        XCTAssertEqual(JNumber(1).jsonString(), "1")

        XCTAssertLessThan(Float(JNumber(4.1).jsonString())! - 4.1, 0.0000001)
        XCTAssertLessThan(Float(JNumber(0.5).jsonString())! - 0.5, 0.0000001)
        XCTAssertLessThan(Float(JNumber(1.23515).jsonString())! - 1.23515, 0.0000001)
    }

    func testJStringSerialize() {
        XCTAssertEqual(JString("hello").jsonString(), "\"hello\"")
        XCTAssertEqual(JString("").jsonString(), "\"\"")
    }

    func testJBoolSerialize() {
        XCTAssertEqual(JBool(true).jsonString(), "true")
        XCTAssertEqual(JBool(false).jsonString(), "false")
    }

    func testJNullSerialize() {
        XCTAssertEqual(JNull().jsonString(), "null")
    }

    func testJArraySerialize() {
        let stuff = [JBool(true), JNull(), JString("herp"), JNumber(123), JNumber(-10), JString(""), JObject([JString("herp"): JNumber(345)])]

        let ary = JArray(stuff)
        
        XCTAssertEqual(ary.jsonString(), "[true,null,\"herp\",123,-10,\"\",{\"herp\":345}]")
    }

    func testJObjectSerialize() {
        let _ = JObject([
                            JString("sup"): JNull(),
                            JString("werp herpderp"): JString("flermpwerp"),
                            JString("this is an array"): JArray([JNumber(3123),
                                                                 JNull(),
                                                                 JBool(false)]),
                            JString("hello"): JObject([JString("teib do go bobeil"): JNumber(333)]),
                            JString("yo"): JNumber(123)])
        //XCTAssertEqual(obj.jsonString(), "{\"sup\":null,\"werp herpderp\":\"flermpwerp\",\"this is an array\":[3123,null,false],\"hello\":{\"teib do go bobeil\":333},\"yo\":123}")
        XCTAssertEqual(JObject([:]).jsonString(), "{}")
    }
}
