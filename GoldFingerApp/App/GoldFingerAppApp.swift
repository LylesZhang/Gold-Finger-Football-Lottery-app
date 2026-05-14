import SwiftUI

@main
struct GoldFingerAppApp: App {
    @State private var showUpdateAlert = false
    @State private var updateInfo: AppVersion? = nil
    @State private var loggedInUser: User? = nil
    @AppStorage("prefersDarkMode") private var prefersDarkMode: Bool = true

    var body: some Scene {
        WindowGroup {
            Group {
                if let user = loggedInUser {
                    // 登录成功后，直接替换成 MainTabView，不走 NavigationStack push
                    MainTabView(user: user)
                } else {
                    LoginView(onLogin: { user in
                        loggedInUser = user
                    })
                    .onAppear {
                        checkForUpdate()
                    }
                    .alert("发现新版本", isPresented: $showUpdateAlert, presenting: updateInfo) { info in
                        Button("立即更新") {
                            if let url = URL(string: info.downloadUrl) {
                                UIApplication.shared.open(url)
                            }
                        }
                        Button("稍后再说", role: .cancel) {}
                    } message: { info in
                        Text("最新版本：\(info.version)\n\(info.releaseNotes)")
                    }
                }
            }
            .preferredColorScheme(prefersDarkMode ? .dark : .light)
        }
    }

    func checkForUpdate() {
        let service = UpdateService.shared
        service.checkForUpdate { appVersion in
            guard let appVersion = appVersion else { return }
            if service.isNewerVersion(appVersion.version, than: service.currentVersion) {
                DispatchQueue.main.async {
                    updateInfo = appVersion
                    showUpdateAlert = true
                }
            }
        }
    }
}
