
import Foundation

struct PayServiceResponse: Codable {
    let success: Bool
    let uid: Int?
    let servicelist: [PayService]?
    let message: String?

}
