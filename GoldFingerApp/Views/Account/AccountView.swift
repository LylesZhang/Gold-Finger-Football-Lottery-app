//
//  AccountView.swift
//  GoldFingerApp
//
//  Created by Zero_Legend on 2026/1/24.
//

import SwiftUI

struct AccountView: View {
    @State private var balance: Double = 0.0

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

                HStack {
                    VStack(alignment: .leading) {
                        Text("金手指日报")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("有效期至：2026-12-31")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }

                    Spacer()
                }
                .padding()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("竞彩日报")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("有效期至：2026-12-31")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }

                    Spacer()
                }
                .padding()

            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            .padding(.horizontal)

            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AccountView()
    }
}
