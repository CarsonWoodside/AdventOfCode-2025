import Foundation

let fileURL = URL(fileURLWithPath: "input.txt")
let input = try String(contentsOf: fileURL, encoding: .utf8)
let lines = input.components(separatedBy: .newlines).filter { !$0.isEmpty }

let grid = lines.map { Array($0) }
let rows = grid.count
let cols = grid[0].count

let directions = [
    (-1, -1), (-1, 0), (-1, 1),  // top-left, top, top-right
    (0, -1),           (0, 1),   // left, right
    (1, -1),  (1, 0),  (1, 1)    // bottom-left, bottom, bottom-right
]

var accessibleCount = 0

for row in 0..<rows {
    for col in 0..<cols {
        if grid[row][col] == "@" {
            var adjacentRolls = 0

            for (dr, dc) in directions {
                let newRow = row + dr
                let newCol = col + dc

                if newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols {
                    if grid[newRow][newCol] == "@" {
                        adjacentRolls += 1
                    }
                }
            }

            if adjacentRolls < 4 {
                accessibleCount += 1
            }
        }
    }
}

print("ANSWER: \(accessibleCount)")