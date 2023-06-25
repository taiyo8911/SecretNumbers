//
//  AboutView.swift
//  SecretNumbers
//
//  Created by Taiyo Koshiba on 2023/05/10.
//


import SwiftUI

// ルール説明画面
struct AboutView: View {
    var body: some View {
        ZStack {
            // 背景
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
            
            // ルール説明
            VStack {
                Text("遊び方")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontWeight(.bold)
                    .padding(40)
                
                
                Text(
                """
                3桁の数字を推測して下さい。
                チャンスは7回です。
                数字と場所の両方が合っている場合はヒット、数字のみ合っている場合はブローと表示します。
                例えば正解が「123」の場合「135」は「1ヒット、1ブロー」です。
                """)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(40)
                
                // GameViewへのリンクボタン
                NavigationLink(destination: GameView()) {
                    Text("ゲームスタート")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(40)
                        .padding(40)
                }
                
               
                
                Spacer()
            }
        }
    }
}


struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
