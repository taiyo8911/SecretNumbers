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
            // 背景色
            Color(red: 0, green: 255, blue: 0)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.1)
            
            VStack {
                // タイトル表示
                Text("遊び方")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(20)

                Text(
                """
                3桁の数字を当てるゲームです。
                すべて違う数字です。
                数字と場所の両方が合っている場合はヒット、数字のみ合っている場合はブローと表示します。
                例えば、正解が123の場合、135は1ヒット、1ブローです。
                """)
                    .padding(60)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
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
