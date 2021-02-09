//
//  Utilities.swift
//  Korreck-Go
//
//  Created by Jeremiah Korreck on 2/8/21.
//

import Foundation

let columnNames = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

let stoneToCharacterDictionary: [PlayerColor?:String] = [nil: " . ",
                                                         PlayerColor.black: " X ",
                                                         PlayerColor.white: " O "]

func printMove(player: Player, move: Move) {
    var moveString: String
    if move.pass {
        moveString = "Passes"
    } else if move.conceed {
        moveString = "Resigns"
    } else {
        moveString = "\(columnNames[columnNames.index(columnNames.startIndex, offsetBy: move.point!.col - 1)]), \(move.point!.row)"
    }
    print("\(player.playerColor) \(moveString)")
}

func printBoard(board: Board) {
    for row in (0 ... board.numberRows).reversed() {
        var bump: String
        if row <= 9 {
            bump = " "
        } else {
            bump = ""
        }
        var line: String = ""
        for col in 1 ... board.numberColumns + 1 {
            let stone = board.get(point: Point(r: row, c: col))
            line.append(stoneToCharacterDictionary[stone]!)
        }
        print("\(bump)\(row) \(line)")
    }
    print("     \(columnNames[columnNames.index(columnNames.startIndex, offsetBy: board.numberColumns)])")
}
