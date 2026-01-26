struct AccountInfoResponse: Codable {
    let success: Bool
    let username: String?
    let balance: Double?
    let message: String?
    
    init(username: String, balance: Double, success: Bool,
         message: String? = nil){
             self.username = username
             self.balance = balance
             self.success = success
             self.message = message
    }
}
