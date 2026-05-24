import SwiftUI

struct AccountDetailView: View {
    let user: User

    @State private var orders: [MbOrder] = []
    @State private var isLoading = true
    @State private var errorMessage: String? = nil

    var body: some View {
        ZStack {
            Color("AppBackground").ignoresSafeArea()

            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                    .scaleEffect(1.2)
            } else if let error = errorMessage {
                VStack(spacing: 14) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 36))
                        .foregroundStyle(.yellow)
                    Text(error)
                        .font(.subheadline)
                        .foregroundStyle(Color("AppTextSecondary"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
            } else if orders.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.system(size: 36))
                        .foregroundStyle(Color("AppTextTertiary"))
                    Text("暂无消费记录")
                        .font(.subheadline)
                        .foregroundStyle(Color("AppTextSecondary"))
                }
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        ForEach(Array(orders.enumerated()), id: \.element.id) { index, order in
                            orderRow(order)
                            if index < orders.count - 1 {
                                Divider()
                                    .background(Color("AppDivider"))
                                    .padding(.leading, 16)
                            }
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color("AppCard"))
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationTitle("账户明细")
        .navigationBarTitleDisplayMode(.inline)
        .task { await loadOrders() }
    }

    @ViewBuilder
    private func orderRow(_ order: MbOrder) -> some View {
        let isIncome = order.type_name == "充值" || order.type_name == "订阅"
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 5) {
                Text(order.title ?? order.note_name ?? "记录")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color("AppTextPrimary"))
                    .lineLimit(2)
                HStack(spacing: 6) {
                    if let typeName = order.type_name {
                        Text(typeName)
                            .font(.system(size: 11))
                            .padding(.horizontal, 6).padding(.vertical, 2)
                            .background(Color.yellow.opacity(0.15))
                            .foregroundStyle(.yellow)
                            .cornerRadius(4)
                    }
                    if let time = order.time {
                        Text(time)
                            .font(.system(size: 11))
                            .foregroundStyle(Color("AppTextTertiary"))
                    }
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                if let money = order.money {
                    Text(isIncome ? "+\(money)" : "-\(money)")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(isIncome ? .green : .red)
                }
                if let balance = order.balance {
                    Text("余额 \(balance)")
                        .font(.system(size: 11))
                        .foregroundStyle(Color("AppTextTertiary"))
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }

    private func loadOrders() async {
        guard let jmck = user.jmck, !jmck.isEmpty else {
            errorMessage = "请先登录 maicai.cn 账号"
            isLoading = false
            return
        }
        do {
            orders = try await UserService.shares.getNewMbOrders(username: user.username, jmck: jmck)
        } catch {
            errorMessage = "加载失败：\(error.localizedDescription)"
        }
        isLoading = false
    }
}

#Preview {
    NavigationStack {
        AccountDetailView(user: User(uid: 65488, username: "ZhangChun"))
    }
}
