import SwiftUI
import SpriteKit

struct BallsGameView2048: View {
    
    @Environment(\.presentationMode) var backMode
    @State var currentView: String = ""
    
    var body: some View {
        ZStack {
            SpriteView(scene: BallsGame2048Scene())
                .ignoresSafeArea()
            
            switch (currentView) {
            case "pause":
                pauseView
            case "game_over":
                gameOverView
            default:
                EmptyView()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("SHOW_PAUSE_VIEW")), perform: { _ in
            currentView = "pause"
        })
    }
    
    private var gameOverView: some View {
        VStack {
            Spacer()
            Text("INFO")
                .font(.custom("PalanquinDark-SemiBold", size: 52))
                .shadow(color: .white, radius: 10)
                .foregroundColor(Color.init(red: 237/255, green: 55/255, blue: 98/255))
                .padding(.bottom, 4)
            
            Spacer()
            
            Text("Connect identical balls to gain points when they combine. After they combine they will turn into more. Try to connect 12 balls within the same field to win.")
                .font(.custom("PalanquinDark-SemiBold", size: 26))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.init(red: 223/255, green: 27/255, blue: 1))
                .padding(.bottom, 4)
                .padding()
            
            Spacer()
            
            HStack {
                Spacer()
                Button {
                    backMode.wrappedValue.dismiss()
                } label: {
                    Image("ic_menu")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
                Spacer().frame(width: 42)
                Button {
                    NotificationCenter.default.post(name: Notification.Name("RESTART_GAME_BALLS"), object: nil)
                    withAnimation {
                        currentView = "game"
                    }
                } label: {
                    Image("restart_game")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
                Spacer()
            }
            Button {
                backMode.wrappedValue.dismiss()
            } label: {
                Image("close_button")
                    .resizable()
                    .frame(width: 80, height: 80)
            }
            Spacer()
        }
        .background(
            Image("blur_view")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
                .opacity(0.8)
        )
    }
    
    private var pauseView: some View {
        VStack {
            Spacer()
            Text("PAUSE")
                .font(.custom("PalanquinDark-SemiBold", size: 52))
                .shadow(color: .white, radius: 10)
                .foregroundColor(Color.init(red: 237/255, green: 55/255, blue: 98/255))
                .padding(.bottom, 4)
            
            Spacer()
            
            HStack {
                Spacer()
                Button {
                    NotificationCenter.default.post(name: Notification.Name("CONTINUE_GAME_BALLS"), object: nil)
                    withAnimation {
                        currentView = "game"
                    }
                } label: {
                    Image("ic_menu")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
                Spacer().frame(width: 42)
                Button {
                    NotificationCenter.default.post(name: Notification.Name("RESTART_GAME_BALLS"), object: nil)
                    withAnimation {
                        currentView = "game"
                    }
                } label: {
                    Image("restart_game")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
                Spacer()
            }
            Button {
                backMode.wrappedValue.dismiss()
            } label: {
                Image("close_button")
                    .resizable()
                    .frame(width: 80, height: 80)
            }
            Spacer()
        }
        .background(
            Image("blur_view")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
                .opacity(0.8)
        )
    }
    
}

#Preview {
    BallsGameView2048()
}
