import SwiftUI

struct SubscribeView: View {
    @State private var serviceList: [ServiceConfig] = []

    var body: some View {
        ZStack {
            Color(red: 0.08, green: 0.08, blue: 0.10)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {

                    // 顶部说明
                    VStack(spacing: 8) {
                        Image(systemName: "crown.fill")
                            .font(.system(size: 36))
                            .foregroundStyle(.yellow)
                        Text("选择订阅套餐")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        Text("专业数据，助您制胜")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 8)

                    // 服务列表
                    LazyVStack(spacing: 12) {
                        ForEach(serviceList) { service in
                            NavigationLink(destination: ServiceView(service: service)) {
                                HStack(spacing: 16) {
                                    // 左侧图标
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.yellow.opacity(0.15))
                                            .frame(width: 52, height: 52)
                                        Image(systemName: "doc.text.fill")
                                            .foregroundStyle(.yellow)
                                            .font(.system(size: 22))
                                    }

                                    // 中间文字
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(service.name ?? "未知套餐")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                            .multilineTextAlignment(.leading)
                                        if let money = service.money {
                                            Text("¥\(money)")
                                                .font(.caption)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(.yellow.opacity(0.8))
                                        }
                                    }

                                    Spacer()

                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.3))
                                }
                                .padding(.horizontal, 18)
                                .padding(.vertical, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white.opacity(0.06))
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)

                    Spacer(minLength: 40)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("订阅服务")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.yellow)
            }
        }
        .onAppear {
            Task {
                do {
                    let response = try await UserService.shares.getAllAvailableServices()
                    serviceList = response.servicelist ?? []
                } catch {
                    print("服务列表加载失败: \(error)")
                }
            }
        }
    }
}

#Preview {
    SubscribeView()
}
