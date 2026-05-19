import SwiftUI

struct DailyView: View {

    @State private var articles: [DailyArticle] = []
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 0) {
            if isLoading {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                Spacer()
            } else if articles.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Image(systemName: "newspaper")
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
                Text("金手指日报")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.yellow)
            }
        }
        .task {
            isLoading = true
            do {
                articles = try await UserService.shares.getDailyArticles()
            } catch {
                print("金手指日报拉取失败: \(error)")
            }
            isLoading = false
        }
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
        DailyView()
    }
}
