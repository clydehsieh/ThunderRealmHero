# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ThunderRealmHero is a SwiftUI-based Minesweeper game for iOS using modern Apple frameworks.

## Architecture

- **Pattern**: SwiftUI + MVVM with ObservableObject
- **UI Framework**: SwiftUI (iOS 17+)
- **Data**: SwiftData for persistence (minimal usage)
- **State Management**: `@StateObject` and `@Published` properties

## Key Components

- **GameModel.swift**: Core game logic, grid state, and business rules
- **ContentView.swift**: Main UI with game mode switching (Reveal/Flag modes)
- **CellView.swift**: Individual grid cell component with visual states
- **ThunderRealmHeroApp.swift**: App entry point with SwiftData container setup

## Build Commands

```bash
# Build the project
xcodebuild -scheme ThunderRealmHero build

# Run all tests
xcodebuild -scheme ThunderRealmHero test

# Build for specific device
xcodebuild -scheme ThunderRealmHero -destination 'platform=iOS,name=iPhone'
```

## Game Logic

- 9x9 grid with 10 mines (configurable in GameModel)
- Two interaction modes: Reveal (🔍) and Flag (🚩)
- Auto-reveal feature for safe cells when mine count conditions are met
- First-click safety ensures initial tap is never a mine

## Development Notes

- Requires Xcode 15+ for SwiftUI and SwiftData support
- iOS 17+ deployment target
- No external dependencies - pure Apple ecosystem
- Game state is reactive through `@Published` properties