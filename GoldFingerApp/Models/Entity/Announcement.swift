struct Announcement: Codable, Identifiable {
    let id: Int
    let title: String
    let image: String
    let link: String
    let datetime: String

    enum CodingKeys: String, CodingKey {
        case id = "n_id"
        case title, image, link, datetime
    }
}
