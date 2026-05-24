import SwiftUI

struct AboutView: View {
    var body: some View {
        ArticleWebView(html: wrapHtml(aboutHtml))
            .ignoresSafeArea(edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("关于我们")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.yellow)
                }
            }
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
            line-height: 1.8;
            padding: 16px;
            margin: 0;
          }
          p { margin: 0 0 14px; }
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

private let aboutHtml = """
<p>买彩网，前身为第一彩票网，自2003年2月至今，已经走过了十多年的发展历程，从起初的"第一彩票网"，到目前页面发展到现在"买彩网"，提供专业彩票资讯分析的专业网站，本地专业的精神不断完善买彩网。</p>
<p>本网站主要提供《足彩金手指》、《彩票指南》两份彩票纸媒的电子版，而在2010年4月份推出的"金手指日报"得到全国和众多足彩、竞彩爱好者的追捧。</p>
<p>中国彩票全方位服务彩民的宗旨贯穿整个网站，最大程度方便了广大彩民的全方位赛事资讯需求，论坛社区各类高手荟萃，以技术和彩民为主，形成良好的交流氛围。</p>
<p>新的买彩网在原来基础上做了更多的改进，界面更快，内容更丰富。这年来始终以引领彩票信息未来发展趋势、满足客户需求为基础，竭诚为各位彩民提供多方面的分析、推介等资讯服务。</p>
<p>客服电话：028-84399900 , 15388265142</p>
"""
