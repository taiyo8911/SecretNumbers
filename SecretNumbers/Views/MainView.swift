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
                // 背景グラデーション
                GameConstants.Colors.background
                    .edgesIgnoringSafeArea(.all)

                // コンテンツ
                VStack(spacing: 30) {

                    Spacer()

                    // アイコン
                    Image(systemName: "questionmark")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .padding(.top, 40)
                    
                    // タイトル
                    Text("シークレットナンバーズ")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                    
                    // サブタイトル
                    Text("隠された\(GameConstants.digitCount)つの数字を当てろ！")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.bottom, 30)
                    
                    // ボタングループ
                    VStack(spacing: 24) {
                        // プレイボタン
                        NavigationLink(destination: GameView()) {
                            Text("遊ぶ")
                                .font(.headline)
                                .frame(width: 200, height: 60)
                                .background(Color.white)
                                .foregroundColor(.blue)
                                .cornerRadius(15)
                                .shadow(radius: 10)
                        }
                        
                        // ルールボタン
                        NavigationLink(destination: AboutView()) {
                            Text("ルール")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 200, height: 60)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                        }
                    }
                    
                    Spacer()
                }
                .padding()
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
