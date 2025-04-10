//
//  SplashView.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//


import SwiftUI

struct SplashView: View {
    // スプラッシュ画面表示フラグ
    @State private var isActive = false

    // アニメーション用の状態変数
    @State private var opacity = 0.0
    @State private var scale = 0.7
    @State private var rotation = 0.0
    @State private var numbers = ["?", "?", "?"]
    @State private var showNumbers = false

    var body: some View {
        ZStack {
            // 統一された背景グラデーション
            BackgroundGradient()

            VStack(spacing: 24) {
                // アプリアイコンとタイトル
                VStack(spacing: 16) {
                    // 数字が回転するアニメーション
                    HStack(spacing: 20) {
                        ForEach(0..<3) { index in
                            Text(numbers[index])
                                .font(.system(size: 48, weight: .bold, design: .rounded))
                                .foregroundColor(.primaryText)
                                .frame(width: 70, height: 70)
                                .background(Color.numberButton.opacity(0.3))
                                .cornerRadius(10)
                                .rotation3DEffect(
                                    .degrees(rotation),
                                    axis: (x: 0, y: 1, z: 0)
                                )
                                .opacity(showNumbers ? 1 : 0)
                                .offset(y: showNumbers ? 0 : 20)
                        }
                    }
                    .padding(.bottom, 20)

                    // アプリ名
                    Text("シークレットナンバーズ")
                        .titleStyle()
                        .scaleEffect(scale)
                        .opacity(opacity)
                }

                // ロード中の表示
                Text("Loading...")
                    .subtitleStyle()
                    .opacity(opacity * 0.7)
                    .padding(.top, 40)
            }
        }
        .onAppear {
            // 一連のアニメーションを開始
            startAnimations()

            // スプラッシュ画面表示後にMainViewに遷移
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    isActive = true
                }
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            MainView()
        }
    }

    // アニメーションを開始する関数
    private func startAnimations() {
        // フェードインとスケールアニメーション
        withAnimation(.easeOut(duration: 0.8)) {
            opacity = 1.0
            scale = 1.0
        }

        // 少し遅れて数字の表示アニメーション
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                showNumbers = true
            }
        }

        // 数字の回転アニメーション
        withAnimation(.linear(duration: 1.0).repeatCount(2, autoreverses: true)) {
            rotation = 360
        }

        // 数字を順番に切り替えるアニメーション
        animateNumbers()
    }

    // 数字を順番に切り替えるアニメーション
    private func animateNumbers() {
        // 最初の数字を変更
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                numbers[0] = String(Int.random(in: 0...9))
            }
        }

        // 2番目の数字を変更
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation {
                numbers[1] = String(Int.random(in: 0...9))
            }
        }

        // 3番目の数字を変更
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                numbers[2] = String(Int.random(in: 0...9))
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
