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
    let toneURLs: [String: URL] = [
    "A#3": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_A#3", ofType: "mp3")!),
    "A#4": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_A#4", ofType: "mp3")!),
    "A3": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_A3", ofType: "mp3")!),
    "A4": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_A4", ofType: "mp3")!),
    "B3": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_B3", ofType: "mp3")!),
    "B4": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_B4", ofType: "mp3")!),
    "C#3": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_C#3", ofType: "mp3")!),
    "C#4": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_C#4", ofType: "mp3")!),
    "C3": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_C3", ofType: "mp3")!),
    "C4": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_C4", ofType: "mp3")!),
    "C5": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_C5", ofType: "mp3")!),
    "D#3": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_D#3", ofType: "mp3")!),
    "D#4": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_D#4", ofType: "mp3")!),
    "D3": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_D3", ofType: "mp3")!),
    "D4": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_D4", ofType: "mp3")!),
    "E3": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_E3", ofType: "mp3")!),
    "E4": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_E4", ofType: "mp3")!),
    "F#3": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_F#3", ofType: "mp3")!),
    "F#4": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_F#4", ofType: "mp3")!),
    "F3": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_F3", ofType: "mp3")!),
    "F4": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_F4", ofType: "mp3")!),
    "G#3": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_G#3", ofType: "mp3")!),
    "G#4": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_G#4", ofType: "mp3")!),
    "G3": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_G3", ofType: "mp3")!),
    "G4": URL(fileURLWithPath: Bundle.main.path(forResource: "Sound_generator/sounds/Synth Bass 1/note_G4", ofType: "mp3")!),
]

    let numCards = totalSquares / 2
    var toneIndices = Array(0..<numCards)
    toneIndices += toneIndices
    toneIndices.shuffle()

    var body: some View {
        let totalSquares = notesPerRow * numCards 
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
