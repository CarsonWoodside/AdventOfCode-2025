import Foundation

func solveSecretEntrancePart2(input: String) -> Int {
    let lines = input.components(separatedBy: .newlines).filter { !$0.isEmpty }

    var currentPosition = 50
    var zeroCount = 0

    print("Starting position: \(currentPosition)")
    
    for line in lines {
        let direction = line.first!
        let distance = Int(line.dropFirst())!

        if direction == "L" {
            for _ in 0..<distance {
                currentPosition -= 1
                if currentPosition < 0 {
                    currentPosition = 99
                }
                if currentPosition == 0 {
                    zeroCount += 1
                    print("Passed through 0! (Count: \(zeroCount)")
                }
            }
        } else {
            for _ in 0..<distance {
                currentPosition += 1
                if currentPosition > 99 {
                    currentPosition = 0
                }
                if currentPosition == 0 {
                    zeroCount += 1
                    print("Passed through 0! (Count: \(zeroCount)")
                }
            }
        }

        print("\(line) -> position: \(currentPosition)")
    }
    print("---")
    return zeroCount
}

do {
    let puzzleInput = try String(contentsOfFile: "day1_input.txt", encoding: .utf8)
    let answer = solveSecretEntrancePart2(input: puzzleInput)
    print("\nPassword: \(answer)")
} catch {
    print("Error reading file: \(error)")
}