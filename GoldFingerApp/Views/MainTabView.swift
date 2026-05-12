import SwiftUI

struct MainTabView: View {
    let user: User

    init(user: User) {
        self.user = user
        // 设置底部导航栏样式为深色
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.12, alpha: 1)

        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = UIColor.white.withAlphaComponent(0.4)
        itemAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.4)
        ]
        appearance.stackedLayoutAppearance = itemAppearance

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            // 首页
            NavigationStack {
                HomeView(user: user)
            }
            .tabItem {
                Label("首页", systemImage: "house.fill")
            }

            // 赛事中心（暂无交互）
            NavigationStack {
                placeholderView(title: "赛事中心", icon: "calendar")
            }
            .tabItem {
                Label("赛事中心", systemImage: "calendar")
            }

            // 我的订阅（暂无交互）
            NavigationStack {
                placeholderView(title: "我的订阅", icon: "star.fill")
            }
            .tabItem {
                Label("我的订阅", systemImage: "star")
            }

            // 个人中心
            NavigationStack {
                AccountView(user: user)
            }
            .tabItem {
                Label("个人中心", systemImage: "person.fill")
            }
        }
        .tint(.yellow)
    }

    @ViewBuilder
    private func placeholderView(title: String, icon: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundStyle(.white.opacity(0.2))
            Text(title)
                .font(.headline)
                .foregroundStyle(.white.opacity(0.3))
            Text("敬请期待")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.2))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.08, green: 0.08, blue: 0.10).ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.yellow)
            }
        }
    }
}

#Preview {
    MainTabView(user: User(uid: 1, username: "测试用户"))
}
