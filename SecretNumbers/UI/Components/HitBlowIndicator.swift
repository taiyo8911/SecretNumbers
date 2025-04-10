//
//  HitBlowIndicator.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//


import SwiftUI

struct HitBlowIndicator: View {
    let hits: Int
    let blows: Int
    let animated: Bool
    
    // アニメーション用の状態変数
    @State private var showHits = false
    @State private var showBlows = false
    
    var body: some View {
        HStack(spacing: 16) {
            // ヒット表示
            HStack(spacing: 8) {
                // ヒットのアイコン
                Image(systemName: "circle.fill")
                    .foregroundColor(.hitColor)
                    .opacity(0.9)
                    .scaleEffect(showHits ? 1.0 : 0.5)
                    .animation(animated ? .spring(response: 0.3, dampingFraction: 0.6).delay(0.1) : .default, value: showHits)
                
                // ヒット数
                Text("\(hits)")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.primaryText)
                    .opacity(showHits ? 1.0 : 0.0)
                    .animation(animated ? .easeIn.delay(0.2) : .default, value: showHits)
                
                Text("Hit")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.primaryText.opacity(0.7))
                    .opacity(showHits ? 1.0 : 0.0)
                    .animation(animated ? .easeIn.delay(0.3) : .default, value: showHits)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.hitColor.opacity(0.2))
                    .scaleEffect(showHits ? 1.0 : 0.8, anchor: .leading)
                    .animation(animated ? .spring(response: 0.4, dampingFraction: 0.7) : .default, value: showHits)
            )
            
            // ブロー表示
            HStack(spacing: 8) {
                // ブローのアイコン
                Image(systemName: "circle")
                    .foregroundColor(.blowColor)
                    .opacity(0.9)
                    .scaleEffect(showBlows ? 1.0 : 0.5)
                    .animation(animated ? .spring(response: 0.3, dampingFraction: 0.6).delay(0.3) : .default, value: showBlows)
                
                // ブロー数
                Text("\(blows)")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.primaryText)
                    .opacity(showBlows ? 1.0 : 0.0)
                    .animation(animated ? .easeIn.delay(0.4) : .default, value: showBlows)
                
                Text("Blow")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.primaryText.opacity(0.7))
                    .opacity(showBlows ? 1.0 : 0.0)
                    .animation(animated ? .easeIn.delay(0.5) : .default, value: showBlows)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.blowColor.opacity(0.2))
                    .scaleEffect(showBlows ? 1.0 : 0.8, anchor: .leading)
                    .animation(animated ? .spring(response: 0.4, dampingFraction: 0.7).delay(0.2) : .default, value: showBlows)
            )
        }
        .onAppear {
            if animated {
                // 表示アニメーションを開始
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    showHits = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    showBlows = true
                }
            } else {
                // アニメーションなしですぐに表示
                showHits = true
                showBlows = true
            }
        }
    }
}

struct HitBlowIndicator_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            HitBlowIndicator(hits: 2, blows: 1, animated: true)
            HitBlowIndicator(hits: 0, blows: 3, animated: false)
            HitBlowIndicator(hits: 3, blows: 0, animated: true)
        }
        .padding()
        .background(Color.black)
        .previewLayout(.sizeThatFits)
    }
}