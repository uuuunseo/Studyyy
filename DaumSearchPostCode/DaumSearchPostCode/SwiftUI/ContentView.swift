import SwiftUI

struct ContentView: View {
    @State var isShowingKakaoWebSheet: Bool = false
    @State var address: String = ""
    let webURL: URL? = URL(string: "https://uuuunseo.github.io/DaumWeb/")

    var body: some View {
        VStack {
            Button {
                isShowingKakaoWebSheet = true
            } label: {
                Text("주소는 : \(address)")
            }
        }
        .sheet(isPresented: $isShowingKakaoWebSheet) {
            if let url = webURL {
                KakaoPostCodeView(
                    request: URLRequest(url: url), 
                    isShowingKakaoWebSheet: $isShowingKakaoWebSheet,
                    address: $address
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
