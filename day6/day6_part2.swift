import Foundation

let input = try! String(contentsOfFile: "input.txt", encoding: .utf8)
var lines = input.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
while let last = lines.last, last.trimmingCharacters(in: .whitespaces).isEmpty {
    lines.removeLast()
}

let height = lines.count
let width = lines.map { $0.count }.max() ?? 0

var grid: [[Character]] = []
for line in lines {
    var row = Array(line)
    if row.count < width {
        row.append(contentsOf: Array(repeating: " ", count: width - row.count))
    }
    grid.append(row)
}

func isBlankColumn(_ c: Int) -> Bool {
    for r in 0..<height {
        if grid[r][c] != " " { return false }
    }
    return true
}

struct Segment { let start: Int; let end: Int }
var segments: [Segment] = []

var col = 0
while col < width {
    while col < width && isBlankColumn(col) { col += 1 }
    if col >= width { break }
    
    let start = col
    col += 1
    while col < width && !isBlankColumn(col) { col += 1 }
    let end = col - 1
    
    segments.append(Segment(start: start, end: end))
}

let lastRow = height - 1
var grandTotal: Int64 = 0

for seg in segments {
    let bottomSlice = grid[lastRow][seg.start...seg.end]
    guard let op = bottomSlice.first(where: { $0 == "+" || $0 == "*" }) else { continue }
    
    var numbers: [Int64] = []

    var c = seg.end
    while c >= seg.start {
        var digits: [Character] = []
        
        for r in 0..<lastRow {
            let ch = grid[r][c]
            if ch.isNumber {
                digits.append(ch)
            }
        }
        
        if !digits.isEmpty {
            let str = String(digits)
            if let value = Int64(str) {
                numbers.append(value)
            }
        }
        
        c -= 1
    }
    
    guard !numbers.isEmpty else { continue }
    
    let result: Int64
    if op == "+" {
        result = numbers.reduce(0, +)
    } else {
        result = numbers.reduce(1, *)
    }
    
    grandTotal += result
}

print(grandTotal)
