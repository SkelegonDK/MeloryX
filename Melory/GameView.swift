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
    let toneURLs = [
        "C3" = URL(fileURLWithPath: Bundle.main.path(forResource: "samples/C3", ofType: "wav")!),
        "C#3" = URL(fileURLWithPath: Bundle.main.path(forResource: "C#3", ofType: "wav")!),
        "D3" = URL(fileURLWithPath: Bundle.main.path(forResource: "D3", ofType: "wav")!),
        "D#3" = URL(fileURLWithPath: Bundle.main.path(forResource: "D#3", ofType: "wav")!),
        "E3" = URL(fileURLWithPath: Bundle.main.path(forResource: "E3", ofType: "wav")!),
        "F3" = URL(fileURLWithPath: Bundle.main.path(forResource: "F3", ofType: "wav")!),
        "F#3" = URL(fileURLWithPath: Bundle.main.path(forResource: "F#3", ofType: "wav")!),
        "G3" = URL(fileURLWithPath: Bundle.main.path(forResource: "G3", ofType: "wav")!),
        "G#3" = URL(fileURLWithPath: Bundle.main.path(forResource: "G#3", ofType: "wav")!),
        "A3" = URL(fileURLWithPath: Bundle.main.path(forResource: "A3", ofType: "wav")!),
        "A4" = URL(fileURLWithPath: Bundle.main.path(forResource: "A4", ofType: "wav")!),
        "A5" = URL(fileURLWithPath: Bundle.main.path(forResource: "A5", ofType: "wav")!),
        "A#4" = URL(fileURLWithPath: Bundle.main.path(forResource: "A#4", ofType: "wav")!),
        "B4" = URL(fileURLWithPath: Bundle.main.path(forResource: "B4", ofType: "wav")!),
        "B5" = URL(fileURLWithPath: Bundle.main.path(forResource: "B5", ofType: "wav")!),
        "C4" = URL(fileURLWithPath: Bundle.main.path(forResource: "C4", ofType: "wav")!),
        "D4" = URL(fileURLWithPath: Bundle.main.path(forResource: "D4", ofType: "wav")!),
        "D5" = URL(fileURLWithPath: Bundle.main.path(forResource: "D5", ofType: "wav")!),
        "D#4" = URL(fileURLWithPath: Bundle.main.path(forResource: "D#4", ofType: "wav")!),
        "E4" = URL(fileURLWithPath: Bundle.main.path(forResource: "E4", ofType: "wav")!),
        "E5" = URL(fileURLWithPath: Bundle.main.path(forResource: "E5", ofType: "wav")!),
        "F4" = URL(fileURLWithPath: Bundle.main.path(forResource: "F4", ofType: "wav")!),
        "F5" = URL(fileURLWithPath: Bundle.main.path(forResource: "F5", ofType: "wav")!),
        "F#3" = URL(fileURLWithPath: Bundle.main.path(forResource: "F#3", ofType: "wav")!),
        "G3" = URL(fileURLWithPath: Bundle.main.path(forResource: "G3", ofType: "wav")!),
        "G4" = URL(fileURLWithPath: Bundle.main.path(forResource: "G4", ofType: "wav")!),
        "G5" = URL(fileURLWithPath: Bundle.main.path(forResource: "G5", ofType: "wav")!),
        "G#3" = URL(fileURLWithPath: Bundle.main.path(forResource: "G#3", ofType: "wav")!),

    ]

    let numCards = totalSquares / 2
    var toneIndices = Array(0..<numCards)
    toneIndices += toneIndices
    toneIndices.shuffle()

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
