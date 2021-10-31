import XCTest
@testable import Algorithms


final class FenwickTreeTests: XCTestCase {
    
    let ftSize: Int = 10
    
    lazy var randomElements: [Int] = {
        var elements: [Int] = []
        for _ in 0..<ftSize {
            elements.append(Int.random(in: -100...100))
        }
        return elements
    }()
    
    var emptyFt: FenwickTree!
    var filledFt: FenwickTree!
    
    override func setUp() {
        super.setUp()
        emptyFt = FenwickTree(ftSize)
        filledFt = FenwickTree(randomElements)
    }
    
    override func tearDown() {
        emptyFt = nil
        filledFt = nil
        super.tearDown()
    }
    
    func testInit() {
        XCTAssertEqual(emptyFt.storage.count, ftSize + 1)
        XCTAssertEqual(filledFt.storage.count, ftSize + 1)
    }
    
    func testSumThrough() {
        XCTAssertEqual(emptyFt.sum(through: ftSize - 1), 0)
        XCTAssertEqual(filledFt.sum(through: ftSize - 1), randomElements.reduce(0, +), "Elements: \(randomElements)")
    }
    
    func testSumFromThrough() {
        for i in 0..<ftSize {
            for j in i..<ftSize {
                XCTAssertEqual(emptyFt.sum(from: i, through: j), 0)
                XCTAssertEqual(filledFt.sum(from: i, through: j), randomElements[i...j].reduce(0, +), "Elements: \(randomElements[i...j])")
            }
        }
    }
    
    func testAdd() {
        emptyFt.add(at: 0, value: 3)
        emptyFt.add(at: 4, value: 5)
        emptyFt.add(at: 6, value: 3)
        emptyFt.add(at: 0, value: -2)
        XCTAssertEqual(emptyFt.sum(through: ftSize - 1), 9)
    }
    
    func testUpdate() {
        emptyFt.update(at: 0, newValue: 3)
        emptyFt.update(at: 4, newValue: 5)
        emptyFt.update(at: 6, newValue: 3)
        emptyFt.update(at: 0, newValue: -2)
        XCTAssertEqual(emptyFt.sum(through: ftSize - 1), 6)
    }
    
}
