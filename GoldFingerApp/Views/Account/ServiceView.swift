import SwiftUI

struct ServiceView: View {
    let service: ServiceConfig

    private var timeTypeName: String {
        switch service.timeType {
        case 1: return "天"
        case 2: return "月"
        case 3: return "年"
        case 4: return "一季度"
        case 5: return "半年"
        default: return "未知"
        }
    }

    // 去除简单HTML标签，仅用于展示
    private var cleanIntro: String {
        guard let raw = service.intro else { return "" }
        return raw.replacing(/<[^>]+>/, with: "")
    }

    var body: some View {
        ZStack {
            Color(red: 0.08, green: 0.08, blue: 0.10)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {

                    // 顶部价格卡片
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(
                                colors: [
                                    Color(red: 0.12, green: 0.12, blue: 0.12),
                                    Color(red: 0.20, green: 0.16, blue: 0.04)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .shadow(color: .yellow.opacity(0.25), radius: 12, x: 0, y: 6)

                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.yellow.opacity(0.15))
                                    .frame(width: 72, height: 72)
                                Image(systemName: "doc.text.fill")
                                    .font(.system(size: 32))
                                    .foregroundStyle(.yellow)
                            }

                            Text(service.name ?? "未知套餐")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)

                            if let money = service.money {
                                HStack(alignment: .bottom, spacing: 4) {
                                    Text("¥")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundStyle(.yellow.opacity(0.8))
                                        .padding(.bottom, 4)
                                    Text("\(money)")
                                        .font(.system(size: 44, weight: .bold))
                                        .foregroundStyle(.yellow)
                                    Text("/ \(timeTypeName)")
                                        .font(.subheadline)
                                        .foregroundStyle(.yellow.opacity(0.6))
                                        .padding(.bottom, 6)
                                }
                            }
                        }
                        .padding(28)
                    }
                    .padding(.horizontal, 20)

                    // 套餐详情
                    VStack(spacing: 10) {
                        HStack {
                            Text("套餐详情")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        .padding(.horizontal, 20)

                        // 计费周期
                        infoRow(
                            icon: "clock.fill",
                            label: "计费周期",
                            value: timeTypeName
                        )

                        // 短信通知
                        HStack(spacing: 14) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.yellow.opacity(0.12))
                                    .frame(width: 40, height: 40)
                                Image(systemName: "message.fill")
                                    .foregroundStyle(.yellow)
                                    .font(.system(size: 16))
                            }
                            VStack(alignment: .leading, spacing: 2) {
                                Text("短信通知")
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                                Text(service.smsEnabled == true ? "支持" : "不支持")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                            }
                            Spacer()
                            Image(systemName: service.smsEnabled == true ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundStyle(service.smsEnabled == true ? .green : .white.opacity(0.25))
                                .font(.system(size: 20))
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.white.opacity(0.06))
                        )
                        .padding(.horizontal, 20)
                    }

                    // 服务介绍
                    if !cleanIntro.isEmpty {
                        VStack(spacing: 10) {
                            HStack {
                                Text("服务介绍")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                            .padding(.horizontal, 20)

                            Text(cleanIntro)
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.7))
                                .lineSpacing(6)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(18)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(Color.white.opacity(0.06))
                                )
                                .padding(.horizontal, 20)
                        }
                    }

                    // 立即订阅按钮
                    Button {
                        // TODO: 订阅功能
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "crown.fill")
                            Text("立即订阅")
                                .fontWeight(.bold)
                        }
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color.yellow)
                        .foregroundStyle(.black)
                        .cornerRadius(16)
                        .shadow(color: .yellow.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 20)

                    Spacer(minLength: 40)
                }
                .padding(.top, 20)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("套餐详情")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.yellow)
            }
        }
    }

    @ViewBuilder
    private func infoRow(icon: String, label: String, value: String) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.yellow.opacity(0.12))
                    .frame(width: 40, height: 40)
                Image(systemName: icon)
                    .foregroundStyle(.yellow)
                    .font(.system(size: 16))
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
            Spacer()
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.06))
        )
        .padding(.horizontal, 20)
    }
}

#Preview {
    NavigationStack {
        ServiceView(service: ServiceConfig(
            id: 41,
            name: "金手指日报(1200元/年)",
            money: 180,
            timeType: 4,
            enabled: true,
            smsEnabled: false,
            intro: "《金手指日报》每日提供传统足彩、竞彩足球数据分析！",
            user: nil,
            discount: nil
        ))
    }
}
