//
//  main.swift
//  Sudoku Backtracking Algorithm
//
//  Created by ali on 4/20/21.
//

import Foundation


class BackTrackingSudoku {
    
    var sudoku: [[Int]] = []
    
    init(sudoku: [[Int]]) {
        self.sudoku = sudoku
    }
    
    func play() {
        if solve() {
            print()
        } else {
            Swift.print("Solution 404 Not found!!")
        }
    }
    
    func findEmptyLocation(row: Int, coloumn: Int) -> (Int , Int, Bool) {
        for i in 0 ..< 9 {
            for j in 0 ..< 9 {
                if self.sudoku[i][j] == 0 {
                    return (i, j, true)
                }
            }
        }
        return (row, coloumn, false)
    }
    
    
    func isInRow(number: Int, row: Int) -> Bool {
        return self.sudoku[row].contains(number)
    }
    
    func isInColoumn(number: Int, coloumn: Int) -> Bool {
        for i in 0 ..< 9 {
            if self.sudoku[i][coloumn] == number {
                return true
            }
        }
        return false
    }
    
    func isInBox(number: Int, row: Int, coloumn: Int) -> Bool {
        for i in 0 ..< 3 {
            for j in 0 ..< 3 {
                if self.sudoku[i + (row - (row % 3))][j + (coloumn - (coloumn % 3))] == number {
                    return true
                }
            }
        }
        return false
    }
    
    func isLocationSafe(number: Int, row: Int, coloumn: Int) -> Bool {
        return !isInColoumn(number: number, coloumn: coloumn) &&
            !isInRow(number: number, row: row) &&
            !isInBox(number: number, row: row, coloumn: coloumn - (coloumn % 3))
    }
    
    func solve() -> Bool {
        
        var (row, col, con) = (0, 0, false)
        
        (row, col, con) = findEmptyLocation(row: row, coloumn: col)
        
        if !con {
            return true
        }
        for num in 1 ... 9 {
            if isLocationSafe(number: num, row: row, coloumn: col) {
                sudoku[row][col] = num
                
                if solve() {
                    return true
                }
                sudoku[row][col] = 0
            }
        }
        return false
    }
    
    func print() {
        for i in 0 ..< 9 {
            for j in 0 ..< 9 {
                Swift.print(sudoku[i][j], terminator:" ")
            }
            Swift.print("\n")
        }
    }
}

let game = BackTrackingSudoku(sudoku:
                                [[0, 9, 0, 0, 0, 6, 1, 0, 0],
                                 [7, 1, 0, 0, 9, 0, 0, 2, 8],
                                 [0, 0, 8, 0, 0, 0, 0, 4, 9],
                                 [0, 6, 0, 2, 5, 0, 0, 0, 1],
                                 [0, 0, 0, 0, 0, 0, 0, 0, 0],
                                 [5, 0, 0, 0, 6, 9, 0, 7, 0],
                                 [1, 2, 0, 0, 0, 0, 8, 0, 0],
                                 [9, 8, 0, 0, 4, 0, 0, 5, 2],
                                 [0, 0, 5, 6, 0, 0, 0, 1, 0]]
)


game.play()
