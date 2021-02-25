import XCTest
@testable import LinkedIn_Scraper

final class LinkedIn_ScraperTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(LinkedIn_Scraper().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
