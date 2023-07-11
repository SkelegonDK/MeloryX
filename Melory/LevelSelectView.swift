import SwiftUI
struct LevelSelectView: View {
    @State var isHardChordEnabled = true
    @State var selectedDifficulty: String?
    @State var isGameViewActive = false
    
    var body: some View {
        VStack(content: {
            Text("Level Select")
                .font(.title)
                .padding(.bottom, 20)
            
            Button("EASY") {
                selectedDifficulty = "EASY"
                isGameViewActive = true
            }
            .buttonStyle(LevelButtonStyle())
            .tag("EASY")
            
            Button("MID") {
                selectedDifficulty = "MID"
                isGameViewActive = true
            }
            .buttonStyle(LevelButtonStyle())
            .tag("MID")
            
            Button("CHALLENGING") {
                selectedDifficulty = "CHALLENGING"
                isGameViewActive = true
            }
            .buttonStyle(LevelButtonStyle())
            .tag("CHALLENGING")
            
            Button("HARDCHORD") {
                selectedDifficulty = "HARDCHORD"
                isGameViewActive = true
            }
            .buttonStyle(LevelButtonStyle())
            .tag("HARDCHORD")
            .disabled(isHardChordEnabled)
            
            NavigationLink(destination: GameView(difficulty: selectedDifficulty ?? "", timeRemaining: 0, gridCount: 0), isActive: $isGameViewActive) {
                EmptyView()
            }
        })
    }
    
    struct LevelButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .font(.headline)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                .multilineTextAlignment(.center)
        }
    }
}