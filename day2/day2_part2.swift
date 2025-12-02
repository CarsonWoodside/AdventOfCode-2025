import Foundation

func isRepeatedPattern(_ n: Int) -> Bool {
    let s = String(n)
    let L = s.count

    if L < 2 { return false }

    let chars = Array(s)

    // try every possible length
    for patternLen in 1...(L / 2) {
        if L % patternLen != 0 { continue }

        var matches = true

        for i in 0..<L {
            if chars [i] != chars[i % patternLen] {
                matches = false
                break
            }
        }

        if matches {
            return true
        }
    }

    return false
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