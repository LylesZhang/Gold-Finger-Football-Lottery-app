import SwiftUI

struct MainTabView: View {
    let user: User

    init(user: User) {
        self.user = user
        // 设置底部导航栏样式为深色
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "AppTabBar") ?? UIColor(red: 0.10, green: 0.10, blue: 0.12, alpha: 1)

        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = UIColor(named: "AppTextSecondary") ?? UIColor.white.withAlphaComponent(0.4)
        itemAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(named: "AppTextSecondary") ?? UIColor.white.withAlphaComponent(0.4)
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

            // 点播
            NavigationStack {
                OnDemandView()
            }
            .tabItem {
                Label("点播", systemImage: "play.circle.fill")
            }

            // 金手指日报（暂无交互）
            NavigationStack {
                placeholderView(title: "金手指日报", icon: "newspaper.fill")
            }
            .tabItem {
                Label("金手指日报", systemImage: "newspaper.fill")
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
                .foregroundStyle(Color("AppTextTertiary"))
            Text(title)
                .font(.headline)
                .foregroundStyle(Color("AppTextTertiary"))
            Text("敬请期待")
                .font(.subheadline)
                .foregroundStyle(Color("AppTextTertiary"))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("AppBackground").ignoresSafeArea())
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
