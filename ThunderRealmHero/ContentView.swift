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
    @State private var gameMode: GameMode = .reveal
    
    enum GameMode {
        case reveal
        case flag
        
        var buttonText: String {
            switch self {
            case .reveal: return "🔍 Reveal Mode"
            case .flag: return "🚩 Flag Mode"
            }
        }
        
        var buttonColor: Color {
            switch self {
            case .reveal: return .blue
            case .flag: return .red
            }
        }
    }
    
    var body: some View {
        VStack {
            Text(statusText)
                .font(.headline)
                .padding()
            
            // 模式切換按鈕
            Button {
                gameMode = gameMode == .reveal ? .flag : .reveal
            } label: {
                Text(gameMode.buttonText)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(gameMode.buttonColor)
                    .cornerRadius(8)
            }
            .padding(.bottom)
            
            VStack(spacing: 1) {
                ForEach(0..<gameModel.rows, id: \.self) { row in
                    HStack(spacing: 1) {
                        ForEach(0..<gameModel.columns, id: \.self) { column in
                            CellView(cell: gameModel.board[row][column])
                                .onTapGesture {
                                    switch gameMode {
                                    case .reveal:
                                        gameModel.revealCell(at: row, col: column)
                                    case .flag:
                                        gameModel.toggleFlag(at: row, col: column)
                                    }
                                }
                        }
                    }
                }
            }
            .background(Color.gray)
            .padding()
            
            HStack(spacing: 20) {
                Button("New Game") {
                    gameModel.resetGame()
                }
                .padding()
                
                // 可以添加其他遊戲控制按鈕
            }
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
