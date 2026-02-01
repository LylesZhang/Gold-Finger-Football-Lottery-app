
import Foundation

struct PayServiceResponse: Codable {
    let success: Bool
    let uid: Int?
    let serviceList: [PayService]?
    let message: String?

}
