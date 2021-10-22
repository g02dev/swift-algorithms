// 

import XCTest
@testable import Algorithms


final class MinHeapTests: XCTestCase {
    
    let orderBy: (Int, Int) -> Bool = (<)
    
    var emptyHeap: Heap<Int>!
    var filledHeap: Heap<Int>!
    
    lazy var randomElements: [Int] = {
        let elementsCount = 20
        let minElement = -100
        let maxElement = 100
        
        var elements: [Int] = []
        for _ in 0..<elementsCount {
            let value = Int.random(in: minElement...maxElement)
            elements.append(value)
        }
        
        return elements
    }()
    
    lazy var randomElementsSorted: [Int] = {
        return randomElements.sorted(by: orderBy)
    }()
    
    override func setUp() {
        super.setUp()
        emptyHeap = Heap<Int>(orderBy: orderBy)
        filledHeap = Heap<Int>(randomElements, orderBy: orderBy)
    }
    
    override func tearDown() {
        emptyHeap = nil
        filledHeap = nil
        super.tearDown()
    }
    
    
    // MARK: - Utils
    
    private func isValidHeap<T>(_ heap: Heap<T>) -> Bool {
        for index in 0..<heap.count {
            let element = heap.elements[index]
            let leftChildIndex = heap.leftChildIndex(of: index)
            let rightChildIndex = heap.rightChildIndex(of: index)
            
            guard heap.elements.indices.contains(index) else {
                return false
            }
            
            if leftChildIndex < heap.count && heap.isAncestorOf(heap.elements[leftChildIndex], element) {
                return false
            }
            
            if rightChildIndex < heap.count && heap.isAncestorOf(heap.elements[rightChildIndex], element) {
                return false
            }
        }
        
        return true
    }
    
    private func findPeek<T>(_ elements: [T], orderBy isAncestorOf: (T, T) -> Bool) -> T? {
        guard elements.count > 0 else {
            return nil
        }
        
        var peek = elements[0]
        for element in elements {
            if isAncestorOf(element, peek) {
                peek = element
            }
        }
        return peek
    }
    
    
    // MARK: - Tests
    
    func testInit() {
        XCTAssert(emptyHeap.isEmpty)
        XCTAssert(emptyHeap.count == 0)
        XCTAssertEqual(emptyHeap.elements, [])
    }
    
    func testInit_withArray() {
        XCTAssertFalse(filledHeap.isEmpty)
        XCTAssertEqual(filledHeap.count, randomElements.count)
        XCTAssertEqual(filledHeap.elements.sorted(by: filledHeap.isAncestorOf), randomElementsSorted)
        XCTAssert(isValidHeap(filledHeap), "Invalid heap: \(filledHeap.elements)")
    }
    
    func testPush() {
        let heap = emptyHeap!
        for (i, element) in randomElements.enumerated() {
            heap.push(element)
            XCTAssertFalse(heap.isEmpty)
            XCTAssertEqual(heap.count, i + 1)
            XCTAssert(heap.elements.contains(element))
            XCTAssert(isValidHeap(heap), "Invalid heap: \(heap.elements)")
        }
    }
    
    func testPop() {
        XCTAssertNil(emptyHeap.pop())
        
        let heap = filledHeap!
        for (i, peek) in randomElementsSorted.enumerated() {
            XCTAssertEqual(heap.pop(), peek)
            XCTAssertEqual(heap.count, randomElements.count - i - 1)
            XCTAssert(isValidHeap(heap), "Invalid heap: \(heap.elements)")
            
            let randomElementsLeftSorted = Array(randomElementsSorted[(i+1)...])
            let heapElementsSorted = heap.elements.sorted(by: heap.isAncestorOf)
            
            XCTAssertEqual(randomElementsLeftSorted, heapElementsSorted)
        }
        XCTAssertNil(heap.pop())
    }
    
    func testPeek() {
        let heap = emptyHeap!
        XCTAssertNil(heap.peek)
        
        // Push elements
        var peekElement = randomElements[0]
        for element in randomElements {
            if heap.isAncestorOf(element, peekElement) {
                peekElement = element
            }
            heap.push(element)
            XCTAssertEqual(heap.peek, peekElement, "Invalid peek for push: \(heap.elements)")
        }
        
        // Pop elements
        for peekElement in randomElementsSorted {
            XCTAssertEqual(heap.peek, peekElement, "Invalid peek for pop: \(heap.elements)")
            heap.pop()
        }
        XCTAssertNil(heap.peek)
    }

    func testPoppush() {
        let heap = emptyHeap!
        XCTAssertNil(heap.poppush(0))
        
        let heapSize = 5
        for i in 0..<heapSize {
            heap.push(randomElements[i])
        }
        
        for i in heapSize..<randomElements.count {
            let newElement = randomElements[i]
            let removedPeek = heap.poppush(newElement)
            let newPeek = heap.peek
            
            XCTAssertNotNil(newPeek)
            XCTAssertNotNil(removedPeek)
            XCTAssertEqual(heap.count, heapSize)
            XCTAssert(heap.elements.contains(newElement))
            XCTAssert(heap.isAncestorOf(removedPeek ?? 0, newPeek ?? 0) || newPeek == removedPeek || newPeek == newElement)
            XCTAssert(isValidHeap(heap), "Invalid heap: \(heap.elements)")
        }
    }
}
