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
                        Text(service.name ?? "")
                    }
                }
                .padding(.horizontal)
            }
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
