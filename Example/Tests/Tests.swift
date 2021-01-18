import XCTest
import BeeKit

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        XCTAssert(Validator.isURL().apply("http://www.baidu.com/index.html"), "Pass")
        XCTAssert(Validator.exactLength(4).apply("True"), "Pass")
    }
    
}
