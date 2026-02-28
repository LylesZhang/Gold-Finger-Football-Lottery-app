import SwiftUI

struct AccountView: View {
    let user: User
    @State private var balance: Double = 0.0
    @State private var serviceList : [PayService] = []

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                // 用户信息头部
                HStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(LinearGradient(
                                colors: [Color.yellow, Color.orange],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(width: 64, height: 64)
                        Text(String(user.username.prefix(1)).uppercased())
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(.black)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.username)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        Text("UID: \(user.uid)")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.6))
                    }

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)

                // 余额卡片
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(
                            colors: [Color(red: 0.12, green: 0.12, blue: 0.12), Color(red: 0.20, green: 0.16, blue: 0.04)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .shadow(color: .yellow.opacity(0.25), radius: 12, x: 0, y: 6)

                    VStack(spacing: 12) {
                        HStack {
                            Text("账户余额")
                                .font(.subheadline)
                                .foregroundStyle(.yellow.opacity(0.8))
                            Spacer()
                            Image(systemName: "creditcard.fill")
                                .foregroundStyle(.yellow.opacity(0.6))
                        }

                        HStack(alignment: .bottom, spacing: 4) {
                            Text("¥")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundStyle(.yellow.opacity(0.8))
                                .padding(.bottom, 6)
                            Text(String(format: "%.2f", balance))
                                .font(.system(size: 52, weight: .bold))
                                .foregroundStyle(.yellow)
                            Spacer()
                        }

                        HStack {
                            Spacer()
                            Button("立即充值") {
                                // TODO: 充值功能
                            }
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 28)
                            .padding(.vertical, 10)
                            .background(Color.yellow)
                            .foregroundStyle(.black)
                            .cornerRadius(20)
                        }
                    }
                    .padding(24)
                }
                .padding(.horizontal, 20)

                // 订阅服务部分
                VStack(spacing: 14) {
                    HStack {
                        Text("我的订阅")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        Spacer()
                        NavigationLink(destination: SubscribeView(user: user)) {
                            HStack(spacing: 4) {
                                Image(systemName: "plus")
                                    .font(.caption)
                                Text("订阅")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 8)
                            .background(Color.yellow)
                            .foregroundStyle(.black)
                            .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal, 20)

                    if serviceList.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "doc.text.magnifyingglass")
                                .font(.system(size: 36))
                                .foregroundStyle(.white.opacity(0.3))
                            Text("暂无订阅服务")
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.4))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                    } else {
                        ForEach(serviceList) { service in
                            HStack(spacing: 16) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.yellow.opacity(0.15))
                                        .frame(width: 48, height: 48)
                                    Image(systemName: "star.fill")
                                        .foregroundStyle(.yellow)
                                        .font(.system(size: 20))
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(service.serviceName ?? "未知服务")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                    Text("有效期至：\(service.enddate)")
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.5))
                                }

                                Spacer()

                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                                    .font(.system(size: 20))
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white.opacity(0.06))
                            )
                            .padding(.horizontal, 20)
                        }
                    }
                }

                Spacer(minLength: 40)
            }
        }
        .background(Color(red: 0.08, green: 0.08, blue: 0.10).ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("我的账户")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.yellow)
            }
        }
        .onAppear{
            Task{
                do{
                    let accountInfo = try await UserService.shares.getAccountinfo(username: user.username)
                    balance = accountInfo.balance ?? 0.0
                } catch{
                    print("用户余额信息获取失败")
                }

                do{
                    let response = try await UserService.shares.getAllPayServices(uid: user.uid)
                    serviceList = response.servicelist ?? []
                } catch{
                    print("订阅服务获取失败: \(error)")
                }
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        let testUser = User(uid: 65488, username: "Zhangchun")
        AccountView(user: testUser)
    }
}
