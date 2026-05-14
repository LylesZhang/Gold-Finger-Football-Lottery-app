import SwiftUI
import Combine

// 中奖喜报数据模型
struct WinnerRecord: Identifiable {
    let id = UUID()
    let tag: String      // 分类标签，如 [喜报] [足彩]
    let title: String    // 标题内容
    let date: String     // 日期，如 05-08
    let isNew: Bool
}

// 大神专家数据模型
struct Expert: Identifiable {
    let id = UUID()
    let name: String
    let title: String       // 职称，如 "《足彩金手指》首席编辑"
    let hitRate: String     // 命中率，如 "33%"
    let latestTip: String   // 最新推荐内容
    let publishTime: String // 发布时间，如 "05-13 10:05"
    let price: String       // 价格，如 "0宝" "38宝"
    let avatarImage: String // 头像图片名（Assets 里的名字）
}

struct HomeView: View {
    let user: User

    @State private var currentBanner = 0
    private let bannerImages = ["announcement1", "announcement2", "announcement3"]
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    // 中奖喜报模拟数据
    private let winners: [WinnerRecord] = [
        WinnerRecord(tag: "[足彩]", title: "2025/26赛季五大联赛积分榜（截至1月28日）", date: "05-08", isNew: true),
        WinnerRecord(tag: "[喜报]", title: "编辑曹明3串1连续过关",                     date: "05-08", isNew: false),
        WinnerRecord(tag: "[喜报]", title: "编辑曹明周二出手3串1过关",                 date: "05-06", isNew: false),
        WinnerRecord(tag: "[喜报]", title: "《欧数据对比值》错失500万大奖",            date: "05-05", isNew: false),
        WinnerRecord(tag: "[喜报]", title: "《埃罗指数》命中周日近70万大奖",           date: "04-21", isNew: false)
    ]

    // 演武厅大神模拟数据
    private let experts: [Expert] = [
        Expert(name: "冷刀",     title: "《足彩金手指》首席编辑",       hitRate: "33%", latestTip: "[足彩]：防客出现反复，比利亚平优先",         publishTime: "05-13 10:05", price: "0宝",  avatarImage: "admin_gc"),
        Expert(name: "晓万水宝", title: "《足彩金手指》特约编辑",       hitRate: "50%", latestTip: "[足彩]：主场强队状态回暖，本轮稳拿",         publishTime: "05-13 09:30", price: "28宝", avatarImage: "admin_xwsb"),
        Expert(name: "李林",     title: "《足彩金手指》资深编辑",       hitRate: "58%", latestTip: "[竞足]：欧联收官战，强队主场把握大",         publishTime: "05-12 18:45", price: "18宝", avatarImage: "admin_ll"),
        Expert(name: "所罗门",   title: "《足彩金手指》数据分析师",     hitRate: "62%", latestTip: "[足彩]：数据支撑下，客队翻盘概率极低",       publishTime: "05-12 16:20", price: "38宝", avatarImage: "admin_lmj"),
        Expert(name: "曹明",     title: "《足彩金手指》编辑",           hitRate: "55%", latestTip: "[足彩]：3串1连续过关，今日继续出手",         publishTime: "05-13 11:30", price: "0宝",  avatarImage: "admin_cm"),
        Expert(name: "吴建华",   title: "《足彩金手指》资深编辑",       hitRate: "67%", latestTip: "[足彩]：冷门赛段11连红难得，难点简化",       publishTime: "05-13 13:17", price: "38宝", avatarImage: "admin_wjh"),
        Expert(name: "鬼手",     title: "《足彩金手指》特约分析师",     hitRate: "60%", latestTip: "[竞足]：意甲收官，榜首之争尘埃未定",         publishTime: "05-11 20:00", price: "28宝", avatarImage: "admin_gs"),
        Expert(name: "下盘奇人", title: "王牌栏目《让球指数》创立者",   hitRate: "65%", latestTip: "[足彩]：让球指数异动，主队水位飞涨",         publishTime: "05-10 14:00", price: "48宝", avatarImage: "admin_xpqr"),
        Expert(name: "临风",     title: "王牌栏目《盈亏指数》创立者",   hitRate: "67%", latestTip: "[竞足]：大黄蜂状态萎靡，让步连降还能反弹？", publishTime: "05-08 18:03", price: "0宝",  avatarImage: "admin_zlp"),
        Expert(name: "十年一剑", title: "《足彩金手指》资深编辑",       hitRate: "56%", latestTip: "[足彩]：西甲末轮，保级队背水一战",           publishTime: "05-09 10:15", price: "18宝", avatarImage: "admin_snyj"),
        Expert(name: "英系小王子", title: "英超专题分析师",              hitRate: "61%", latestTip: "[竞足]：英超豪门压轴战，主场优势明显",       publishTime: "05-08 09:00", price: "28宝", avatarImage: "admin_yxxwz"),
        Expert(name: "高飞",     title: "《足彩金手指》编辑",           hitRate: "52%", latestTip: "[足彩]：德甲最后一轮，争冠热门不容有失",     publishTime: "05-07 15:30", price: "0宝",  avatarImage: "admin_pkzm"),
        Expert(name: "波哥",     title: "《足彩金手指》资深编辑",       hitRate: "59%", latestTip: "[竞足]：法甲降级区混战，冷门出没请注意",     publishTime: "05-07 11:00", price: "18宝", avatarImage: "admin_bgkzc"),
        Expert(name: "三水",     title: "足彩金手指资深编辑",           hitRate: "33%", latestTip: "[竞足]：聚焦法德崩终对决，此名利市",          publishTime: "05-07 09:30", price: "18宝", avatarImage: "admin_ss"),
        Expert(name: "威廉王子", title: "《足彩金手指》特约编辑",       hitRate: "54%", latestTip: "[足彩]：欧冠决赛周边赛事，关注焦点转移效应", publishTime: "05-06 20:00", price: "38宝", avatarImage: "admin_wlwz")
    ]


