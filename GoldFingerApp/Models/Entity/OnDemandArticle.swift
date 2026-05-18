struct OnDemandArticle: Codable, Identifiable {
    let id: String
    let prefix: String
    let title: String
    let datetime: String
    let money: String

    enum CodingKeys: String, CodingKey {
        case id       = "n_id"
        case prefix   = "n_perfix"
        case title    = "n_title"
        case datetime = "n_editime"
        case money    = "n_money"
    }
}
