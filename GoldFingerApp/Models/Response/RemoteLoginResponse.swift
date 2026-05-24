import Foundation

struct RemoteLoginResponse: Codable {
    let code: Int?
    let message: String?
    let user_name: String?
    let uid: Int?
    let jmck: String?
    let userMoney: String?
    let gf_enddate: String?
    let cpzn_enddate: String?
    let jcrb_enddate: String?
}
