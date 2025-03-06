import SwiftUI

class GameModel: ObservableObject {
    @Published var board: [[Cell]]
    @Published var gameStatus: GameStatus = .playing
    
    let rows: Int
    let columns: Int
    let mineCount: Int
    private var isFirstMove = true
    
    init(rows: Int = 9, columns: Int = 9, mineCount: Int = 10) {
        self.rows = rows
        self.columns = columns
        self.mineCount = mineCount
        self.board = Array(repeating: Array(repeating: Cell(), count: columns), count: rows)
    }
    
    struct Cell {
        var isMine = false
        var isRevealed = false
        var isFlagged = false
        var neighborMineCount = 0
    }
    
    enum GameStatus {
        case playing
        case won
        case lost
    }
    
    func resetGame() {
        board = Array(repeating: Array(repeating: Cell(), count: columns), count: rows)
        gameStatus = .playing
        isFirstMove = true
    }
    
    private func placeMines(excluding firstRow: Int, firstCol: Int) {
        var minesPlaced = 0
        while minesPlaced < mineCount {
            let randomRow = Int.random(in: 0..<rows)
            let randomCol = Int.random(in: 0..<columns)
            
            let isNearFirstClick = abs(randomRow - firstRow) <= 1 && abs(randomCol - firstCol) <= 1
            
            if !board[randomRow][randomCol].isMine && !isNearFirstClick {
                board[randomRow][randomCol].isMine = true
                minesPlaced += 1
            }
        }
        calculateNeighborMines()
    }
    
    private func calculateNeighborMines() {
        for row in 0..<rows {
            for col in 0..<columns {
                if !board[row][col].isMine {
                    board[row][col].neighborMineCount = countAdjacentMines(row: row, col: col)
                }
            }
        }
    }
    
    private func countAdjacentMines(row: Int, col: Int) -> Int {
        var count = 0
        for i in -1...1 {
            for j in -1...1 {
                let newRow = row + i
                let newCol = col + j
                if isValidPosition(row: newRow, col: newCol) && board[newRow][newCol].isMine {
                    count += 1
                }
            }
        }
        return count
    }
    
    private func isValidPosition(row: Int, col: Int) -> Bool {
        return row >= 0 && row < rows && col >= 0 && col < columns
    }
    
    func revealCell(at row: Int, col: Int) {
        guard isValidPosition(row: row, col: col) else { return }
        guard gameStatus == .playing && !board[row][col].isRevealed && !board[row][col].isFlagged else { return }
        
        if isFirstMove {
            placeMines(excluding: row, firstCol: col)
            isFirstMove = false
        }
        
        if board[row][col].isMine {
            gameStatus = .lost
            revealAllMines()
            return
        }
        
        revealCellRecursively(row: row, col: col)
        checkWinCondition()
    }
    
    private func revealCellRecursively(row: Int, col: Int) {
        guard isValidPosition(row: row, col: col) else { return }
        guard !board[row][col].isRevealed && !board[row][col].isFlagged && !board[row][col].isMine else { return }
        
        board[row][col].isRevealed = true
        
        if board[row][col].neighborMineCount == 0 {
            for i in -1...1 {
                for j in -1...1 {
                    revealCellRecursively(row: row + i, col: col + j)
                }
            }
        }
    }
    
    func toggleFlag(at row: Int, col: Int) {
        guard isValidPosition(row: row, col: col) && gameStatus == .playing else { return }
        guard !board[row][col].isRevealed else { return }
        
        board[row][col].isFlagged.toggle()
    }
    
    private func revealAllMines() {
        for row in 0..<rows {
            for col in 0..<columns {
                if board[row][col].isMine {
                    board[row][col].isRevealed = true
                }
            }
        }
    }
    
    private func checkWinCondition() {
        for row in 0..<rows {
            for col in 0..<columns {
                if !board[row][col].isMine && !board[row][col].isRevealed {
                    return
                }
            }
        }
        gameStatus = .won
    }
}
