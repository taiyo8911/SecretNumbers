//
//  AnimatedNumberInputCell.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//


import SwiftUI

struct AnimatedNumberInputCell: View {
    let value: String
    let isActive: Bool

    // アニメーション用の状態変数
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0
    @State private var rotationDegrees: Double = 0

    var body: some View {
        Text(value.isEmpty ? " " : value)
            .font(.system(size: 36, weight: .bold, design: .rounded))
            .foregroundColor(.primaryText)
            .frame(width: 70, height: 70)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.numberButton.opacity(isActive ? 0.5 : 0.3))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primaryText.opacity(isActive ? 0.5 : 0.3), lineWidth: 2)
            )
            .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
            .scaleEffect(scale)
            .opacity(opacity)
            .rotation3DEffect(
                .degrees(rotationDegrees),
                axis: (x: 0, y: 1, z: 0)
            )
            .onChange(of: value) { _ in
                if !value.isEmpty {
                    // 数字が入力されたときのアニメーション
                    playInputAnimation()
                }
            }
    }

    // 数字入力時のアニメーション
    private func playInputAnimation() {
        // アニメーションの連鎖

        // まず少し拡大
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            scale = 1.2
        }

        // 元のサイズに戻す
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.6)) {
                scale = 1.0
            }
        }

        // 同時に回転アニメーションも実行
        withAnimation(.easeInOut(duration: 0.3)) {
            rotationDegrees = 360
        }

        // 回転をリセット（アニメーションなし）
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            rotationDegrees = 0
        }
    }
}

struct AnimatedNumberInputCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            HStack(spacing: 16) {
                // 空のセル（アクティブ状態）
                AnimatedNumberInputCell(value: "", isActive: true)

                // 入力済みのセル
                AnimatedNumberInputCell(value: "5", isActive: false)
            }
            .padding()
        }
    }
}
