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
            
            NavigationLink(destination: GameView(difficulty: "EASY", timeRemaining: 60.00, totalSquares: 18)) {
                Text("EASY")
            }
            .padding(.bottom, 10)
            .buttonStyle(LevelButtonStyle())
            
            NavigationLink(destination: GameView(difficulty: "MID", timeRemaining: 90.00, totalSquares: 30)) {
                Text("MID")
            }
            .padding(.bottom, 10)
            .buttonStyle(LevelButtonStyle())
            
            NavigationLink(destination: GameView(difficulty: "CHALLENGING", timeRemaining: 120.00, totalSquares: 64)) {
                Text("CHALLENGING")
            }
            .padding(.bottom, 10)
            .buttonStyle(LevelButtonStyle())
            NavigationLink(destination: GameView(difficulty: "HARDCHORD", timeRemaining: 150.00, totalSquares: 100)) {
                Text("HARDCHORD")
            }
            .disabled(!isHardChordEnabled)
            .buttonStyle(LevelButtonStyle())
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

struct Previews_LevelSelectView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
