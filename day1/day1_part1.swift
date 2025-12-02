import Foundation

func solveSecretEntrance(input: String) -> Int {
    let lines = input.components(separatedBy: .newlines).filter { !$0.isEmpty }

    var currentPosition = 50
    var zeroCount = 0

    for line in lines {
        let direction = line.first! // L or R
        let distance = Int(line.dropFirst())!

        if direction == "L" {
            // Move left (-> lower numbers)
            currentPosition = (currentPosition - distance) % 100

            if currentPosition < 0 {
                currentPosition += 100
            }
        } else {
            // Move right (-> higher numbers)
            currentPosition = (currentPosition + distance) % 100
        }

        if currentPosition == 0 {
            zeroCount += 1
        }
    }
    return zeroCount
}



do {
    let puzzleInput = try String(contentsOfFile: "day1_input.txt", encoding: .utf8)
    let answer = solveSecretEntrance(input: puzzleInput)
    print("\nPassword: \(answer)")
} catch {
    print("Error reading file: \(error)")
}