//
//  MainView.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//


import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // 統一された背景グラデーション
                BackgroundGradient()

                VStack(spacing: 24) {
                    Spacer()

                    // アプリアイコン
                    Image(systemName: "number.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                        .foregroundColor(.primaryText)
                        .padding(.bottom, 16)

                    // タイトル
                    Text("シークレットナンバーズ")
                        .titleStyle()
                        .padding(.bottom, 8)

                    // サブタイトル
                    Text("隠された3つの数字を当てろ！")
                        .subtitleStyle()
                        .padding(.bottom, 40)

                    // メインナビゲーションボタン
                    VStack(spacing: 20) {
                        NavigationLink(destination: GameView()) {
                            Text("遊ぶ")
                                .buttonTextStyle()
                                .frame(width: 220)
                                .padding(.vertical, 14)
                                .background(Color.primaryColor)
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        }

                        NavigationLink(destination: AboutView()) {
                            Text("ルール")
                                .buttonTextStyle()
                                .frame(width: 220)
                                .padding(.vertical, 14)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.primaryText, lineWidth: 2)
                                )
                        }
                    }
                    .withSectionSpacing()

                    Spacer()
                }
                .withStandardPadding()
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
