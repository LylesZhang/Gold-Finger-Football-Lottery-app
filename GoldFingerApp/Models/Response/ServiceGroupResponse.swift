struct ServiceGroupResponse: Codable {
    let success: Bool
    let groups: [ServiceGroup]?
    let message: String?
}
