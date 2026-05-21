import SwiftUI

struct ArticlePurchaseSheet: View {
    let target: PurchaseTarget
    let user: User
    let onSuccess: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var balance: Double? = nil
    @State private var isLoadingBalance = true
    @State private var isPurchasing = false
    @State private var errorMessage: String? = nil

    private var canAfford: Bool {
        guard let balance else { return false }
        return balance >= Double(target.price)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color("AppBackground").ignoresSafeArea()

                VStack(spacing: 12) {
                    // 文章信息卡片
                    VStack(alignment: .leading, spacing: 12) {
                        Text("文章")
                            .font(.system(size: 12))
                            .foregroundStyle(Color("AppTextTertiary"))

                        Text(target.title)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(Color("AppTextPrimary"))
                            .fixedSize(horizontal: false, vertical: true)

                        Divider().background(Color("AppDivider"))

                        HStack {
                            Text("单价")
                                .font(.system(size: 14))
                                .foregroundStyle(Color("AppTextSecondary"))
                            Spacer()
                            Text("\(target.price) 元")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.yellow)
                        }
                    }
                    .padding(16)
                    .background(Color("AppCard"))
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                    .padding(.top, 20)

                    // 余额卡片
                    VStack(spacing: 0) {
                        HStack {
                            Text("账户余额")
                                .font(.system(size: 14))
                                .foregroundStyle(Color("AppTextSecondary"))
                            Spacer()
                            if isLoadingBalance {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                                    .scaleEffect(0.8)
                            } else if let balance {
                                Text(String(format: "%.2f 元", balance))
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(canAfford ? Color("AppTextPrimary") : .red)
                            }
                        }
                        .padding(16)

                        if !isLoadingBalance, let balance, balance < Double(target.price) {
                            Divider().background(Color("AppDivider"))
                            Text("余额不足，请前往「个人中心」充值")
                                .font(.system(size: 12))
                                .foregroundStyle(.red)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                        }
                    }
                    .background(Color("AppCard"))
                    .cornerRadius(12)
                    .padding(.horizontal, 16)

                    // 错误信息
                    if let errorMessage {
                        Text(errorMessage)
                            .font(.system(size: 13))
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                    }

                    Spacer()

                    // 购买按钮
                    Button(action: doPurchase) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(canAfford && !isLoadingBalance ? Color.yellow : Color("AppCard"))
                                .frame(height: 50)
                            if isPurchasing {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            } else {
                                Text("确认购买  \(target.price) 元")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(canAfford && !isLoadingBalance ? .black : Color("AppTextTertiary"))
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                    .disabled(!canAfford || isPurchasing || isLoadingBalance)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("购买文章")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.yellow)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("取消") { dismiss() }
                        .foregroundStyle(Color("AppTextSecondary"))
                }
            }
        }
        .task {
            isLoadingBalance = true
            if let info = try? await UserService.shares.getAccountinfo(username: user.username) {
                balance = info.balance
            }
            isLoadingBalance = false
        }
    }

    private func doPurchase() {
        guard canAfford, !isPurchasing else { return }
        isPurchasing = true
        errorMessage = nil
        Task {
            do {
                try await UserService.shares.buyArticle(
                    uid: user.uid,
                    fid: target.fid,
                    money: target.price,
                    dId: target.dId,
                    title: target.title
                )
                dismiss()
                onSuccess()
            } catch {
                errorMessage = error.localizedDescription
            }
            isPurchasing = false
        }
    }
}
