//
//  ContentView.swift
//  ThunderRealmHero
//
//  Created by ClydeHsieh on 2025/3/6.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var gameModel = GameModel()
    
    var body: some View {
        VStack {
            Text(statusText)
                .font(.headline)
                .padding()
            
            VStack(spacing: 1) {
                ForEach(0..<gameModel.rows, id: \.self) { row in
                    HStack(spacing: 1) {
                        ForEach(0..<gameModel.columns, id: \.self) { column in
                            CellView(cell: gameModel.board[row][column])
                                .onTapGesture {
                                    gameModel.revealCell(at: row, col: column)
                                }
                                .onLongPressGesture {
                                    gameModel.toggleFlag(at: row, col: column)
                                }
                        }
                    }
                }
            }
            .background(Color.gray)
            .padding()
            
            Button("New Game") {
                gameModel.resetGame()
            }
            .padding()
        }
    }
    
    private var statusText: String {
        switch gameModel.gameStatus {
        case .playing:
            return "Game On!"
        case .won:
            return "You Won! 🎉"
        case .lost:
            return "Game Over 💣"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
