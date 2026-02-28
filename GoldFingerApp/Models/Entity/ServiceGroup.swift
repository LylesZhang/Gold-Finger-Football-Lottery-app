struct ServiceGroup: Codable, Identifiable {
    let groupName: String
    let plans: [ServicePlan]
    let smsEnabled: Bool?
    let intro: String?

    var id: String { groupName }
}

struct ServicePlan: Codable, Identifiable {
    let servId: Int
    let period: String
    let money: Int
    let timeType: Int

    var id: Int { timeType }  // 同一 servId 下用 timeType 区分唯一性
}
