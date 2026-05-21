struct PurchasedIdsResponse: Codable {
    let success: Bool
    let fids: [Int]?
    let message: String?
}
