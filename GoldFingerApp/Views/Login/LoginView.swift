import SwiftUI

struct LoginView: View{
    @StateObject private var loginViewModel = LoginViewModel()
    @State private var isLogin = false

    var body: some View{
        NavigationStack{
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
                                Image(systemName: "star.fill")
                                    .font(.system(size: 40))
                                    .foregroundStyle(.black)
                            }
                            Text("足坛金手指")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundStyle(.yellow)
                            Text("专业足彩数据分析平台")
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        .padding(.top, 60)

                        // 登录表单卡片
                        VStack(spacing: 16) {

                            // 用户名
                            VStack(alignment: .leading, spacing: 6) {
                                Text("用户名")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white.opacity(0.6))
                                TextField("请输入用户名", text: $loginViewModel.username)
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
                                SecureField("请输入密码", text: $loginViewModel.password)
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

                            // 验证码
                            VStack(alignment: .leading, spacing: 6) {
                                Text("验证码")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white.opacity(0.6))
                                HStack(spacing: 12) {
                                    TextField("请输入验证码", text: $loginViewModel.captchaCode)
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

                                    if let image = loginViewModel.captchaImage {
                                        Button {
                                            Task {
                                                await loginViewModel.loadCapta()
                                            }
                                        } label: {
                                            Image(uiImage: image)
                                                .resizable()
                                                .frame(width: 100, height: 48)
                                                .cornerRadius(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.yellow.opacity(0.4), lineWidth: 1)
                                                )
                                        }
                                    }
                                }
                            }

                            // 消息提示
                            if !loginViewModel.loginMessage.isEmpty {
                                HStack(spacing: 6) {
                                    Image(systemName: loginViewModel.loginMessage.contains("成功") ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
                                    Text(loginViewModel.loginMessage)
                                        .font(.subheadline)
                                }
                                .foregroundStyle(loginViewModel.loginMessage.contains("成功") ? Color.green : Color.red)
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
                                    try await loginViewModel.Login()
                                    if loginViewModel.loginMessage.contains("成功") {
                                        isLogin = true
                                    }
                                }
                            } label: {
                                Text("登录")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(Color.yellow)
                                    .foregroundStyle(.black)
                                    .cornerRadius(14)
                            }

                            NavigationLink(destination: RegisterView()) {
                                HStack(spacing: 4) {
                                    Text("还没有账号？")
                                        .foregroundStyle(.white.opacity(0.5))
                                    Text("立即注册")
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.yellow)
                                }
                                .font(.subheadline)
                            }
                        }
                        .padding(.horizontal, 20)

                        Spacer(minLength: 40)
                    }
                }
            }
            .navigationDestination(isPresented: $isLogin) {
                if let user = loginViewModel.loginUser {
                    AccountView(user: user)
                }
            }
            .onAppear {
                isLogin = false
                loginViewModel.loginMessage = ""
                loginViewModel.loginUser = nil
                Task {
                    await loginViewModel.loadCapta()
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
