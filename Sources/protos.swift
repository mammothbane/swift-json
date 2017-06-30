// MARK: ==

public func == (lhs: JValue, rhs: JValue) -> Bool {
    return false
}

public func == (lhs: JNumber, rhs: JNumber) -> Bool {
    return lhs.value == rhs.value
}

public func == (lhs: JBool, rhs: JBool) -> Bool {
    return lhs.value == rhs.value
}

public func == (lhs: JString, rhs: JString) -> Bool {
    return lhs.value == rhs.value
}

public func == (lhs: JObject, rhs: JObject) -> Bool {
    return lhs.elems == rhs.elems
}

public func == (lhs: JArray, rhs: JArray) -> Bool {
    return lhs.elems == rhs.elems
}

public func == (lhs: JNull, rhs: JNull) -> Bool { return true }

// MARK: <

public func < (lhs: JNumber, rhs: JNumber) -> Bool {
    return lhs.value < rhs.value
}

