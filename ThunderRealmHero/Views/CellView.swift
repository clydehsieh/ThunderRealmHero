import SwiftUI

struct CellView: View {
    let cell: GameModel.Cell
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(backgroundColor)
                .frame(width: 30, height: 30)
            
            Text(cellContent)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(textColor)
        }
    }
    
    private var backgroundColor: Color {
        if !cell.isRevealed {
            return .blue.opacity(0.8)
        }
        return .white
    }
    
    private var cellContent: String {
        if cell.isFlagged {
            return "🚩"
        }
        if !cell.isRevealed {
            return ""
        }
        if cell.isMine {
            return "💣"
        }
        if cell.neighborMineCount > 0 {
            return "\(cell.neighborMineCount)"
        }
        return ""
    }
    
    private var textColor: Color {
        switch cell.neighborMineCount {
        case 1: return .blue
        case 2: return .green
        case 3: return .red
        case 4: return .purple
        default: return .black
        }
    }
}
