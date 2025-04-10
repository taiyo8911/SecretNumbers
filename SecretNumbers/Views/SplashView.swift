//
//  SplashView.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var opacity = 0.0
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            // 背景
            GameConstants.Colors.background
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                // アイコン
                HStack {
                    Image(systemName: "questionmark.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                    Image(systemName: "questionmark.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                    Image(systemName: "questionmark.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                }

                // ローディングテキスト
                Text("シークレットナンバーズ")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                
                // ロード中インジケーター
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
            }
            .opacity(opacity)
            .onAppear {
                // アニメーション付きでフェードイン
                withAnimation(.easeIn(duration: 1.0)) {
                    self.opacity = 1.0
                }
                
                // 遅延してメイン画面に遷移
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isActive = true
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $isActive) {
            MainView()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
