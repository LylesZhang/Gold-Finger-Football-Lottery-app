import SwiftUI

// 中奖喜报数据模型
struct WinnerRecord: Identifiable {
    let id = UUID()
    let name: String
    let prize: String
    let match: String
    let category: String
    let timeAgo: String
}

// 大神专家数据模型
struct Expert: Identifiable {
    let id = UUID()
    let name: String
    let rank: String
    let hitRate: String
    let winCount: Int
    let league: String
    let latestTip: String
}

struct HomeView: View {
    let user: User

    // 金手指日报服务数据（与后端 servId 对应）
    private let jinShouZhiService = ServiceGroup(
        groupName: "金手指日报",
        plans: [
            ServicePlan(servId: 41, period: "半年", money: 700,  timeType: 5),
            ServicePlan(servId: 41, period: "年度", money: 1400, timeType: 3)
        ],
        smsEnabled: false,
        intro: "《金手指日报》每日提供传统足彩、竞彩足球、竞彩篮球、北京单场，四大彩种的比赛数据、盘口、赔率分析！"
    )

    @State private var selectedPlan: ServicePlan? = nil
    @State private var navigateToService = false

    // 中奖喜报模拟数据
    private let winners: [WinnerRecord] = [
        WinnerRecord(name: "足彩大神168", prize: "¥28,600", match: "英超 曼城vs利物浦", category: "竞彩单场", timeAgo: "2小时前"),
        WinnerRecord(name: "金手指Pro",  prize: "¥15,800", match: "西甲 皇马vs巴萨",  category: "足彩专区", timeAgo: "5小时前")
    ]

    // 演武厅大神模拟数据
    private let experts: [Expert] = [
        Expert(name: "竞猜大神", rank: "传奇段位", hitRate: "89.3%", winCount: 178, league: "德甲场馆", latestTip: "德甲推荐：拜仁主场大分可期"),
        Expert(name: "足球先知", rank: "钻石段位", hitRate: "82.1%", winCount: 134, league: "英超场馆", latestTip: "英超推荐：曼城主场让球稳赢"),
        Expert(name: "彩票之王", rank: "黄金段位", hitRate: "76.5%", winCount: 98,  league: "西甲场馆", latestTip: "西甲推荐：皇马客场胜出可期")
    ]

    // 热门点播分区数据
    private let categories = [
        ("足彩单场", "单场竞彩推荐", "ticket.fill",      Color(red: 0.9, green: 0.6, blue: 0.1)),
        ("足彩专区", "专业足彩分析", "chart.bar.fill",   Color(red: 0.2, green: 0.6, blue: 0.9)),
        ("竞猜专区", "赛事竞猜推荐", "dice.fill",        Color(red: 0.8, green: 0.3, blue: 0.5)),
        ("特色足彩", "特色玩法推荐", "sparkles",         Color(red: 0.4, green: 0.8, blue: 0.4))
    ]

