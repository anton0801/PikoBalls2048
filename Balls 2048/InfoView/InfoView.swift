import SwiftUI

struct InfoView: View {
    
    @Environment(\.presentationMode) var backPos
    
    var body: some View {
        VStack {
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

#Preview {
    InfoView()
}
