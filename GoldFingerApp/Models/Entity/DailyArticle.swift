struct DailyArticle: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let categoryName: String
    let type: String
    let period: String
    let addtime: String
    let isPaid: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case categoryName = "gp_name"
        case type         = "gn"
        case period       = "gn_sfc"
        case addtime
        case isPaid       = "gn_fp"
    }
}