    var body: some View {
        VStack(spacing: 0) {
            topBar
            announcementBar
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    winnersSection
                    expertsSection
                    subscriptionCard
                    hotCategoriesSection
                }
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
        }
        .background(Color(red: 0.08, green: 0.08, blue: 0.10).ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $navigateToService) {
            ServiceView(
                group: jinShouZhiService,
                user: user,
                initialPlan: selectedPlan ?? jinShouZhiService.plans.first
            )
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
                    .foregroundStyle(.white)
            }
            Spacer()
            HStack(spacing: 20) {
                Button(action: {}) {
                    ZStack(alignment: .topTrailing) {
                        Image(systemName: "bell.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        Circle()
                            .fill(.red)
                            .frame(width: 8, height: 8)
                            .offset(x: 2, y: -2)
                    }
                }
                Button(action: {}) {
                    Image(systemName: "person.circle")
                        .font(.system(size: 22))
                        .foregroundStyle(.white)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }

    // MARK: - 公告栏
    private var announcementBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "speaker.wave.2.fill")
                .font(.system(size: 13))
                .foregroundStyle(Color(red: 0.6, green: 0.4, blue: 0.0))
            Text("凌晨2:00-4:00系统维护，期间暂停服务｜新增欧冠竞彩场次")
                .font(.system(size: 13))
                .foregroundStyle(Color(red: 0.5, green: 0.35, blue: 0.0))
                .lineLimit(1)
            Spacer()
            Button(action: {}) {
                Text("更多 >")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Color(red: 0.5, green: 0.35, blue: 0.0))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color(red: 1.0, green: 0.85, blue: 0.3))
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
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)

            Divider()
                .background(Color.white.opacity(0.08))

            // 喜报列表
            ForEach(Array(winners.enumerated()), id: \.element.id) { index, winner in
                VStack(spacing: 0) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(winner.name)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(.white)
                            Text(winner.match)
                                .font(.system(size: 13))
                                .foregroundStyle(.white.opacity(0.5))
                            Text(winner.category)
                                .font(.system(size: 12))
                                .foregroundStyle(.white.opacity(0.4))
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 4) {
                            Text(winner.prize)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.yellow)
                            Text(winner.timeAgo)
                                .font(.system(size: 12))
                                .foregroundStyle(.white.opacity(0.4))
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)

                    if index < winners.count - 1 {
                        Divider()
                            .background(Color.white.opacity(0.06))
                            .padding(.horizontal, 16)
                    }
                }
            }

            Divider()
                .background(Color.white.opacity(0.08))

            // 查看全部
            Button(action: {}) {
                HStack(spacing: 4) {
                    Text("查看全部中奖喜报")
                        .font(.system(size: 14))
                        .foregroundStyle(.yellow)
                    Image(systemName: "chevron.right")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(.yellow)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.13, green: 0.13, blue: 0.15))
        )
        .padding(.horizontal, 16)
    }

    // MARK: - 演武厅
    private var expertsSection: some View {
        VStack(spacing: 12) {
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "bolt.fill")
                        .foregroundStyle(.yellow)
                        .font(.system(size: 14))
                    Text("演武厅")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                }
                Spacer()
                Button(action: {}) {
                    Text("更多大神 >")
                        .font(.system(size: 13))
                        .foregroundStyle(.yellow)
                }
            }
            .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(experts) { expert in
                        expertCard(expert)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    private func expertCard(_ expert: Expert) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // 头像 + 名字 + 段位
            HStack(spacing: 10) {
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            colors: [.yellow, .orange],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 44, height: 44)
                    Image(systemName: "person.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                }
                VStack(alignment: .leading, spacing: 3) {
                    Text(expert.name)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.white)
                    Text(expert.rank)
                        .font(.system(size: 11))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color.yellow.opacity(0.2))
                        .foregroundStyle(.yellow)
                        .cornerRadius(4)
                }
            }

            Divider().background(Color.white.opacity(0.08))

            // 命中率 + 场次
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("命中率")
                        .font(.system(size: 11))
                        .foregroundStyle(.white.opacity(0.5))
                    HStack(spacing: 3) {
                        Text(expert.hitRate)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.white)
                        Image(systemName: "chevron.up")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(.green)
                    }
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text("中奖场次")
                        .font(.system(size: 11))
                        .foregroundStyle(.white.opacity(0.5))
                    Text("\(expert.winCount)")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)
                }
            }

            // 联赛 + 推荐
            Text(expert.league)
                .font(.system(size: 11))
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .background(Color.white.opacity(0.08))
                .foregroundStyle(.white.opacity(0.6))
                .cornerRadius(4)

            Text(expert.latestTip)
                .font(.system(size: 12))
                .foregroundStyle(.white.opacity(0.7))
                .lineLimit(1)
        }
        .padding(14)
        .frame(width: 200)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(red: 0.13, green: 0.13, blue: 0.15))
        )
    }

    // MARK: - 专属付费订阅
    private var subscriptionCard: some View {
        VStack(spacing: 0) {
            // 标题行
            HStack {
                Text("专属付费订阅")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                Spacer()
                Text("优惠优选")
                    .font(.system(size: 11, weight: .semibold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.red.opacity(0.85))
                    .foregroundStyle(.white)
                    .cornerRadius(6)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 12)

            // 服务名
            HStack {
                Image(systemName: "crown.fill")
                    .foregroundStyle(.yellow)
                    .font(.system(size: 14))
                Text(jinShouZhiService.groupName)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.yellow)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 10)

            // 功能列表
            VStack(alignment: .leading, spacing: 7) {
                ForEach([
                    "每日3-5场核心赛事深度分析",
                    "专家独家方案专享先发",
                    "历史命中率90%+高质量推荐",
                    "VIP专属推荐群资格"
                ], id: \.self) { item in
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.yellow)
                        Text(item)
                            .font(.system(size: 13))
                            .foregroundStyle(.white.opacity(0.75))
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.bottom, 14)

            Divider().background(Color.white.opacity(0.08))

            // 价格选项
            HStack(spacing: 12) {
                ForEach(jinShouZhiService.plans) { plan in
                    planOption(plan: plan)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)

            // 订阅按钮
            Button {
                selectedPlan = selectedPlan ?? jinShouZhiService.plans.first
                navigateToService = true
            } label: {
                Text("立即付费开通订阅")
                    .font(.system(size: 16, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.yellow)
                    .foregroundStyle(.black)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.13, green: 0.13, blue: 0.15))
        )
        .padding(.horizontal, 16)
    }

    private func planOption(plan: ServicePlan) -> some View {
        let isSelected = selectedPlan?.timeType == plan.timeType
        return Button {
            selectedPlan = plan
        } label: {
            VStack(spacing: 3) {
                Text(plan.period)
                    .font(.system(size: 13))
                    .foregroundStyle(isSelected ? .black : .white.opacity(0.6))
                Text("¥\(plan.money)")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(isSelected ? .black : .white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(isSelected ? Color.yellow : Color.white.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isSelected ? Color.clear : Color.white.opacity(0.1), lineWidth: 1)
                    )
            )
        }
    }

    // MARK: - 热门点播专区
    private var hotCategoriesSection: some View {
        VStack(spacing: 12) {
            HStack {
                Text("热门点播专区")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.horizontal, 16)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(categories, id: \.0) { name, subtitle, icon, color in
                    Button(action: {}) {
                        HStack(spacing: 12) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(color.opacity(0.18))
                                    .frame(width: 44, height: 44)
                                Image(systemName: icon)
                                    .font(.system(size: 20))
                                    .foregroundStyle(color)
                            }
                            VStack(alignment: .leading, spacing: 3) {
                                Text(name)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(.white)
                                Text(subtitle)
                                    .font(.system(size: 11))
                                    .foregroundStyle(.white.opacity(0.45))
                            }
                            Spacer()
                        }
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color(red: 0.13, green: 0.13, blue: 0.15))
                        )
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    HomeView(user: User(uid: 1, username: "测试用户"))
}
