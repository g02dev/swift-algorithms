public struct UnionFind<T: Hashable> {

    var setsCount: Int
    var parent: [Int]
    var rank: [Int]
    var indices: [T: Int]
    
    public var count: Int {
        return parent.count
    }
    
    init() {
        setsCount = 0
        rank = []
        parent = []
        indices = [:]
    }
    
    public mutating func find(_ value: T) -> Int {
        let index = getIndex(value)
        return findByIndex(index)
    }
    
    mutating func findByIndex(_ index: Int) -> Int {
        if parent[index] == index {
            return index
        }
        
        parent[index] = findByIndex(parent[index])
        return parent[index]
    }
    
    @discardableResult
    public mutating func union(_ firstValue: T, _ secondValue: T) -> Bool {
        let firstRoot = find(firstValue)
        let secondRoot = find(secondValue)
        
        if firstRoot == secondRoot {
            return false
        }
        
        setsCount -= 1
        
        if rank[firstRoot] < rank[secondRoot] {
            parent[firstRoot] = secondRoot
        } else if rank[firstRoot] > rank[secondRoot] {
            parent[secondRoot] = firstRoot
        } else {
            parent[secondRoot] = firstRoot
            rank[firstRoot] += 1
        }
        
        return true
    }
    
    public mutating func isUnited(_ firstValue: T, _ secondValue: T) -> Bool {
        return find(firstValue) == find(secondValue)
    }
    
    mutating func getIndex(_ value: T) -> Int {
        if let index = indices[value] {
            return index
        }
        
        let index = count
        indices[value] = index
        parent.append(index)
        rank.append(0)
        setsCount += 1
        
        return index
    }
    
}
