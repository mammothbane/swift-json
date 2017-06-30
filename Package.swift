// swift-tools-version:3.1

import PackageDescription

let package = Package(
  name: "json",
  dependencies: [
    .Package(url: "https://github.com/mammothbane/jsmn", majorVersion: 0)
  ]
)
