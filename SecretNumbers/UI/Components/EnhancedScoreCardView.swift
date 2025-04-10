//
//  EnhancedScoreCardView.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//


import SwiftUI

struct EnhancedScoreCardView: View {
    let score: GameViewModel.Score
    let isLatest: Bool

    // アニメーション用の状態変数
    @State private var appear = false

    var body: some View {
        HStack {
            // 試行回数
            Text("No.\(score.id)")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(.primaryText)
                .frame(width: 50, alignment: .leading)
                .opacity(appear ? 1.0 : 0.0)
                .offset(x: appear ? 0 : -10)

            Spacer()

            // 入力した数字
            Text(score.input)
                .font(.system(size: 24, weight: .bold, design: .monospaced))
                .foregroundColor(.primaryText)
                .opacity(appear ? 1.0 : 0.0)

            Spacer()

            // ヒット・ブロー表示
            HStack(spacing: 16) {
                // ヒット表示
                HStack(spacing: 6) {
                    Circle()
                        .fill(Color.hitColor)
                        .frame(width: 14, height: 14)
                    Text("\(score.hits)")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.primaryText)
                }
                .opacity(appear ? 1.0 : 0.0)
                .offset(x: appear ? 0 : 10)
                .animation(.easeIn.delay(0.1), value: appear)

                // ブロー表示
                HStack(spacing: 6) {
                    Circle()
                        .fill(Color.blowColor)
                        .frame(width: 14, height: 14)
                    Text("\(score.blows)")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.primaryText)
                }
                .opacity(appear ? 1.0 : 0.0)
                .offset(x: appear ? 0 : 10)
                .animation(.easeIn.delay(0.2), value: appear)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.numberButton.opacity(isLatest ? 0.4 : 0.2))
                .shadow(color: Color.black.opacity(isLatest ? 0.15 : 0.05), radius: isLatest ? 5 : 2, x: 0, y: 2)
        )
        .scaleEffect(appear ? 1.0 : 0.95)
        .onAppear {
            // 表示アニメーション
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                appear = true
            }
        }
    }
}

// プレビュー用のScore構造体定義
extension EnhancedScoreCardView_Previews {
    struct PreviewScore: Identifiable {
        var id: Int
        var input: String
        var hits: Int
        var blows: Int
    }
}

struct EnhancedScoreCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // 最新の結果（強調表示あり）
                EnhancedScoreCardView(
                    score: GameViewModel.Score(id: 1, input: "123", hits: 1, blows: 2),
                    isLatest: true
                )

                // 通常の結果
                EnhancedScoreCardView(
                    score: GameViewModel.Score(id: 2, input: "456", hits: 0, blows: 1),
                    isLatest: false
                )

                // 全部ヒットの結果
                EnhancedScoreCardView(
                    score: GameViewModel.Score(id: 3, input: "789", hits: 3, blows: 0),
                    isLatest: false
                )
            }
            .padding()
        }
    }
}
