import SwiftUI

struct OnDemandView: View {

    let user: User

    @State private var selectedTab = "tab01"
    @State private var articles: [OnDemandArticle] = []
    @State private var isLoading = false
    @State private var purchasedIds: Set<Int> = []
    @State private var navigateTo: ArticleNavTarget? = nil
    @State private var articleToBuy: PurchaseTarget? = nil

    private var currentTabNewsId: Int {
        onDemandTabs.first(where: { $0.id == selectedTab })?.newsId ?? 0
    }

    private func parsePrice(_ raw: String) -> Int {
        Int(raw.replacingOccurrences(of: "宝", with: "")) ?? 0
    }

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
            ZStack {
                Color("AppBackground")

                if isLoading {
                    VStack(spacing: 14) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                            .scaleEffect(1.2)
                        Text("加载中...")
                            .font(.system(size: 13))
                            .foregroundStyle(Color("AppTextSecondary"))
                    }
                } else if articles.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "doc.text.magnifyingglass")
                            .font(.system(size: 36))
                            .foregroundStyle(Color("AppTextTertiary"))
                        Text("暂无内容")
                            .font(.subheadline)
                            .foregroundStyle(Color("AppTextSecondary"))
                    }
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(articles) { article in
                                Button(action: { handleArticleTap(article) }) {
                                    articleRow(article)
                                }
                                .buttonStyle(.plain)
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
        .navigationDestination(item: $navigateTo) { target in
            ArticleDetailView(articleId: target.id, title: target.title, jmck: user.jmck)
        }
        .sheet(item: $articleToBuy) { target in
            ArticlePurchaseSheet(
                target: target,
                user: user,
                onSuccess: {
                    purchasedIds.insert(target.fid)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        navigateTo = ArticleNavTarget(id: "\(target.fid)", title: target.title)
                    }
                }
            )
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
        .task(id: user.uid) {
            if let ids = try? await UserService.shares.getPurchasedArticleIds(uid: user.uid) {
                purchasedIds = Set(ids)
            }
        }
    }

    private func handleArticleTap(_ article: OnDemandArticle) {
        let price = parsePrice(article.money)
        if price == 0 || purchasedIds.contains(Int(article.id) ?? -1) {
            navigateTo = ArticleNavTarget(id: article.id, title: article.title)
        } else {
            articleToBuy = PurchaseTarget(
                fid: Int(article.id) ?? 0,
                title: article.title,
                price: price,
                dId: currentTabNewsId
            )
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
                    .foregroundStyle(Color("AppTextSecondary"))
                Text(article.datetime)
                    .font(.system(size: 12))
                    .foregroundStyle(Color("AppTextSecondary"))

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
        OnDemandView(user: User(uid: 1, username: "测试用户"))
    }
}
