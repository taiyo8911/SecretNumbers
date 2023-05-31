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
                .ignoresSafeArea()
            
            // ルール説明
            VStack {
                Text("ルール")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(20)
                
                Text(
                """
                3桁の異なる数字を当てるゲームです。
                数字と場所の両方が合っている場合はヒット、数字のみ合っている場合はブローと表示します。
                例えば、正解が123の場合、135は1ヒット、1ブローです。
                """)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(40)
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
