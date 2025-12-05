import Foundation

let fileURL = URL(fileURLWithPath: "input.txt")
let input = try String(contentsOf: fileURL, encoding: .utf8)

let sections = input.components(separatedBy: "\n\n")
let rangesSection = sections[0].components(separatedBy: .newlines).filter { !$0.isEmpty }
let ingredientsSection = sections[1].components(separatedBy: .newlines).filter { !$0.isEmpty }

var freshRanges: [(Int, Int)] = []
for line in rangesSection {
    let parts = line.components(separatedBy: "-")
    if parts.count == 2,
        let start = Int(parts[0]),
        let end = Int(parts[1]) {
            freshRanges.append((start, end))
        }
}

var ingredientIDs: [Int] = []
for line in ingredientsSection {
    if let id = Int(line.trimmingCharacters(in: .whitespaces)) {
        ingredientIDs.append(id)
    }
}

func isFresh(id: Int, ranges: [(Int, Int)]) -> Bool {
    for (start, end) in ranges {
        if id >= start && id <= end {
            return true
        }
    }
    return false
}

var freshCount = 0
for id in ingredientIDs {
    if isFresh(id: id, ranges: freshRanges) {
        freshCount += 1
    }
}

print("ANSWER: \(freshCount)")