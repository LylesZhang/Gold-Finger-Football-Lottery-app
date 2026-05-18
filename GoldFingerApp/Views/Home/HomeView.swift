import SwiftUI
import Combine
import Kingfisher

struct HomeView: View {
    let user: User
    var switchToAccount: () -> Void = {}

    @State private var currentBanner = 0
    @State private var banners: [Announcement] = []
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    @State private var winners: [OnDemandArticle] = []
    @State private var experts: [Expert] = []


    var body: some View {
        VStack(spacing: 0) {
            topBar
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    announcementBar
                    winnersSection
                    expertsSection
                }
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .background(Color("AppBackground").ignoresSafeArea())
        .navigationBarHidden(true)
        .task {
            do {
                banners = try await UserService.shares.getBanners()
            } catch {}
            do {
                winners = try await UserService.shares.getOnDemandArticles(newsId: 321)
            } catch {}
            do {
                experts = try await UserService.shares.getExperts()
            } catch {}
        }
    }

    // MARK: - 顶部导航栏
    private var topBar: some View {
        HStack {
            HStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            colors: [.yellow, .orange],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 34, height: 34)
                    Image(systemName: "star.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(.black)
                }
                Text("足坛金手指")
                    .font(.system(size: 20, weight: .heavy))
                    .foregroundStyle(Color("AppTextPrimary"))
            }
            Spacer()
            HStack(spacing: 20) {
                Button(action: {}) {
                    ZStack(alignment: .topTrailing) {
                        Image(systemName: "bell.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(Color("AppTextPrimary"))
                        Circle()
                            .fill(.red)
                            .frame(width: 8, height: 8)
                            .offset(x: 2, y: -2)
                    }
                }
                Button(action: switchToAccount) {
                    Image(systemName: "person.circle")
                        .font(.system(size: 22))
                        .foregroundStyle(Color("AppTextPrimary"))
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }

    // MARK: - 轮播图
    private var announcementBar: some View {
        ZStack(alignment: .bottom) {
            if banners.isEmpty {
                // 加载中占位
                Rectangle()
                    .fill(Color("AppInputBackground"))
                    .frame(height: 160)
                    .overlay(ProgressView().tint(.yellow))
            } else {
                TabView(selection: $currentBanner) {
                    ForEach(banners.indices, id: \.self) { index in
                        KFImage(URL(string: banners[index].image))
                            .placeholder {
                                Rectangle()
                                    .fill(Color("AppInputBackground"))
                                    .overlay(ProgressView().tint(.yellow))
                            }
                            .resizable()
                            .scaledToFill()
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 160)
                .clipped()

                // 底部小圆点指示器
                HStack(spacing: 6) {
                    ForEach(banners.indices, id: \.self) { index in
                        Circle()
                            .fill(currentBanner == index ? Color.yellow : Color.white.opacity(0.5))
                            .frame(width: currentBanner == index ? 8 : 6,
                                   height: currentBanner == index ? 8 : 6)
                            .animation(.easeInOut(duration: 0.2), value: currentBanner)
                    }
                }
                .padding(.bottom, 10)
            }
        }
        .onReceive(timer) { _ in
            guard !banners.isEmpty else { return }
            withAnimation(.easeInOut(duration: 0.5)) {
                currentBanner = (currentBanner + 1) % banners.count
            }
        }
    }

    // MARK: - 重磅喜报
    private var winnersSection: some View {
        VStack(spacing: 0) {
            // 标题行
            HStack(spacing: 8) {
                Image(systemName: "trophy.fill")
                    .foregroundStyle(.yellow)
                    .font(.system(size: 15))
                Text("重磅喜报")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color("AppTextPrimary"))
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)

            Divider()
                .background(Color("AppInputBackground"))

            // 喜报列表
            let today = String(Date().description.prefix(10))
            ForEach(Array(winners.prefix(5).enumerated()), id: \.element.id) { index, article in
                VStack(spacing: 0) {
                    HStack(alignment: .center, spacing: 6) {
                        HStack(spacing: 4) {
                            Text("[\(article.prefix)]")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(.yellow)
                            Text(article.title)
                                .font(.system(size: 13))
                                .foregroundStyle(Color("AppTextSecondary"))
                                .lineLimit(1)
                            if article.datetime.hasPrefix(today) {
                                Text("NEW")
                                    .font(.system(size: 9, weight: .bold))
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 2)
                                    .background(Color.red)
                                    .foregroundStyle(Color("AppTextPrimary"))
                                    .cornerRadius(4)
                            }
                        }
                        Spacer()
                        Text(String(article.datetime.dropFirst(5).prefix(5)))
                            .font(.system(size: 12))
                            .foregroundStyle(Color("AppTextSecondary"))
                            .fixedSize()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 11)

                    if index < min(winners.count, 5) - 1 {
                        Divider()
                            .background(Color("AppDivider"))
                            .padding(.horizontal, 16)
                    }
                }
            }

            Divider()
                .background(Color("AppInputBackground"))

            // 查看更多
            NavigationLink(destination: OnDemandView()) {
                Text("更多 >")
                    .font(.system(size: 13))
                    .foregroundStyle(.yellow)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("AppCard"))
        )
        .padding(.horizontal, 16)
    }

    // MARK: - 演武厅
    private var expertsSection: some View {
        VStack(spacing: 12) {
            // 标题行
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "bolt.fill")
                        .foregroundStyle(.yellow)
                        .font(.system(size: 14))
                    Text("演武厅")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color("AppTextPrimary"))
                }
                Spacer()
                Button(action: {}) {
                    Text("更多大神 >")
                        .font(.system(size: 13))
                        .foregroundStyle(.yellow)
                }
            }
            .padding(.horizontal, 16)

            // 头像 3行4列 网格
            let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 4)
            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(experts.prefix(12)) { expert in
                    VStack(spacing: 6) {
                        expertAvatar(expert)
                        Text(expert.name)
                            .font(.system(size: 11))
                            .foregroundStyle(Color("AppTextSecondary"))
                            .lineLimit(1)
                    }
                }
            }
            .padding(.horizontal, 16)

            // 推荐卡片列表
            VStack(spacing: 10) {
                ForEach(experts) { expert in
                    expertCard(expert)
                }
            }
            .padding(.horizontal, 16)
        }
    }

    // 头像视图
    private func expertAvatar(_ expert: Expert) -> some View {
        KFImage(URL(string: expert.avatarURL))
            .placeholder {
                ZStack {
                    Circle()
                        .fill(Color("AppInputBackground"))
                    Image(systemName: "person.fill")
                        .font(.system(size: 26))
                        .foregroundStyle(Color("AppTextSecondary"))
                }
            }
            .resizable()
            .scaledToFill()
            .frame(width: 56, height: 56)
            .clipShape(Circle())
    }

    // 推荐卡片
    private func expertCard(_ expert: Expert) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            // 顶部：头像 + 名字 + 职称 + 命中率
            HStack(alignment: .top) {
                expertAvatar(expert)
                VStack(alignment: .leading, spacing: 3) {
                    Text(expert.name)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(Color("AppTextPrimary"))
                    Text(expert.title)
                        .font(.system(size: 11))
                        .foregroundStyle(Color("AppTextSecondary"))
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text(expert.hitRate)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.yellow)
                    Text("命中率")
                        .font(.system(size: 11))
                        .foregroundStyle(Color("AppTextSecondary"))
                }
            }

            // 推荐内容
            Text("[\(expert.prefix)]：\(expert.latestTip)")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color("AppTextPrimary"))
                .lineLimit(2)

            // 底部：发布时间 + 价格
            HStack {
                Text("发布时间：\(expert.publishTime)")
                    .font(.system(size: 11))
                    .foregroundStyle(Color("AppTextSecondary"))
                Spacer()
                PriceTag(raw: expert.price)
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color("AppCard"))
        )
    }

}

#Preview {
    HomeView(user: User(uid: 1, username: "测试用户"))
}
