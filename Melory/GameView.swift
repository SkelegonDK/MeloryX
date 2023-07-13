//
//  GameView.swift
//  Melory
//
//  Created by Manuel Thomsen on 11/07/2023.
//

import SwiftUI
import AVFoundation

struct GameView: View {
    let difficulty: String
    
    @State var timeRemaining: Double
    @State var totalSquares: Int
    @State var timerStarted = false
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    let difficultyLevels = [
        "EASY": 3,
        "MID": 4,
        "CHALLENGING": 6,
        "HARDCHORD": 8
    ]
    let notesPerRow = 4
    let notes = ["C3", "D3", "E3", "F3", "G3", "A3", "B3", "C4"]

    var body: some View {
        VStack {
            HStack {
                Text(String(format: "%.2f", timeRemaining))
                    .font(.system(size: 20))
                    .padding(.all, 5)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.trailing, 20)
            }
            
            if timerStarted {
                let columns = difficultyLevels[difficulty] ?? 3
                
                let rows = totalSquares / columns
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: columns), spacing: 10) {
                    ForEach(0..<totalSquares) { index in
                        Button(action: {
                            //btn action
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                                .aspectRatio(1, contentMode: .fit)
                                
                        }
                    }
                }
                .frame(maxWidth: .infinity,maxHeight: UIScreen.main.bounds.height - (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0) - 100)
            }
        }
        .padding()
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 0.01
                timerStarted = true
            }
        }
        .onAppear {
            switch difficulty {
            case "EASY":
                timeRemaining = 60
                totalSquares = 18
            case "MID":
                timeRemaining = 90
                totalSquares = 32
            case "CHALLENGING":
                timeRemaining = 120
                totalSquares = 60
            case "HARDCHORD":
                timeRemaining = 150
                totalSquares = 104
            default:
                timeRemaining = 60
                totalSquares = 18
            }
        }
    }
}
