//
//  GameResultOverlay.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//


import SwiftUI

struct GameResultOverlay: View {
    enum ResultType {
        case win
        case lose
    }
    
    let resultType: ResultType
    let correctNumbers: [String]
    let attempts: Int
    let onNewGame: () -> Void
    
    // アニメーション用の状態変数
    @State private var opacity = 0.0
    @State private var scale = 0.8
    @State private var showConfetti = false
    
    var body: some View {
        ZStack {
            // 半透明の背景
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
                .opacity(opacity)
                .onTapGesture {
                    // 背景タップでアニメーション終了
                    withAnimation {
                        opacity = 0
                    }
                }
            
            // 結果表示カード
            VStack(spacing: 24) {
                // 勝敗アイコンとタイトル
                Image(systemName: resultType == .win ? "trophy.fill" : "xmark")
                    .font(.system(size: 60))
                    .foregroundColor(resultType == .win ? .yellow : .red)
                    .padding(.top, 24)
                
                Text(resultType == .win ? "クリア！" : "ゲームオーバー")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.primaryText)

                // 正解表示
                VStack(spacing: 8) {
                    if resultType == .lose {
                        Text("正解は")
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.primaryText.opacity(0.8))
                    }

                    HStack(spacing: 12) {
                        ForEach(0..<correctNumbers.count, id: \.self) { index in
                            Text(correctNumbers[index])
                                .font(.system(size: 32, weight: .bold, design: .monospaced))
                                .foregroundColor(.primaryText)
                                .frame(width: 60, height: 60)
                                .background(
                                    resultType == .win ? 
                                        Color.hitColor.opacity(0.5) : 
                                        Color.numberButton.opacity(0.5)
                                )
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                        }
                    }
                }
                .padding(.vertical, 16)
                
                // 結果詳細
                if resultType == .win {
                    Text("\(attempts)回目で正解!")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(.primaryText)
                } else {
                    Text("また挑戦してみよう！")
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .foregroundColor(.primaryText)
                }
                
//                // 新しいゲームボタン
//                Button {
//                    // アニメーションで消す
//                    withAnimation(.easeInOut(duration: 0.3)) {
//                        opacity = 0
//                        scale = 0.8
//                    }
//                    
//                    // 少し待ってから新しいゲームを開始
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                        onNewGame()
//                    }
//                } label: {
//                    Text("もう一度遊ぶ")
//                        .font(.system(size: 20, weight: .bold, design: .rounded))
//                        .foregroundColor(.primaryText)
//                        .padding(.vertical, 14)
//                        .padding(.horizontal, 32)
//                        .background(Color.primaryColor)
//                        .cornerRadius(20)
//                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
//                }
//                .padding(.vertical, 16)

                // 新しいゲームボタン
                Button {
                    // まず直接コールバックを呼び出し
                    onNewGame()

                    // アニメーションで消す
                    withAnimation(.easeInOut(duration: 0.3)) {
                        opacity = 0
                        scale = 0.8
                    }
                } label: {
                    Text("もう一度遊ぶ")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.primaryText)
                        .padding(.vertical, 14)
                        .padding(.horizontal, 32)
                        .background(Color.primaryColor)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
                }
                .padding(.vertical, 16)
            }
            .frame(width: 320)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.gradientStart.opacity(0.9))
                    .shadow(color: Color.black.opacity(0.3), radius: 16, x: 0, y: 8)
            )
            .overlay(
                // リップル効果（勝利時のみ）
                resultType == .win ? RippleEffect() : nil
            )
            .scaleEffect(scale)
            .opacity(opacity)
            
            // 紙吹雪（勝利時のみ）
            if resultType == .win && showConfetti {
                ConfettiView()
                    .opacity(opacity)
            }
        }
        .onAppear {
            // 表示アニメーション
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                opacity = 1
                scale = 1
            }
            
            // 勝利時は紙吹雪を少し遅れて表示
            if resultType == .win {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    showConfetti = true
                }
            }
        }
    }
}

// リップルエフェクト（勝利演出用）
struct RippleEffect: View {
    @State private var animating = false
    
    var body: some View {
        ZStack {
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .stroke(Color.yellow.opacity(0.5), lineWidth: 2)
                    .scaleEffect(animating ? 1.2 + CGFloat(index) * 0.1 : 0.8)
                    .opacity(animating ? 0 : 0.6)
                    .animation(
                        Animation.easeOut(duration: 1.2)
                            .repeatForever(autoreverses: false)
                            .delay(Double(index) * 0.2),
                        value: animating
                    )
            }
        }
        .onAppear {
            animating = true
        }
    }
}

// 紙吹雪エフェクト（勝利演出用）
struct ConfettiView: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Canvas { context, size in
            // 紙吹雪の描画
            for _ in 0..<100 {
                let x = CGFloat.random(in: 0...size.width)
                let y = CGFloat.random(in: 0...size.height) - size.height * CGFloat(animationAmount)
                let size = CGFloat.random(in: 5...10)
                let color = [Color.red, Color.blue, Color.green, Color.yellow, Color.orange, Color.purple][Int.random(in: 0...5)]
                
                let rectangle = Path(ellipseIn: CGRect(x: x, y: y, width: size, height: size))
                context.fill(rectangle, with: .color(color))
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                animationAmount = 1.0
            }
        }
    }
}

struct GameResultOverlay_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)

            // 正解のパターン
            GameResultOverlay(
                resultType: .win,
                correctNumbers: ["1", "2", "3"],
                attempts: 4,
                onNewGame: {}
            )

            // 不正解のパターン
//            GameResultOverlay(
//                resultType: .lose,
//                correctNumbers: ["1", "2", "3"],
//                attempts: 4,
//                onNewGame: {}
//            )
        }
    }
}

