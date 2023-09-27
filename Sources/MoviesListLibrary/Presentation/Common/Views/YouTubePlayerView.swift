import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    
    let videoUrl: URL?
    
    func makeUIView(context: Context) ->  WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let videoUrl = videoUrl else { return }
        
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: videoUrl))
    }
}
