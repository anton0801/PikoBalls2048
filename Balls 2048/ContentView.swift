import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: OptionsView()
                        .navigationBarBackButtonHidden(true)) {
                        Image("ic_options")
                            .resizable()
                            .frame(width: 80, height: 80)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: BestRecordView()
                        .navigationBarBackButtonHidden(true)) {
                        Image("ic_records")
                            .resizable()
                            .frame(width: 80, height: 80)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: InfoView()
                        .navigationBarBackButtonHidden(true)) {
                        Image("ic_info")
                            .resizable()
                            .frame(width: 80, height: 80)
                    }
                    Spacer()
                }
                
                Spacer()
                
                Image("ball_icon")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                Spacer()
                
                NavigationLink(destination: BallsGameView2048()
                    .navigationBarBackButtonHidden(true)) {
                    ZStack {
                        Image("button_background")
                            .resizable()
                            .frame(width: 250, height: 120)
                        Text("PLAY")
                            .font(.custom("PalanquinDark-SemiBold", size: 52))
                            .shadow(color: .white, radius: 10)
                            .foregroundColor(Color.init(red: 202/255, green: 53/255, blue: 1))
                            .padding(.bottom, 4)
                    }
                }
            }
            .background(
                Image("menu_background")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
}
