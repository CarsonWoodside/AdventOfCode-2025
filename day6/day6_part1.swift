import Foundation

let input: String
if let data = try? String(contentsOf: URL(fileURLWithPath: "input.txt"), encoding: .utf8) {
    input = data
} else {
    var lines: [String] = []
    while let line = readLine() {
        lines.append(line)
    }
    input = lines.joined(separator: "\n")
}

var lines = input.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
while let last = lines.last, last.trimmingCharacters(in: .whitespaces).isEmpty {
    lines.removeLast()
}

guard !lines.isEmpty else {
    print("0")
    exit(0)
}

let height = lines.count
let width = lines.map { $0.count }.max() ?? 0

var grid: [[Character]] = []
grid.reserveCapacity(height)

for line in lines {
    var row = Array(line)
    if row.count < width {
        row.append(contentsOf: Array(repeating: Character(" "), count: width - row.count))
    }
    grid.append(row)
}

func isBlankColumn(_ col: Int) -> Bool {
    for r in 0..<height {
        if grid[r][col] != " " {
            return false
        }
    }
    return true
}

struct Segment {
    let start: Int
    let end: Int   
}

var segments: [Segment] = []
var col = 0
while col < width {
    while col < width && isBlankColumn(col) {
        col += 1
    }
    if col >= width { break }
    
    // Start of a segment
    let start = col
    col += 1
    while col < width && !isBlankColumn(col) {
        col += 1
    }
    let end = col - 1
    segments.append(Segment(start: start, end: end))
}

let lastRowIndex = height - 1
var grandTotal: Int64 = 0

for seg in segments {
    let opChars = grid[lastRowIndex][seg.start...seg.end]
    let opCharOpt = opChars.first(where: { $0 != " " })
    
    guard let opChar = opCharOpt, opChar == "+" || opChar == "*" else {
        continue
    }
    
    var numbers: [Int64] = []
    
    if lastRowIndex > 0 {
        for r in 0..<(lastRowIndex) {
            let chars = grid[r][seg.start...seg.end]
            let s = String(chars)
            let trimmed = s.trimmingCharacters(in: .whitespaces)
            if !trimmed.isEmpty {
                if let val = Int64(trimmed) {
                    numbers.append(val)
                }
            }
        }
    }
    
    guard !numbers.isEmpty else { continue }
    
    let segmentResult: Int64
    if opChar == "+" {
        segmentResult = numbers.reduce(0, +)
    } else { 
        segmentResult = numbers.reduce(1, *)
    }
    
    grandTotal += segmentResult
}

print(grandTotal)
