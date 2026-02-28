import SwiftUI

struct ServiceView: View {
    let group: ServiceGroup
    let user: User

    @State private var selectedPlan: ServicePlan
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    init(group: ServiceGroup, user: User) {
        self.group = group
        self.user = user
        _selectedPlan = State(initialValue: group.plans.first!)
    }

    // 去除简单HTML标签，仅用于展示
    private var cleanIntro: String {
        guard let raw = group.intro else { return "" }
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

                            Text(group.groupName)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)

                            // 套餐选择器
                            HStack(spacing: 10) {
                                ForEach(group.plans) { plan in
                                    Button {
                                        selectedPlan = plan
                                    } label: {
                                        VStack(spacing: 4) {
                                            Text(plan.period)
                                                .font(.caption)
                                                .fontWeight(.semibold)
                                            Text("¥\(plan.money)")
                                                .font(.subheadline)
                                                .fontWeight(.bold)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 10)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(selectedPlan.id == plan.id
                                                      ? Color.yellow
                                                      : Color.white.opacity(0.1))
                                        )
                                        .foregroundStyle(selectedPlan.id == plan.id ? .black : .white)
                                    }
                                }
                            }
                            .padding(.horizontal, 4)

                            // 当前选中价格大字展示
                            HStack(alignment: .bottom, spacing: 4) {
                                Text("¥")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(.yellow.opacity(0.8))
                                    .padding(.bottom, 4)
                                Text("\(selectedPlan.money)")
                                    .font(.system(size: 44, weight: .bold))
                                    .foregroundStyle(.yellow)
                                Text("/ \(selectedPlan.period)")
                                    .font(.subheadline)
                                    .foregroundStyle(.yellow.opacity(0.6))
                                    .padding(.bottom, 6)
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
                            value: selectedPlan.period
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
                                Text(group.smsEnabled == true ? "支持" : "不支持")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                            }
                            Spacer()
                            Image(systemName: group.smsEnabled == true ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundStyle(group.smsEnabled == true ? .green : .white.opacity(0.25))
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
                        Task {
                            isLoading = true
                            do {
                                try await UserService.shares.subscribeService(uid: user.uid, psServid: selectedPlan.servId, timeType: selectedPlan.timeType)
                                alertTitle = "订阅成功"
                                alertMessage = "已成功订阅「\(group.groupName) · \(selectedPlan.period)」"
                            } catch {
                                alertTitle = "订阅失败"
                                alertMessage = error.localizedDescription
                            }
                            isLoading = false
                            showAlert = true
                        }
                    } label: {
                        Group {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            } else {
                                HStack(spacing: 8) {
                                    Image(systemName: "crown.fill")
                                    Text("立即订阅")
                                        .fontWeight(.bold)
                                }
                            }
                        }
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(isLoading ? Color.yellow.opacity(0.6) : Color.yellow)
                        .foregroundStyle(.black)
                        .cornerRadius(16)
                        .shadow(color: .yellow.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .disabled(isLoading)
                    .padding(.horizontal, 20)
                    .alert(alertTitle, isPresented: $showAlert) {
                        Button("确定", role: .cancel) {}
                    } message: {
                        Text(alertMessage)
                    }

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
        ServiceView(
            group: ServiceGroup(
                groupName: "金手指日报",
                plans: [
                    ServicePlan(servId: 41, period: "半年", money: 700, timeType: 5),
                    ServicePlan(servId: 41, period: "年度", money: 1400, timeType: 3)
                ],
                smsEnabled: false,
                intro: "《金手指日报》每日提供传统足彩、竞彩足球、竞彩篮球、北京单场，四大彩种的比赛数据、盘口、赔率分析！"
            ),
            user: User(uid: 1, username: "preview")
        )
    }
}
