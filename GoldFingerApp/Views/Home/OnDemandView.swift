import SwiftUI

struct OnDemandView: View {

    @State private var selectedTab = 0

    private let tabs = ["中奖喜报", "金手指头条", "足彩单场", "足彩专区", "竞猜专区", "特色足彩"]

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - 顶部横向 Tab 栏
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(tabs.indices, id: \.self) { index in
                        Button(action: { selectedTab = index }) {
                            VStack(spacing: 8) {
                                Text(tabs[index])
                                    .font(.system(size: 14, weight: selectedTab == index ? .bold : .regular))
                                    .foregroundStyle(selectedTab == index ? Color("AppTextPrimary") : Color("AppTextSecondary"))
                                    .padding(.horizontal, 16)

                                Rectangle()
                                    .fill(selectedTab == index ? Color.yellow : Color.clear)
                                    .frame(height: 2)
                            }
                            .padding(.top, 10)
                        }
                    }
                }
            }
            .background(Color("AppCard"))

            Divider()
                .background(Color("AppInputBackground"))

            // MARK: - 内容列表（占位）
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(0..<10, id: \.self) { _ in
                        placeholderRow
                        Divider()
                            .background(Color("AppDivider"))
                            .padding(.horizontal, 16)
                    }
                }
                .padding(.top, 4)
                .padding(.bottom, 32)
            }
        }
        .background(Color("AppBackground").ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("点播")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.yellow)
            }
        }
    }

    // MARK: - 占位行
    private var placeholderRow: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 标题
            Text("标题内容占位，待填充真实数据")
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color("AppTextPrimary"))
                .lineLimit(2)

            // 发布时间 + 信心指数 + 价格
            HStack(spacing: 0) {
                Text("发布时间：")
                    .font(.system(size: 12))
                    .foregroundStyle(.white.opacity(0.4))
                Text("--:--")
                    .font(.system(size: 12))
                    .foregroundStyle(.white.opacity(0.4))

                Text("  信心指数：")
                    .font(.system(size: 12))
                    .foregroundStyle(.white.opacity(0.4))

                HStack(spacing: 2) {
                    ForEach(0..<4, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .font(.system(size: 10))
                            .foregroundStyle(.yellow.opacity(0.6))
                    }
                    Image(systemName: "star.leadinghalf.filled")
                        .font(.system(size: 10))
                        .foregroundStyle(.yellow.opacity(0.6))
                }

                Spacer()

                Text("0宝")
                    .font(.system(size: 12, weight: .medium))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 3)
                    .background(Color("AppInputBackground"))
                    .foregroundStyle(.white.opacity(0.5))
                    .cornerRadius(5)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

#Preview {
    NavigationStack {
        OnDemandView()
    }
}
