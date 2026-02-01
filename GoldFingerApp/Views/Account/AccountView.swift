import SwiftUI

struct AccountView: View {
    let user: User
    @State private var balance: Double = 0.0
    @State private var serviceList : [PayService] = []

    var body: some View {
        VStack(spacing: 20) {

            Text("我的账户")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.yellow)
                .padding(.top, 40)

            Spacer()

            // 账户余额部分
            VStack(spacing: 10) {
                Text("账户余额")
                    .font(.headline)
                    .foregroundStyle(.gray)

                Text("¥\(String(format: "%.2f", balance))")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundStyle(.green)

                Button("充值") {
                    // TODO: 充值功能
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .background(Color.blue)
                .foregroundStyle(.white)
                .cornerRadius(10)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            .padding(.horizontal)

            // 订阅服务部分
            VStack(spacing: 10) {
                Text("订阅服务")
                    .font(.headline)
                    .foregroundStyle(.gray)
                
                ForEach(serviceList){ service in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(service.psServid)")
                                .font(.title2)
                                .fontWeight(.bold)

                            Text("有效期至：\(service.enddate)")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }

                        Spacer()
                    }
                    .padding()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            .padding(.horizontal)

            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
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

#Preview {
    NavigationStack {
//        AccountView(user: nil)
    }
}
