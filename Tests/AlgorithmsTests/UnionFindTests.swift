    import XCTest
    @testable import Algorithms

    final class UnionFindTests: XCTestCase {
        
        var sut: UnionFind!  // system under test
        var sutSize: Int!
        
        override func setUp() {
            super.setUp()
            sutSize = 5
            sut = UnionFind(size: sutSize)
        }
        
        override func tearDown() {
            sutSize = nil
            sut = nil
            super.tearDown()
        }
        
        // MARK: - Test init
        
        func testInit() {
            XCTAssertEqual(sut.componentsCount, sutSize)
            XCTAssertEqual(sut.parent.count, sutSize)
            XCTAssertEqual(sut.rank.count, sutSize)

            for i in 0..<sutSize {
                XCTAssertEqual(sut.parent[i], i)
                XCTAssertEqual(sut.rank[i], 0)
            }
        }
        
        
        // MARK: - Test find
        
        func testFind() {
            sut.union(1, 2)  // [[0], [1, 2], [3], [4]]
            XCTAssertEqual(sut.find(1), sut.find(2))
            
            sut.union(2, 3)  // [[0], [1, 2, 3], [4]]
            XCTAssertEqual(sut.find(1), sut.find(2))
            XCTAssertEqual(sut.find(2), sut.find(3))
            
            sut.union(0, 4)  // [[0, 4], [1, 2, 3]]
            XCTAssertEqual(sut.find(0), sut.find(4))
            
            sut.union(0, 1)  // [[0, 1, 2, 3, 4]]
            XCTAssertEqual(sut.find(0), sut.find(1))
            XCTAssertEqual(sut.find(1), sut.find(2))
            XCTAssertEqual(sut.find(2), sut.find(3))
            XCTAssertEqual(sut.find(3), sut.find(4))
        }
        
        
        // MARK: - Test union
        
        func testUnion_unites() {
            XCTAssertTrue(sut.union(1, 2))  // [[0], [1, 2], [3], [4]]
            XCTAssertTrue(sut.union(2, 3))  // [[0], [1, 2, 3], [4]]
            XCTAssertTrue(sut.union(0, 4))  // [[0, 4], [1, 2, 3]]
            XCTAssertTrue(sut.union(0, 1))  // [[0, 1, 2, 3, 4]]
        }
        
        func testUnion_doesntUnite() {
            sut.union(1, 2)
            sut.union(3, 4)
            
            // [[0], [1, 2], [3, 4]]
            XCTAssertFalse(sut.union(0, 0))
            XCTAssertFalse(sut.union(1, 2))
            XCTAssertFalse(sut.union(2, 1))
            XCTAssertFalse(sut.union(3, 4))
            XCTAssertFalse(sut.union(4, 3))            
        }
        
        // MARK: - Test isUnited
        
        func testIsUnited() {
            sut.union(1, 2)
            sut.union(3, 4)
            
            // [[0], [1, 2], [3, 4]]
            
            for i in 0..<sutSize {
                XCTAssertTrue(sut.isUnited(i, i))
            }
            
            XCTAssertTrue(sut.isUnited(1, 2))
            XCTAssertTrue(sut.isUnited(2, 1))
            XCTAssertTrue(sut.isUnited(3, 4))
            XCTAssertTrue(sut.isUnited(4, 3))
            
            XCTAssertFalse(sut.isUnited(0, 1))
            XCTAssertFalse(sut.isUnited(1, 0))
            XCTAssertFalse(sut.isUnited(2, 3))
            XCTAssertFalse(sut.isUnited(3, 2))
            XCTAssertFalse(sut.isUnited(0, 4))
            XCTAssertFalse(sut.isUnited(4, 0))
        }
    }
