import Foundation

let fileURL = URL(fileURLWithPath: "input.txt")
let input = try String(contentsOf: fileURL, encoding: .utf8)

let sections = input.components(separatedBy: "\n\n")
let rangesSection = sections[0].components(separatedBy: .newlines).filter { !$0.isEmpty }

var freshRanges: [(Int, Int)] = []
for line in rangesSection {
    let parts = line.components(separatedBy: "-")
    if parts.count == 2,
       let start = Int(parts[0]),
       let end = Int(parts[1]) {
        freshRanges.append((start, end))
    }
}

freshRanges.sort { $0.0 < $1.0 }

var mergedRanges: [(Int, Int)] = []
if !freshRanges.isEmpty {
    var current = freshRanges[0]

    for i in 1..<freshRanges.count {
        let next = freshRanges[i]

        if next.0 <= current.1 + 1 {
            current = (current.0, max(current.1, next.1))
        } else {
            mergedRanges.append(current)
            current = next
        }
    }

    mergedRanges.append(current)
}

var totalFreshIDs = 0
for (start, end) in mergedRanges {
    totalFreshIDs += (end - start + 1)
}

print("Merged ranges:")

for (start, end) in mergedRanges {
    print(" \(start)-\(end) (\(end - start + 1) IDs)")
}

print("ANSWER: \(totalFreshIDs)")