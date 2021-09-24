struct UnionFind {

    var componentsCount: Int
    var parent: [Int]
    var rank: [Int]
    
    init(size: Int) {
        componentsCount = size
        rank = [Int](repeating: 0, count: size)
        parent = Array(0..<size)
    }
    
    mutating func find(_ x: Int) -> Int {
        if parent[x] == x {
            return x
        }
        
        parent[x] = find(parent[x])
        return parent[x]
    }
    
    @discardableResult
    mutating func union(_ x: Int, _ y: Int) -> Bool {
        let rootX = find(x)
        let rootY = find(y)
        
        if rootX == rootY {
            return false
        }
        
        componentsCount -= 1
        
        if rank[rootX] < rank[rootY] {
            parent[rootX] = rootY
        } else if rank[rootX] > rank[rootY] {
            parent[rootY] = rootX
        } else {
            parent[rootY] = rootX
            rank[rootX] += 1
        }
        
        return true
    }
    
    mutating func isUnited(_ x: Int, _ y: Int) -> Bool {
        return find(x) == find(y)
    }
    
}
