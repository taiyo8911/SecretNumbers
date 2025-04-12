//
//  AboutView.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//


import SwiftUI

struct AboutView: View {
    // GameViewへの画面遷移フラグ
    @State private var showGameView = false

    var body: some View {

        ZStack {
            BackgroundGradient()

            VStack(alignment: .leading, spacing: 24) {
                Text("遊び方")
                    .titleStyle()
                    .padding(.top, 40)

                // ルール説明をカード形式で表示
                VStack(alignment: .leading, spacing: 16) {
                    explainationItem(icon: "1.circle", text: "3桁の数字を推測して下さい。")
                    explainationItem(icon: "2.circle", text: "チャンスは7回です。")
                    explainationItem(icon: "3.circle", text: "数字と場所の両方が合っている場合は赤丸、数字のみ合っている場合は黄色丸でその数を表示します。")

                    // 例の説明をスコアカードの表示と合わせる
                    VStack(alignment: .leading, spacing: 16) {
                        Text("例えば:")
                            .subtitleStyle()

                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 16) {
                                Text("正解：")
                                    .bodyStyle()

                                HStack(spacing: 8) {
                                    numberExample("1")
                                    numberExample("2")
                                    numberExample("3")
                                }
                            }

                            // ユーザー入力の表示
                            HStack(spacing: 16) {
                                Text("入力：")
                                    .bodyStyle()

                                HStack(spacing: 8) {
                                    numberExample("1", highlight: .hitColor)
                                    numberExample("3", highlight: .blowColor)
                                    numberExample("5")
                                }
                            }

                            Divider()
                                .background(Color.primaryText.opacity(0.3))
                                .padding(.vertical, 4)

                            // 実際のスコアカードと同様の表示
                            HStack {
                                Text("結果：")
                                    .bodyStyle()

                                Spacer()

                                // ヒット・ブロー表示
                                HStack(spacing: 16) {
                                    // ヒット表示
                                    HStack(spacing: 6) {
                                        Circle()
                                            .fill(Color.hitColor)
                                            .frame(width: 14, height: 14)
                                        Text("1")
                                            .font(.system(size: 18, weight: .bold, design: .rounded))
                                            .foregroundColor(.primaryText)
                                    }

                                    // ブロー表示
                                    HStack(spacing: 6) {
                                        Circle()
                                            .fill(Color.blowColor)
                                            .frame(width: 14, height: 14)
                                        Text("1")
                                            .font(.system(size: 18, weight: .bold, design: .rounded))
                                            .foregroundColor(.primaryText)
                                    }
                                }
                            }
                        }
                        .padding(16)
                        .background(Color.numberButton.opacity(0.2))
                        .cornerRadius(12)
                    }
                    .padding(.vertical, 16)
                    .withCardStyle()
                }
                .withContainerStyle()

                Spacer()

                HStack {
                    Spacer()
                    Button {
                        // ボタンが押されたらGameViewに遷移
                        showGameView = true
                    } label: {
                        Text("ゲームスタート")
                            .buttonTextStyle()
                            .padding(.vertical, 16)
                            .padding(.horizontal, 32)
                            .background(Color.enterButton)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    }
                    Spacer()
                }
                .padding(.bottom, 40)
            }
            .withStandardPadding()
        }
        .navigationBarTitle("ルール", displayMode: .inline)
        // フルスクリーンモーダルでGameViewを表示
        .fullScreenCover(isPresented: $showGameView) {
            // NavigationViewを含めてGameViewを表示
            NavigationView {
                GameView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }

    // 説明項目のヘルパー関数
    private func explainationItem(icon: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.secondaryColor)
                .frame(width: 30)

            Text(text)
                .bodyStyle()
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    // 数字例のヘルパー関数
    private func numberExample(_ number: String, highlight: Color? = nil) -> some View {
        Text(number)
            .font(.system(size: 22, weight: .bold, design: .rounded))
            .foregroundColor(.primaryText)
            .frame(width: 40, height: 40)
            .background(highlight ?? Color.numberButton.opacity(0.3))
            .cornerRadius(8)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutView()
        }
    }
}
