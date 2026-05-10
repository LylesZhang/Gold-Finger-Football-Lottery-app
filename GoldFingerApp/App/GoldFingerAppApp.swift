import SwiftUI

@main
struct GoldFingerAppApp: App {
    @State private var showUpdateAlert = false
    @State private var updateInfo: AppVersion? = nil

    var body: some Scene {
        WindowGroup {
            LoginView()
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
