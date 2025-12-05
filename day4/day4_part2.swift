import Foundation

// Read input from file
let fileURL = URL(fileURLWithPath: "input.txt")
let input = try String(contentsOf: fileURL, encoding: .utf8)
let lines = input.components(separatedBy: .newlines).filter { !$0.isEmpty }

// Parse the grid (make it mutable)
var grid = lines.map { Array($0) }
let rows = grid.count
let cols = grid[0].count

// Define the 8 directions (including diagonals)
let directions = [
    (-1, -1), (-1, 0), (-1, 1),  // top-left, top, top-right
    (0, -1),           (0, 1),   // left, right
    (1, -1),  (1, 0),  (1, 1)    // bottom-left, bottom, bottom-right
]

func countAdjacentRolls(row: Int, col: Int, grid: [[Character]]) -> Int {
    var count = 0
    for (dr, dc) in directions {
        let newRow = row + dr
        let newCol = col + dc
        if newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols {
            if grid[newRow][newCol] == "@" {
                count += 1
            }
        }
    }
    return count
}

func findAccessibleRolls(grid: [[Character]]) -> [(Int, Int)] {
    var accessible: [(Int, Int)] = []
    for row in 0..<rows {
        for col in 0..<cols {
            if grid[row][col] == "@" {
                let adjacentCount = countAdjacentRolls(row: row, col: col, grid: grid)
                if adjacentCount < 4 {
                    accessible.append((row, col))
                }
            }
        }
    }
    return accessible
}

var totalRemoved = 0

while true {
    let accessible = findAccessibleRolls(grid: grid)

    if accessible.isEmpty {
        break
    }

    for (row, col) in accessible {
        grid[row][col] = "."
    }

    totalRemoved += accessible.count
    print("Removed \(accessible.count) rolls, total so far: \(totalRemoved)")
}

print("ANSWER: \(totalRemoved)")