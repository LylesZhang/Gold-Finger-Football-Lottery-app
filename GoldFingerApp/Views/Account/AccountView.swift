import SwiftUI

// MARK: - 菜单项数据模型
private struct MenuItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
}

// MARK: - 个人中心主页
struct AccountView: View {
    let user: User

    private let section1: [MenuItem] = [
        MenuItem(icon: "star.fill",                   title: "订阅服务"),
        MenuItem(icon: "doc.text.fill",               title: "帐户明细")
    ]
    private let section2: [MenuItem] = [
        MenuItem(icon: "arrow.triangle.2.circlepath", title: "检查新版本"),
        MenuItem(icon: "bubble.left.fill",            title: "问题反馈"),
        MenuItem(icon: "gearshape.fill",              title: "设置")
    ]
    private let section3: [MenuItem] = [
        MenuItem(icon: "info.circle.fill",            title: "服务指南"),
        MenuItem(icon: "info.circle.fill",            title: "关于我们")
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {

                // MARK: 顶部导航栏
                topBar

                // MARK: 用户信息卡
                userCard
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    .padding(.bottom, 8)

                // MARK: 菜单分组
                VStack(spacing: 10) {
                    sectionGroup(section1)
                    sectionGroup(section2)
                    sectionGroup(section3)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)

                // MARK: 底部版权
                footer
            }
        }
        .background(Color("AppBackground").ignoresSafeArea())
        .navigationBarHidden(true)
    }

    // MARK: - 顶部导航栏（与首页风格一致）
    private var topBar: some View {
        HStack {
            Text("个人中心")
                .font(.system(size: 20, weight: .heavy))
                .foregroundStyle(Color("AppTextPrimary"))
            Spacer()
            Button(action: {}) {
                Image(systemName: "bell.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(Color("AppTextPrimary"))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
    }

    // MARK: - 用户信息卡
    private var userCard: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        colors: [.yellow, .orange],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 58, height: 58)
                Text(String(user.username.prefix(1)).uppercased())
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.black)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(user.username)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color("AppTextPrimary"))
                Text("UID: \(user.uid)")
                    .font(.system(size: 12))
                    .foregroundStyle(Color("AppTextSecondary"))
            }

            Spacer()

            Image(systemName: "qrcode")
                .font(.system(size: 22))
                .foregroundStyle(Color("AppTextSecondary"))
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 18)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("AppCard"))
        )
    }

    // MARK: - 菜单分组卡片
    private func sectionGroup(_ items: [MenuItem]) -> some View {
        VStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                NavigationLink(destination: destinationView(for: item.title)) {
                    menuRow(icon: item.icon, title: item.title)
                }
                .buttonStyle(.plain)

                if index < items.count - 1 {
                    Divider()
                        .background(Color("AppDivider"))
                        .padding(.leading, 52)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color("AppCard"))
        )
    }

    // MARK: - 单行菜单
    private func menuRow(icon: String, title: String) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 15))
                .foregroundStyle(.yellow.opacity(0.8))
                .frame(width: 22)

            Text(title)
                .font(.system(size: 15))
                .foregroundStyle(Color("AppTextPrimary"))

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(Color("AppTextTertiary"))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
    }

    // MARK: - 子页面路由
    @ViewBuilder
    private func destinationView(for title: String) -> some View {
        switch title {
        case "订阅服务":
            SubscriptionServiceView(user: user)
        case "设置":
            SettingsView()
        default:
            Color("AppBackground")
                .ignoresSafeArea()
                .overlay(
                    Text("敬请期待")
                        .font(.subheadline)
                        .foregroundStyle(Color("AppTextTertiary"))
                )
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - 底部版权信息
    private var footer: some View {
        VStack(spacing: 7) {
            HStack(spacing: 0) {
                Text("服务条款")
                    .foregroundStyle(.yellow.opacity(0.6))
                Text("  |  ")
                    .foregroundStyle(Color("AppTextTertiary"))
                Text("隐私政策")
                    .foregroundStyle(.yellow.opacity(0.6))
            }
            .font(.system(size: 13))

            Group {
                Text("Copyright © 2018-2026 MaiCai.CN")
                Text("客服热线：15388265142")
                Text("Author: ZhangChun")
                Text("Version: v1.2.0")
            }
            .font(.system(size: 12))
            .foregroundStyle(Color("AppTextTertiary"))
        }
        .padding(.top, 36)
        .padding(.bottom, 40)
    }
}

// MARK: - 订阅服务子页面（原账户内容）
struct SubscriptionServiceView: View {
    let user: User
    @State private var balance: Double = 0.0
    @State private var serviceList: [PayService] = []

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                // 余额卡片
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("AppCard"))
                        .shadow(color: .yellow.opacity(0.25), radius: 12, x: 0, y: 6)

                    VStack(spacing: 12) {
                        HStack {
                            Text("账户余额")
                                .font(.subheadline)
                                .foregroundStyle(.yellow.opacity(0.8))
                            Spacer()
                            Image(systemName: "creditcard.fill")
                                .foregroundStyle(.yellow.opacity(0.6))
                        }
                        HStack(alignment: .bottom, spacing: 4) {
                            Text("¥")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundStyle(.yellow.opacity(0.8))
                                .padding(.bottom, 6)
                            Text(String(format: "%.2f", balance))
                                .font(.system(size: 52, weight: .bold))
                                .foregroundStyle(.yellow)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Button("立即充值") {}
                                .font(.subheadline).fontWeight(.semibold)
                                .padding(.horizontal, 28).padding(.vertical, 10)
                                .background(Color.yellow)
                                .foregroundStyle(.black)
                                .cornerRadius(20)
                        }
                    }
                    .padding(24)
                }
                .padding(.horizontal, 20)

                // 我的订阅
                VStack(spacing: 14) {
                    HStack {
                        Text("我的订阅")
                            .font(.headline).fontWeight(.bold)
                            .foregroundStyle(Color("AppTextPrimary"))
                        Spacer()
                        NavigationLink(destination: SubscribeView(user: user)) {
                            HStack(spacing: 4) {
                                Image(systemName: "plus").font(.caption)
                                Text("订阅").font(.subheadline).fontWeight(.semibold)
                            }
                            .padding(.horizontal, 18).padding(.vertical, 8)
                            .background(Color.yellow)
                            .foregroundStyle(.black)
                            .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal, 20)

                    if serviceList.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "doc.text.magnifyingglass")
                                .font(.system(size: 36))
                                .foregroundStyle(Color("AppTextTertiary"))
                            Text("暂无订阅服务")
                                .font(.subheadline)
                                .foregroundStyle(Color("AppTextSecondary"))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                    } else {
                        ForEach(serviceList) { service in
                            HStack(spacing: 16) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.yellow.opacity(0.15))
                                        .frame(width: 48, height: 48)
                                    Image(systemName: "star.fill")
                                        .foregroundStyle(.yellow)
                                        .font(.system(size: 20))
                                }
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(service.serviceName ?? "未知服务")
                                        .font(.subheadline).fontWeight(.semibold)
                                        .foregroundStyle(Color("AppTextPrimary"))
                                    Text("有效期至：\(service.enddate)")
                                        .font(.caption)
                                        .foregroundStyle(Color("AppTextSecondary"))
                                }
                                Spacer()
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                                    .font(.system(size: 20))
                            }
                            .padding(.horizontal, 18).padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color("AppDivider"))
                            )
                            .padding(.horizontal, 20)
                        }
                    }
                }

                Spacer(minLength: 40)
            }
            .padding(.top, 20)
        }
        .background(Color("AppBackground").ignoresSafeArea())
        .navigationTitle("订阅服务")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                do {
                    let accountInfo = try await UserService.shares.getAccountinfo(username: user.username)
                    balance = accountInfo.balance ?? 0.0
                } catch { print("用户余额信息获取失败") }
                do {
                    let response = try await UserService.shares.getAllPayServices(uid: user.uid)
                    serviceList = response.servicelist ?? []
                } catch { print("订阅服务获取失败: \(error)") }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AccountView(user: User(uid: 65488, username: "ZhangChun"))
    }
}
