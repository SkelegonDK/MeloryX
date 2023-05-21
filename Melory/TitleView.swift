import SwiftUI

struct TitleView: View {
    @State private var showButton = false

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 10.0) {
                Text("MELORY")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                if showButton {
                    NavigationLink(destination: LevelSelectView()) {
                        Text("Start Game")
                            .font(.title)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .transition(.scale)
                    
                }
            }
            .padding(.all, 30.0)
            .onAppear {
                withAnimation {
                    showButton = true
                }
            }
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
