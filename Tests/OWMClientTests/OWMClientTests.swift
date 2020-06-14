import XCTest
@testable import OWMClient

final class OWMClientTests: XCTestCase {
    
    func testBoiseTemp() throws {
        let client = OWMClient(apiKey: hiddenAPIKey)
        let boiseTemp = try client.getTemp(city: "Boise")
        XCTAssert((-25...120).contains(boiseTemp))
    }

    static var allTests = [
        ("testBoiseTemp", testBoiseTemp),
    ]
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


private let hiddenAPIKey = "a483d9d71a6d5e2f2b5b48a41f453f29"
