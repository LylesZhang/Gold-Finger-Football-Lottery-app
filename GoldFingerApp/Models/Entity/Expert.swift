struct Expert: Codable, Identifiable {
    let id: String
    let name: String
    let title: String
    let avatarURL: String
    let hitRate: String
    let prefix: String
    let latestTip: String
    let publishTime: String
    let price: String

    enum CodingKeys: String, CodingKey {
        case id = "e_id"
        case name = "ename"
        case title = "rank"
        case avatarURL = "logo"
        case hitRate = "twohit"
        case prefix = "n_perfix"
        case latestTip = "n_title"
        case publishTime = "n_addtime"
        case price = "n_money"
    }
}
