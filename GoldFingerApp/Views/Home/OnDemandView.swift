import SwiftUI

struct OnDemandView: View {

    @State private var selectedTab = "tab01"
    @State private var articles: [OnDemandArticle] = []
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - 顶部横向 Tab 栏
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(onDemandTabs) { tab in
                        Button(action: { selectedTab = tab.id }) {
                            VStack(spacing: 8) {
                                Text(tab.name)
                                    .font(.system(size: 14, weight: selectedTab == tab.id ? .bold : .regular))
                                    .foregroundStyle(selectedTab == tab.id ? Color("AppTextPrimary") : Color("AppTextSecondary"))
                                    .padding(.horizontal, 16)

                                Rectangle()
                                    .fill(selectedTab == tab.id ? Color.yellow : Color.clear)
                                    .frame(height: 2)
                            }
                            .padding(.top, 10)
                        }
                    }
                }
            }
            .background(Color("AppCard"))

            Divider()
                .background(Color("AppInputBackground"))

            // MARK: - 内容列表
            if isLoading {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                Spacer()
            } else if articles.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.system(size: 36))
                        .foregroundStyle(Color("AppTextTertiary"))
                    Text("暂无内容")
                        .font(.subheadline)
                        .foregroundStyle(Color("AppTextSecondary"))
                }
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(articles) { article in
                            articleRow(article)
                            Divider()
                                .background(Color("AppDivider"))
                                .padding(.horizontal, 16)
                        }
                    }
                    .padding(.top, 4)
                    .padding(.bottom, 32)
                }
            }
        }
        .background(Color("AppBackground").ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("点播")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.yellow)
            }
        }
        .task(id: selectedTab) {
            guard let tab = onDemandTabs.first(where: { $0.id == selectedTab }),
                  tab.newsId != 0 else {
                articles = []
                return
            }
            isLoading = true
            do {
                articles = try await UserService.shares.getOnDemandArticles(newsId: tab.newsId)
            } catch {
                articles = []
                print("点播列表拉取失败: \(error)")
            }
            isLoading = false
        }
    }

    // MARK: - 文章行
    private func articleRow(_ article: OnDemandArticle) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(article.title)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color("AppTextPrimary"))
                .lineLimit(2)

            HStack(spacing: 0) {
                Text("发布时间：")
                    .font(.system(size: 12))
                    .foregroundStyle(.white.opacity(0.4))
                Text(article.datetime)
                    .font(.system(size: 12))
                    .foregroundStyle(.white.opacity(0.4))

                if !article.prefix.isEmpty {
                    Text("  [\(article.prefix)]")
                        .font(.system(size: 12))
                        .foregroundStyle(.yellow.opacity(0.6))
                }

                Spacer()

                PriceTag(raw: article.money)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

#Preview {
    NavigationStack {
        OnDemandView()
    }
}
