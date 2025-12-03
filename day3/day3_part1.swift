import Foundation

func findMaxJoltage(from bank: String) -> Int {
    let digits = Array(bank)
    var maxJoltage = 0

    for i in 0..<digits.count {
        for j in (i+1)..<digits.count {
            if let firstDigit = Int(String(digits[i])),
                let secondDigit = Int(String(digits[j])) {
                    let joltage = firstDigit * 10 + secondDigit
                    maxJoltage = max(maxJoltage, joltage)
                }
        }
    }

    return maxJoltage
}

func solvePuzzle(inputFile: String) -> Int {
    do {
        let content = try String(contentsOfFile: inputFile, encoding: .utf8)
        let lines = content.components(separatedBy: .newlines)
            .filter { !$0.isEmpty }

        var totalJoltage = 0

        for line in lines {
            let maxJoltage = findMaxJoltage(from: line)
            print("Bank: \(line) -> Max Joltage: \(maxJoltage)")
            totalJoltage += maxJoltage
        }

        return totalJoltage
    } catch {
        print("Error reading file")
        return 0
    }
}

let result = solvePuzzle(inputFile: "input.txt")
print("ANSWER: \(result)")