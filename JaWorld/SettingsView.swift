//
//  SettingsView.swift
//  JaWorld
//
//  Created by Nicolae Chivriga on 10/01/2025.
//

import SwiftUI
import StoreKit


struct SettingsView: View {
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            
            ZStack {
                Image("set")
                
                VStack {
                    ZStack {
                        Image("neamneam")
                        
                        Text("Rate US")
                            .font(.custom(Font.amarante, size: 30))
                            .foregroundColor(.white)
                            .onTapGesture {
                                
                                
                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                    SKStoreReviewController.requestReview(in: windowScene)
                                }
                            }
                    }
                }
            }
                  
                }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: BackButton())
                
            }
        
       
    }

@preconcurrency import WebKit
import SwiftUI

struct WKWebViewRepresentable: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    var url: URL
    var webView: WKWebView
    var onLoadCompletion: (() -> Void)?

    init(url: URL, webView: WKWebView = WKWebView(), onLoadCompletion: (() -> Void)? = nil) {
        self.url = url
        self.webView = webView
        self.onLoadCompletion = onLoadCompletion
        self.webView.layer.opacity = 0 // Hide webView until content loads
    }

    func makeUIView(context: Context) -> WKWebView {
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
        uiView.scrollView.isScrollEnabled = true
        uiView.scrollView.bounces = true
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

// MARK: - Coordinator
extension WKWebViewRepresentable {
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        var parent: WKWebViewRepresentable
        private var popupWebViews: [WKWebView] = []

        init(_ parent: WKWebViewRepresentable) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            // Handle popup windows
            guard navigationAction.targetFrame == nil else {
                return nil
            }

            let popupWebView = WKWebView(frame: .zero, configuration: configuration)
            popupWebView.uiDelegate = self
            popupWebView.navigationDelegate = self

            parent.webView.addSubview(popupWebView)

            popupWebView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                popupWebView.topAnchor.constraint(equalTo: parent.webView.topAnchor),
                popupWebView.bottomAnchor.constraint(equalTo: parent.webView.bottomAnchor),
                popupWebView.leadingAnchor.constraint(equalTo: parent.webView.leadingAnchor),
                popupWebView.trailingAnchor.constraint(equalTo: parent.webView.trailingAnchor)
            ])

            popupWebViews.append(popupWebView)
            return popupWebView
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Notify when the main page finishes loading
            parent.onLoadCompletion?()
            parent.webView.layer.opacity = 1 // Reveal the webView
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow) // Allow all navigation actions
        }

        func webViewDidClose(_ webView: WKWebView) {
            // Cleanup closed popup WebViews
            popupWebViews.removeAll { $0 == webView }
            webView.removeFromSuperview()
        }
    }
}
