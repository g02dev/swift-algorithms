    import XCTest
    @testable import Algorithms

    final class UnionFindTests: XCTestCase {
        
        var uf: UnionFind<Int>!
        
        override func setUp() {
            super.setUp()
            uf = UnionFind()
        }
        
        override func tearDown() {
            uf = nil
            super.tearDown()
        }
        
        // MARK: - Test init
        
        func testInit() {
            XCTAssertEqual(uf.count, 0)
            XCTAssertEqual(uf.setsCount, 0)
        }
        
        
        // MARK: - Test find
        
        func testFind() {
            uf.union(1, 2)  // [[1, 2]]
            XCTAssertEqual(uf.find(1), uf.find(2))
            
            uf.union(2, 3)  // [[1, 2, 3]]
            XCTAssertEqual(uf.find(1), uf.find(2))
            XCTAssertEqual(uf.find(2), uf.find(3))
            
            uf.union(0, 4)  // [[0, 4], [1, 2, 3]]
            XCTAssertEqual(uf.find(0), uf.find(4))
            XCTAssertEqual(uf.find(1), uf.find(2))
            XCTAssertEqual(uf.find(2), uf.find(3))
            XCTAssertNotEqual(uf.find(0), uf.find(1))
            
            uf.union(0, 1)  // [[0, 1, 2, 3, 4]]
            XCTAssertEqual(uf.find(0), uf.find(1))
            XCTAssertEqual(uf.find(1), uf.find(2))
            XCTAssertEqual(uf.find(2), uf.find(3))
            XCTAssertEqual(uf.find(3), uf.find(4))
        }
        
        
        // MARK: - Test union
        
        func testUnion_unites() {
            XCTAssertTrue(uf.union(1, 2))  // [[0], [1, 2], [3], [4]]
            XCTAssertTrue(uf.union(2, 3))  // [[0], [1, 2, 3], [4]]
            XCTAssertTrue(uf.union(0, 4))  // [[0, 4], [1, 2, 3]]
            XCTAssertTrue(uf.union(0, 1))  // [[0, 1, 2, 3, 4]]
        }
        
        func testUnion_doesntUnite() {
            uf.union(1, 2)
            uf.union(3, 4)
            
            // [[0], [1, 2], [3, 4]]
            XCTAssertFalse(uf.union(0, 0))
            XCTAssertFalse(uf.union(1, 2))
            XCTAssertFalse(uf.union(2, 1))
            XCTAssertFalse(uf.union(3, 4))
            XCTAssertFalse(uf.union(4, 3))
        }
        
        // MARK: - Test isUnited
        
        func testIsUnited() {
            uf.union(1, 2)
            uf.union(3, 4)
            
            // [[0], [1, 2], [3, 4]]
            
            for i in 0..<uf.count {
                XCTAssertTrue(uf.isUnited(i, i))
            }
            
            XCTAssertTrue(uf.isUnited(1, 2))
            XCTAssertTrue(uf.isUnited(2, 1))
            XCTAssertTrue(uf.isUnited(3, 4))
            XCTAssertTrue(uf.isUnited(4, 3))
            
            XCTAssertFalse(uf.isUnited(0, 1))
            XCTAssertFalse(uf.isUnited(1, 0))
            XCTAssertFalse(uf.isUnited(2, 3))
            XCTAssertFalse(uf.isUnited(3, 2))
            XCTAssertFalse(uf.isUnited(0, 4))
            XCTAssertFalse(uf.isUnited(4, 0))
        }
        
        // MARK: - Test count
        
        func testCount() {
            XCTAssertTrue(uf.union(1, 2))  // [[1, 2]]
            XCTAssertEqual(uf.count, 2)
            
            XCTAssertTrue(uf.union(2, 3))  // [[1, 2, 3]]
            XCTAssertEqual(uf.count, 3)
            
            XCTAssertTrue(uf.union(0, 4))  // [[0, 4], [1, 2, 3]]
            XCTAssertEqual(uf.count, 5)
            
            XCTAssertTrue(uf.union(0, 1))  // [[0, 1, 2, 3, 4]]
            XCTAssertEqual(uf.count, 5)
        }
        
        // MARK: - Test setsCount
        
        func testSetsCount() {
            XCTAssertTrue(uf.union(1, 2))  // [[1, 2]]
            XCTAssertEqual(uf.setsCount, 1)
            
            XCTAssertTrue(uf.union(2, 3))  // [[1, 2, 3]]
            XCTAssertEqual(uf.setsCount, 1)
            
            XCTAssertTrue(uf.union(0, 4))  // [[0, 4], [1, 2, 3]]
            XCTAssertEqual(uf.setsCount, 2)
            
            XCTAssertTrue(uf.union(0, 1))  // [[0, 1, 2, 3, 4]]
            XCTAssertEqual(uf.setsCount, 1)
        }
    }
