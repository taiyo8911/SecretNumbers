//
//  GameResultOverlay.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//


import SwiftUI

struct GameResultOverlay: View {
    enum ResultType {
        case win
        case lose
    }

    let resultType: ResultType
    let correctNumbers: [String]
    let attempts: Int
    let onNewGame: () -> Void

    // 単純化したアニメーション用の状態変数
    @State private var isVisible = false

    var body: some View {
        ZStack {
            // 背景オーバーレイ
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
                .opacity(isVisible ? 1.0 : 0.0)

            // 結果カード
            VStack(spacing: 24) {
                // 勝敗アイコンとタイトル
                Image(systemName: resultType == .win ? "trophy.fill" : "xmark")
                    .font(.system(size: 60))
                    .foregroundColor(resultType == .win ? .yellow : .red)
                    .padding(.top, 24)

                Text(resultType == .win ? "クリア！" : "ゲームオーバー")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.primaryText)

                // 正解表示
                VStack(spacing: 8) {
                    if resultType == .lose {
                        Text("正解は")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.primaryText.opacity(0.8))
                    }

                    HStack(spacing: 12) {
                        ForEach(0..<correctNumbers.count, id: \.self) { index in
                            Text(correctNumbers[index])
                                .font(.system(size: 32, weight: .bold, design: .monospaced))
                                .foregroundColor(.primaryText)
                                .frame(width: 60, height: 60)
                                .background(
                                    resultType == .win ?
                                        Color.hitColor.opacity(0.5) :
                                        Color.numberButton.opacity(0.5)
                                )
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                        }
                    }
                }
                .padding(.vertical, 16)

                // 結果詳細
                if resultType == .win {
                    Text("\(attempts)回目で正解!")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(.primaryText)
                } else {
                    Text("また挑戦してみよう！")
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .foregroundColor(.primaryText)
                }

                // 新しいゲームボタン
                Button {
                    print("もう一度遊ぶボタンタップ - \(resultType)")
                    // まずゲームをリセット
                    onNewGame()
                    print("onNewGameコールバック実行完了")

                    // 次にUIを非表示
                    withAnimation {
                        isVisible = false
                    }
                } label: {
                    Text("もう一度遊ぶ")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.primaryText)
                        .padding(.vertical, 14)
                        .padding(.horizontal, 32)
                        .background(Color.primaryColor)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
                }
                .padding(.vertical, 16)
            }
            .frame(width: 320)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.gradientStart.opacity(0.9))
                    .shadow(color: Color.black.opacity(0.3), radius: 16, x: 0, y: 8)
            )
            .scaleEffect(isVisible ? 1.0 : 0.8)
            .opacity(isVisible ? 1.0 : 0.0)
        }
        .onAppear {
            // 表示アニメーション
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                isVisible = true
            }
        }
    }
}


struct GameResultOverlay_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)

            // 正解のパターン
            GameResultOverlay(
                resultType: .win,
                correctNumbers: ["1", "2", "3"],
                attempts: 4,
                onNewGame: {}
            )

            // 不正解のパターン
            GameResultOverlay(
                resultType: .lose,
                correctNumbers: ["1", "2", "3"],
                attempts: 4,
                onNewGame: {}
            )
        }
    }
}

