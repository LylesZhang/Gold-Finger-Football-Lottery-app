import SwiftUI

struct SettingsView: View {
    @AppStorage("prefersDarkMode") private var prefersDarkMode: Bool = true

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {

                // 外观设置分组
                VStack(spacing: 0) {
                    // 深色模式 Toggle
                    HStack(spacing: 14) {
                        Image(systemName: "moon.fill")
                            .font(.system(size: 15))
                            .foregroundStyle(.yellow.opacity(0.8))
                            .frame(width: 22)

                        Text("深色模式")
                            .font(.system(size: 15))
                            .foregroundStyle(Color("AppTextPrimary"))

                        Spacer()

                        Toggle("", isOn: $prefersDarkMode)
                            .labelsHidden()
                            .tint(.yellow)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                }
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color("AppCard"))
                )

                Text("关闭深色模式后将切换为浅色模式")
                    .font(.system(size: 12))
                    .foregroundStyle(Color("AppTextTertiary"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 4)
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
        }
        .background(Color("AppBackground").ignoresSafeArea())
        .navigationTitle("设置")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
