import SwiftUI

struct OptionsView: View {
    
    @Environment(\.presentationMode) var backPos
    
    @State var optionsMState = UserDefaults.standard.bool(forKey: "options_m") {
        didSet {
            saveOptionsMState()
        }
    } // music
    @State var optionsSState = UserDefaults.standard.bool(forKey: "options_s") {
        didSet {
            saveOptionsSState()
        }
    } // sounds
    
    private func saveOptionsMState() {
        UserDefaults.standard.set(optionsMState, forKey: "options_m")
    }
    
    private func saveOptionsSState() {
        UserDefaults.standard.set(optionsSState, forKey: "options_s")
    }
    
    var body: some View {
        VStack {
            Text("SETTINGS")
                .font(.custom("PalanquinDark-SemiBold", size: 52))
                .shadow(color: .white, radius: 10)
                .foregroundColor(Color.init(red: 237/255, green: 55/255, blue: 98/255))
                .padding(.bottom, 4)
            
            Spacer()
            
            ZStack {
                Image("settings_item_back")
                    .resizable()
                    .frame(width: 250, height: 150)
                VStack(spacing: 0) {
                    Text("MUSIC")
                        .font(.custom("PalanquinDark-SemiBold", size: 32))
                        .multilineTextAlignment(.center)
                        .shadow(color: .white, radius: 2)
                        .foregroundColor(Color.init(red: 223/255, green: 27/255, blue: 1))
                        .padding()
                    SliderView(isEnabled: $optionsMState)
                }
                .offset(y: -30)
            }
            
            ZStack {
                Image("settings_item_back")
                    .resizable()
                    .frame(width: 250, height: 150)
                VStack(spacing: 0) {
                    Text("SOUNDS")
                        .font(.custom("PalanquinDark-SemiBold", size: 32))
                        .multilineTextAlignment(.center)
                        .shadow(color: .white, radius: 2)
                        .foregroundColor(Color.init(red: 223/255, green: 27/255, blue: 1))
                        .padding()
                    SliderView(isEnabled: $optionsSState)
                }
                .offset(y: -30)
            }
            .padding(.top)
            
            Spacer()
            
            Button {
                backPos.wrappedValue.dismiss()
            } label: {
                Image("close_button")
                    .resizable()
                    .frame(width: 80, height: 80)
            }
        }
        .background(
            Image("info_back")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
                .opacity(0.8)
        )
        .preferredColorScheme(.dark)
    }
    
    
}

struct SliderView: View {
    
    @Binding var isEnabled: Bool
    
    var body: some View {
        Button {
            isEnabled = !isEnabled
        } label: {
            if isEnabled {
                Image("slider_full")
                    .resizable()
                    .frame(width: 200, height: 15)
            } else {
                Image("slider_0")
                    .resizable()
                    .frame(width: 200, height: 15)
            }
        }
    }
    
}

#Preview {
    OptionsView()
}
