//
//  SplashView.swift
//  SecretNumbers
//
//  Created by Taiyo Koshiba on 2023/05/30.
//

import SwiftUI

struct SplashView: View {
    @State private var isLoading = true
    @State private var isActive = false
    
    var body: some View {
        VStack {
            Text("シークレットナンバーズ")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // ローディングインジケータを表示
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
                    .foregroundColor(.white)
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            // ここで非同期処理やデータの読み込みなどの処理を実行
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isLoading = false
                isActive = true
            }
        }
        .fullScreenCover(isPresented: $isActive, content: {
            MainView()
        })
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
