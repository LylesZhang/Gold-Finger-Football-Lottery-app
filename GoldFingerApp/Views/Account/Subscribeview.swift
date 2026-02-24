import SwiftUI

struct SubscribeView: View {
    @State private var serviceList: [ServiceConfig] = []

    var body: some View {
        VStack(spacing: 20) {
            Text("订阅服务")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.yellow)
                .padding(.top, 40)

            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(serviceList) { service in
                        NavigationLink(destination: SubscribeView()) {
                            VStack{
                                Text(service.name ?? "")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                                
                                Spacer()
                                
                                Text(service.intro ?? "点击查看详情")
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.2))
                        .foregroundStyle(.gray)
                        .cornerRadius(30)
                    }
                }
                .padding(.horizontal)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
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
