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
    @State var gridCount: Int
    @State var timerStarted = false
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
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
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: gridCount), spacing: 10) {
                    ForEach(0..<gridCount * gridCount) { index in
                        Button(action: {
                            // Handle button tap
                            playSound()
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                    }
                }
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
                gridCount = 6
            case "MID":
                timeRemaining = 90
                gridCount = 8
            case "CHALLENGING":
                timeRemaining = 120
                gridCount = 10
            case "HARDCHORD":
                timeRemaining = 150
                gridCount = 12
            default:
                timeRemaining = 60
                gridCount = 6
            }
        }
    }
    
    func playSound() {
        // Play sound
    }
}