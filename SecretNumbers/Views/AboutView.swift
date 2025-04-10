//
//  AboutView.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//


import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            // 背景
            GameConstants.Colors.background
                .edgesIgnoringSafeArea(.all)
            
            // ルール説明
            VStack(alignment: .leading, spacing: 20) {
                Text("遊び方")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                Text("""
                \(GameConstants.digitCount)桁の数字を推測して下さい。
                チャンスは\(GameConstants.maxAttempts)回です。
                
                数字と場所の両方が合っている場合はヒット、
                数字のみ合っている場合はブローと表示します。
                
                例えば正解が「123」の場合「135」は「1ヒット、1ブロー」です。
                
                同じ数字は使えません。
                """)
                .foregroundColor(.white)
                .fontWeight(.medium)
                .lineSpacing(8)
                
                Spacer()
                
                NavigationLink(destination: GameView()) {
                    Text("ゲームスタート")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(20)
                }
                .padding(.bottom, 20)
            }
            .padding(30)
        }
        .navigationTitle("ルール")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutView()
        }
    }
}
