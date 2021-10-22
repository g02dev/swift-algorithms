
// Example
// let minHeap = Heap<Int>(orderBy: <)
// let maxHeap = Heap<Int>(orderBy: >)

public class Heap<T> {
    
    var isAncestorOf: (T, T) -> Bool
    
    var elements: [T]
    
    var lastIndex: Int? {
        return isEmpty ? nil : count - 1
    }
    
    public var count: Int {
        return elements.count
    }
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var peek: T? {
        return elements.first
    }
    
    public init(orderBy: @escaping (T, T) -> Bool) {
        self.isAncestorOf = orderBy
        self.elements = []
    }
    
    public init(_ elements: [T], orderBy: @escaping (T, T) -> Bool){
        self.isAncestorOf = orderBy
        self.elements = elements
        
        for index in stride(from: count - 1, through: 0, by: -1) {
            shiftDown(index: index)
        }
    }
    
    @discardableResult
    public func pop() -> T? {
        guard let value = elements.first else {
            return nil
        }
        
        let lastElement = elements.removeLast()
        
        if !isEmpty {
            elements[0] = lastElement
            shiftDown(index: 0)
        }
        
        return value
    }
    
    public func push(_ value: T) {
        elements.append(value)
        shiftUp(index: lastIndex!)
    }
    
    @discardableResult
    public func poppush(_ newValue: T) -> T? {
        guard let removedValue = elements.first else {
            return nil
        }
        
        elements[0] = newValue
        shiftDown(index: 0)
        
        return removedValue
    }
    
    func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    func leftChildIndex(of index: Int) -> Int {
        return 2 * index + 1
    }
    
    func rightChildIndex(of index: Int) -> Int {
        return 2 * index + 2
    }
    
    private func shiftUp(index: Int) {
        var index = index
        
        while index > 0 {
            let parentIndex = parentIndex(of: index)
            let value = elements[index]
            let parentValue = elements[parentIndex]
            let mustShiftUp = isAncestorOf(value, parentValue)
            
            if mustShiftUp {
                elements.swapAt(index, parentIndex)
            } else {
                return
            }
            
            index = parentIndex
        }
    }
    
    private func shiftDown(index: Int) {
        var index = index
        
        while index < count {
            let leftChildIndex = leftChildIndex(of: index)
            let rightChildIndex = rightChildIndex(of: index)
            let value = elements[index]
            
            var newValue = value
            var newValueOldIndex = index
            
            if leftChildIndex < count && isAncestorOf(elements[leftChildIndex], newValue) {
                newValue = elements[leftChildIndex]
                newValueOldIndex = leftChildIndex
            }
            
            if rightChildIndex < count && isAncestorOf(elements[rightChildIndex], newValue) {
                newValue = elements[rightChildIndex]
                newValueOldIndex = rightChildIndex
            }
            
            guard newValueOldIndex != index else {
                return
            }
            
            elements.swapAt(index, newValueOldIndex)
            index = newValueOldIndex
        }
    }
}
