import Foundation

func findMaxJoltage(from bank: String, batteryCount: Int = 12) -> Int {
    let digits = Array(bank)

    let digitsToRemove = digits.count - batteryCount
    var stack: [Character] = []
    var removalsLeft = digitsToRemove

    for digit in digits {
        while !stack.isEmpty && removalsLeft > 0 && stack.last! < digit {
            stack.removeLast()
            removalsLeft -= 1
        }
        stack.append(digit)
    }

    while removalsLeft > 0 {
        stack.removeLast()
        removalsLeft -= 1
    }
    return Int(String(stack)) ?? 0
}

func solvePuzzle(inputFile: String) -> Int {
    do {
        let content = try String(contentsOfFile: inputFile, encoding: .utf8)
        let lines = content.components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
        
        var totalJoltage = 0

        for line in lines {
            let maxJoltage = findMaxJoltage(from: line, batteryCount: 12)
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