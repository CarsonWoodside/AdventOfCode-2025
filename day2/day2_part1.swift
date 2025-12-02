import Foundation

func isRepeatedPattern(_ n: Int) -> Bool {
    let s = String(n)

    if s.count % 2 != 0 { return false }
    if s.first == "0" { return false }

    let half = s.count / 2
    let mid = s.index(s.startIndex, offsetBy: half)
    let firstHalf = s[..<mid]
    let secondHalf = s[mid...]

    return firstHalf == secondHalf
}

let filePath = "input.txt"

guard let input = try? String(contentsOfFile: filePath, encoding: .utf8)
    .trimmingCharacters(in: .whitespacesAndNewlines),
        !input.isEmpty else {
            fatalError("Could not read input.txt")
        }

let ranges = input.split(separator: ",")
var total = 0

for r in ranges {
    let trimmed = r.trimmingCharacters(in: .whitespacesAndNewlines)
    if trimmed.isEmpty { continue }

    let parts = trimmed.split(separator: "-")
    if parts.count != 2 { continue }

    guard let start = Int(parts[0]),
        let end = Int(parts[1]) else { continue }

    for id in start...end {
        if isRepeatedPattern(id) {
            total += id
        }
    }
}

print(total)