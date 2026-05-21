import SwiftUI

struct DailyView: View {

    let user: User
    var switchToSubscribe: () -> Void = {}

    @State private var articles: [DailyArticle] = []
    @State private var isLoading = false
    @State private var subscriptionValid = false
    @State private var showExpiredAlert = false
    @State private var selectedArticle: DailyArticle? = nil

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
            } else if articles.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "newspaper")
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
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("金手指日报")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.yellow)
            }
        }
        .navigationDestination(item: $selectedArticle) { article in
            ArticleDetailView(articleId: article.id, title: article.title, jmck: user.jmck, source: .daily)
        }
        .alert("订阅已过期", isPresented: $showExpiredAlert) {
            Button("去订阅", role: .none) { switchToSubscribe() }
            Button("取消", role: .cancel) {}
        } message: {
            Text("金手指日报订阅已过期或未订阅，请前往「个人中心 → 订阅服务」续订后查看。")
        }
        .task {
            isLoading = true
            do {
                articles = try await UserService.shares.getDailyArticles()
            } catch {
                print("金手指日报拉取失败: \(error)")
            }
            do {
                let response = try await UserService.shares.getAllPayServices(uid: user.uid)
                let serviceList = response.servicelist ?? []
                subscriptionValid = serviceList.first(where: { $0.psServid == 41 }).map { isEndDateValid($0.enddate) } ?? false
            } catch {
                print("订阅状态拉取失败: \(error)")
            }
            isLoading = false
        }
    }

    private func handleArticleTap(_ article: DailyArticle) {
        if subscriptionValid {
            selectedArticle = article
        } else {
            showExpiredAlert = true
        }
    }

    // 判断到期日是否还未过期
    private func isEndDateValid(_ enddate: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let end = formatter.date(from: enddate) else { return false }
        return end >= Calendar.current.startOfDay(for: Date())
    }

    private func articleRow(_ article: DailyArticle) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(article.title)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color("AppTextPrimary"))
                .lineLimit(2)

            HStack(spacing: 6) {
                // 类型标签
                Text(article.type)
                    .font(.system(size: 11, weight: .semibold))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.yellow.opacity(0.15))
                    .foregroundStyle(.yellow)
                    .cornerRadius(4)

                // 分类标签
                Text(article.categoryName)
                    .font(.system(size: 11))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color("AppInputBackground"))
                    .foregroundStyle(Color("AppTextSecondary"))
                    .cornerRadius(4)

                // 期号
                if !article.period.isEmpty && article.period != "0" {
                    Text("第\(article.period)期")
                        .font(.system(size: 11))
                        .foregroundStyle(Color("AppTextTertiary"))
                }

                Spacer()

                // 发布时间
                Text(article.addtime)
                    .font(.system(size: 11))
                    .foregroundStyle(Color("AppTextTertiary"))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

#Preview {
    NavigationStack {
        DailyView(user: User(uid: 1, username: "测试用户"))
    }
}
