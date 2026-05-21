import Foundation

struct PurchaseTarget: Identifiable {
    let id = UUID()
    let fid: Int
    let title: String
    let price: Int
    let dId: Int
}
