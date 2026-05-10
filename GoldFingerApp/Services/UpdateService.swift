import Foundation

// 对应服务器 version.json 的数据模型
struct AppVersion: Codable {
    let version: String
    let downloadUrl: String
    let releaseNotes: String

    enum CodingKeys: String, CodingKey {
        case version
        case downloadUrl = "download_url"
        case releaseNotes = "release_notes"
    }
}

class UpdateService {
    // 单例，整个 App 只用这一个实例
    static let shared = UpdateService()

    // 服务器地址
    private let serverURL = "http://localhost:8080/version.json"

    // 读取 App 当前版本号（从 Info.plist 自动获取）
    var currentVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    // 请求服务器，拿到版本信息后通过 completion 返回
    func checkForUpdate(completion: @escaping (AppVersion?) -> Void) {
        guard let url = URL(string: serverURL) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let appVersion = try? JSONDecoder().decode(AppVersion.self, from: data)
            completion(appVersion)
        }.resume()
    }

    // 比较版本号：服务器版本是否比当前版本更新
    func isNewerVersion(_ serverVersion: String, than currentVersion: String) -> Bool {
        let serverParts = serverVersion.split(separator: ".").compactMap { Int($0) }
        let currentParts = currentVersion.split(separator: ".").compactMap { Int($0) }

        let maxLength = max(serverParts.count, currentParts.count)

        for i in 0..<maxLength {
            let serverNum = i < serverParts.count ? serverParts[i] : 0
            let currentNum = i < currentParts.count ? currentParts[i] : 0

            if serverNum > currentNum { return true }
            if serverNum < currentNum { return false }
        }
        return false
    }
}