    var body: some View {
        VStack(spacing: 0) {
            topBar
            announcementBar
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    winnersSection
                    expertsSection
                }
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .background(Color("AppBackground").ignoresSafeArea())
        .navigationBarHidden(true)
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
                Button(action: {}) {
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
            TabView(selection: $currentBanner) {
                ForEach(bannerImages.indices, id: \.self) { index in
                    Image(bannerImages[index])
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
                ForEach(bannerImages.indices, id: \.self) { index in
                    Circle()
                        .fill(currentBanner == index ? Color.yellow : Color.white.opacity(0.5))
                        .frame(width: currentBanner == index ? 8 : 6,
                               height: currentBanner == index ? 8 : 6)
                        .animation(.easeInOut(duration: 0.2), value: currentBanner)
                }
            }
            .padding(.bottom, 10)
        }
        .onReceive(timer) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                currentBanner = (currentBanner + 1) % bannerImages.count
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
            ForEach(Array(winners.enumerated()), id: \.element.id) { index, winner in
                VStack(spacing: 0) {
                    HStack(alignment: .center, spacing: 6) {
                        // 左侧：标签 + 标题
                        HStack(spacing: 4) {
                            Text(winner.tag)
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(.yellow)
                            Text(winner.title)
                                .font(.system(size: 13))
                                .foregroundStyle(Color("AppTextSecondary"))
                                .lineLimit(1)
                            if winner.isNew {
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
                        // 右侧：日期
                        Text(winner.date)
                            .font(.system(size: 12))
                            .foregroundStyle(Color("AppTextSecondary"))
                            .fixedSize()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 11)

                    if index < winners.count - 1 {
                        Divider()
                            .background(Color("AppDivider"))
                            .padding(.horizontal, 16)
                    }
                }
            }

            Divider()
                .background(Color("AppInputBackground"))

            // 查看更多
            Button(action: {}) {
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
        ZStack {
            Circle()
                .fill(Color("AppInputBackground"))
                .frame(width: 56, height: 56)
            if UIImage(named: expert.avatarImage) != nil {
                Image(expert.avatarImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.fill")
                    .font(.system(size: 26))
                    .foregroundStyle(Color("AppTextSecondary"))
            }
        }
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
            Text(expert.latestTip)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color("AppTextPrimary"))
                .lineLimit(2)

            // 底部：发布时间 + 价格
            HStack {
                Text("发布时间：\(expert.publishTime)")
                    .font(.system(size: 11))
                    .foregroundStyle(Color("AppTextSecondary"))
                Spacer()
                Text(expert.price)
                    .font(.system(size: 12, weight: .bold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(expert.price == "0宝" ? Color("AppInputBackground") : Color.yellow)
                    .foregroundStyle(expert.price == "0宝" ? Color("AppTextSecondary") : Color.black)
                    .cornerRadius(6)
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
