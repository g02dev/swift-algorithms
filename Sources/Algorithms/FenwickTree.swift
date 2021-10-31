public class FenwickTree {
    
    var storage: [Int]
    
    public init(_ n: Int) {
        storage = [Int](repeating: 0, count: n + 1)
    }
    
    public convenience init(_ nums: [Int]) {
        self.init(nums.count)
        for (index, num) in nums.enumerated() {
            add(at: index, value: num)
        }
    }
    
    public func sum(through: Int) -> Int {
        var index = through + 1
        var result = 0
        while index > 0 {
            result += storage[index]
            index -= index & -index
        }
        return result
    }
    
    public func sum(from: Int, through: Int) -> Int {
        return sum(through: through) - sum(through: from - 1)
    }
    
    public func update(at index: Int, newValue: Int) {
        let currValue = sum(from: index, through: index)
        let diff = newValue - currValue
        add(at: index, value: diff)
    }
    
    public func add(at index: Int, value: Int) {
        var index = index + 1
        while index < storage.count {
            storage[index] += value
            index += index & -index
        }
    }
}
