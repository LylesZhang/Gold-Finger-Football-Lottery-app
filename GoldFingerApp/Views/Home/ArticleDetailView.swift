import SwiftUI
import WebKit

enum ArticleSource {
    case onDemand   // 点播，用 new_getnews
    case daily      // 金手指日报，用 getGdNewsInfo2
}

struct ArticleDetailView: View {
    let articleId: String
    let title: String
    let jmck: String?
    var source: ArticleSource = .onDemand

    @State private var htmlContent: String? = nil
    @State private var isLoading = true
    @State private var errorMessage: String? = nil

    var body: some View {
        ZStack {
            Color("AppBackground").ignoresSafeArea()

            if isLoading {
                VStack(spacing: 14) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                        .scaleEffect(1.2)
                    Text("加载中...")
                        .font(.system(size: 13))
                        .foregroundStyle(Color("AppTextSecondary"))
                }
            } else if let error = errorMessage {
                VStack(spacing: 14) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 36))
                        .foregroundStyle(.yellow)
                    Text(error)
                        .font(.subheadline)
                        .foregroundStyle(Color("AppTextSecondary"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
            } else if let html = htmlContent {
                ArticleWebView(html: html)
                    .ignoresSafeArea(edges: .bottom)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.yellow)
                    .lineLimit(1)
            }
        }
        .task {
            await loadDetail()
        }
    }

    private func loadDetail() async {
        guard let ck = jmck, !ck.isEmpty else {
            errorMessage = "请先登录 maicai.cn 账号才能查看文章内容"
            isLoading = false
            return
        }
        do {
            let response = try await (source == .daily
                ? UserService.shares.getDailyArticleDetail(fid: articleId, jmck: ck)
                : UserService.shares.getArticleDetail(fid: articleId, jmck: ck))
            if response.status == 1, let content = response.content, !content.isEmpty {
                htmlContent = wrapHtml(content)
            } else {
                errorMessage = response.msg ?? "暂时无法获取文章内容"
            }
        } catch {
            errorMessage = "加载失败：\(error.localizedDescription)"
            print("[ArticleDetailView] error:", error)
        }
        isLoading = false
    }

    private func wrapHtml(_ body: String) -> String {
        """
        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          body {
            font-family: -apple-system, sans-serif;
            font-size: 15px;
            line-height: 1.7;
            padding: 16px;
            margin: 0;
          }
          img { max-width: 100%; height: auto; border-radius: 8px; }
          p { margin: 0 0 12px; }

          @media (prefers-color-scheme: dark) {
            body { background-color: #1a1a1e; color: #e0e0e0; }
            a { color: #FFD700; }
          }
          @media (prefers-color-scheme: light) {
            body { background-color: #ffffff; color: #1a1a1e; }
            a { color: #B8860B; }
          }
        </style>
        </head>
        <body>\(body)</body>
        </html>
        """
    }
}

// MARK: - WKWebView 包装
struct ArticleWebView: UIViewRepresentable {
    let html: String

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.loadHTMLString(html, baseURL: URL(string: "https://www.maicai.cn"))
    }
}
