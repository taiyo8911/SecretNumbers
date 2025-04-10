//
//  GameView.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//


import SwiftUI

struct GameView: View {
    // 標準的な電話配列に変更
    private let keyboardButtons = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["", "0", ""]
    ]

    // ViewModel
    @StateObject private var viewModel = GameViewModel()

    var body: some View {
        ZStack {
            // 統一された背景グラデーション
            BackgroundGradient()

            VStack {
                Spacer()

                // ゲームステータスメッセージ
                Text(viewModel.message)
                    .titleStyle()
                    .opacity(viewModel.showMessage ? 0.9 : 1.0)
                    .scaleEffect(viewModel.showMessage ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.3), value: viewModel.showMessage)

                // プログレスバー（残り試行回数の視覚化）
                ProgressBar(
                    current: GameViewModel.challengeNumber - viewModel.remaining,
                    total: GameViewModel.challengeNumber
                )
                .frame(height: 18)
                .padding(.horizontal, 40)

                // 入力エリア
                HStack(spacing: 16) {
                    ForEach(0..<3) { index in
                        AnimatedNumberInputCell(
                            value: viewModel.userInputNumbers[index],
                            isActive: index == viewModel.userInputCount
                        )
                    }
                }
                .padding(.vertical, 24)

                // スコア履歴
                if viewModel.scores.isEmpty {
                    Text("数字を入力してください")
                        .bodyStyle()
                        .padding(.bottom, 62)
                        .withSectionSpacing()
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.scores) { score in
                                EnhancedScoreCardView(
                                    score: score,
                                    isLatest: score.id == viewModel.scores.first?.id
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .frame(height: 130)
                }

                Spacer()

                // キーボード
                VStack(spacing: 12) {
                    ForEach(keyboardButtons, id: \.self) { row in
                        HStack(spacing: 12) {
                            ForEach(row, id: \.self) { digit in
                                if digit.isEmpty {
                                    // 空のスペースを追加
                                    Spacer()
                                        .frame(width: 60, height: 60)
                                } else {
                                    Button {
                                        // 数字入力処理と触覚フィードバック
                                        let generator = UIImpactFeedbackGenerator(style: .light)
                                        generator.impactOccurred()
                                        viewModel.inputCheck(digit)
                                    } label: {
                                        Text(digit)
                                            .font(.system(size: 28, weight: .bold, design: .rounded))
                                            .foregroundColor(.primaryText)
                                            .frame(width: 60, height: 60)
                                            .background(Color.numberButton)
                                            .cornerRadius(30)
                                            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 20)
                .modifier(ShakeEffect(animatableData: viewModel.shakeKeyboard ? 1 : 0))

                // 機能ボタン
                HStack(spacing: 24) {
                    // クリアボタン
                    Button {
                        // 触覚フィードバック
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()

                        viewModel.clearInput()
                    } label: {
                        Text("Clear")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.primaryText)
                            .frame(width: 120, height: 50)
                            .background(Color.clearButton)
                            .cornerRadius(25)
                            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
                    }

                    // 判定ボタン
                    Button {
                        // 触覚フィードバック（成功）
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)

                        viewModel.judgeInput()
                    } label: {
                        Text("Enter")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.primaryText)
                            .frame(width: 120, height: 50)
                            .background(Color.enterButton)
                            .cornerRadius(25)
                            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
                    }
                }
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 24)


            // ゲーム結果オーバーレイ
            if viewModel.showResultOverlay {
                GameResultOverlay(
                    resultType: viewModel.isGameClear ? .win : .lose,
                    correctNumbers: viewModel.correctNumbers,
                    attempts: GameViewModel.challengeNumber - viewModel.remaining,
                    onNewGame: {
                        // 明示的にゲームをリセット
                        viewModel.resetGame()
                    }
                )
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameView()
        }
    }
}


