import SwiftUI

struct RegisterView: View{
    @StateObject private var registerViewModel = RegisterViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View{
        ZStack {
            Color(red: 0.08, green: 0.08, blue: 0.10)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 32) {

                    // Logo区域
                    VStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(
                                    colors: [Color.yellow, Color.orange],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(width: 88, height: 88)
                                .shadow(color: .yellow.opacity(0.4), radius: 20, x: 0, y: 8)
                            Image(systemName: "person.badge.plus")
                                .font(.system(size: 36))
                                .foregroundStyle(.black)
                        }
                        Text("创建账号")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundStyle(.yellow)
                        Text("加入足坛金手指")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .padding(.top, 60)

                    // 注册表单卡片
                    VStack(spacing: 16) {

                        // 用户名
                        VStack(alignment: .leading, spacing: 6) {
                            Text("用户名")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white.opacity(0.6))
                            TextField("请输入用户名", text: $registerViewModel.username)
                                .textFieldStyle(.plain)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .foregroundStyle(.white)
                                .padding(14)
                                .background(Color.white.opacity(0.08))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                )
                        }

                        // 密码
                        VStack(alignment: .leading, spacing: 6) {
                            Text("密码")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white.opacity(0.6))
                            SecureField("请输入密码", text: $registerViewModel.password)
                                .textFieldStyle(.plain)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .foregroundStyle(.white)
                                .padding(14)
                                .background(Color.white.opacity(0.08))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                                )
                        }

                        // 消息提示
                        if !registerViewModel.registerMessage.isEmpty {
                            HStack(spacing: 6) {
                                Image(systemName: registerViewModel.registerMessage.contains("成功") ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
                                Text(registerViewModel.registerMessage)
                                    .font(.subheadline)
                            }
                            .foregroundStyle(registerViewModel.registerMessage.contains("成功") ? Color.green : Color.red)
                            .padding(.vertical, 4)
                        }
                    }
                    .padding(24)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.05))
                    )
                    .shadow(color: .black.opacity(0.3), radius: 12, x: 0, y: 6)
                    .padding(.horizontal, 20)

                    // 按钮区域
                    VStack(spacing: 14) {
                        Button {
                            Task {
                                await registerViewModel.Register()
                                if registerViewModel.registerMessage.contains("成功") {
                                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                                    dismiss()
                                }
                            }
                        } label: {
                            Text("创建新用户")
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.yellow)
                                .foregroundStyle(.black)
                                .cornerRadius(14)
                        }

                        Button {
                            dismiss()
                        } label: {
                            Text("返回登录界面")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.white.opacity(0.08))
                                .foregroundStyle(.white.opacity(0.8))
                                .cornerRadius(14)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.white.opacity(0.15), lineWidth: 1)
                                )
                        }
                    }
                    .padding(.horizontal, 20)

                    Spacer(minLength: 40)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    RegisterView()
}
