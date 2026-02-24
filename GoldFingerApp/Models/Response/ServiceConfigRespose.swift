struct ServiceConfigResponse: Codable {
    let success: Bool
    let servicelist: [ServiceConfig]?
    let message: String?

}
