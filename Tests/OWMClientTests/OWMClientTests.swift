import Foundation
import XCTest
@testable import OWMClient

final class OWMClientTests: XCTestCase {
    
    func testBoiseTemp() throws {
        let hiddenAPIKeyPath: String = URL(fileURLWithPath: #file)
            .pathComponents
            .prefix { $0 != "Tests" }
            .joined(separator: "/")
            .dropFirst()
            + "/.apiKey"
        let hiddenAPIKey = try String(contentsOfFile: hiddenAPIKeyPath)
            .trimmingCharacters(in: .whitespacesAndNewlines)
        let client = OWMClient(apiKey: hiddenAPIKey)
        let boiseTemp = try client.getTemp(city: "Boise")
        XCTAssert((-25...120).contains(boiseTemp))
    }

    static var allTests = [
        ("testBoiseTemp", testBoiseTemp),
    ]
}
