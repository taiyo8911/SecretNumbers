//
//  CommonComponents.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//

import SwiftUI

// 標準的な背景グラデーション
struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [.gradientStart, .gradientEnd]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all)
    }
}

// 標準的なプライマリボタン
struct PrimaryButton: View {
    let text: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .buttonTextStyle()
                .frame(maxWidth: 200)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .background(Color.primaryColor)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        }
    }
}

// 標準的なセカンダリボタン
struct SecondaryButton: View {
    let text: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .buttonTextStyle()
                .frame(maxWidth: 200)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.primaryText, lineWidth: 2)
                )
        }
    }
}

// 数字キーボタン
struct NumberButton: View {
    let number: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(number)
                .buttonTextStyle()
                .frame(width: 60, height: 60)
                .background(Color.numberButton)
                .cornerRadius(30)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
        }
    }
}

// 機能ボタン（Clear/Enterなど）
struct FunctionButton: View {
    let text: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .buttonTextStyle()
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .background(color)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
        }
    }
}

// 数字表示セル
struct NumberCell: View {
    let value: String
    let isHit: Bool
    let isBlow: Bool

    var body: some View {
        Text(value)
            .numberDisplayStyle()
            .frame(width: 60, height: 60)
            .background(
                backgroundColor
                    .opacity(value.isEmpty ? 0.3 : 0.8)
            )
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primaryText.opacity(0.3), lineWidth: 2)
            )
    }

    private var backgroundColor: Color {
        if isHit {
            return .hitColor
        } else if isBlow {
            return .blowColor
        } else {
            return Color.numberButton
        }
    }
}

// プレビュー
struct CommonComponents_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BackgroundGradient()
                .previewLayout(.sizeThatFits)
                .padding()

            PrimaryButton(text: "Start Game", action: {})
                .previewLayout(.sizeThatFits)
                .padding()

            SecondaryButton(text: "Cancel", action: {})
                .previewLayout(.sizeThatFits)
                .padding()

            NumberButton(number: "1", action: {})
                .previewLayout(.sizeThatFits)
                .padding()

            FunctionButton(text: "Clear", color: Color.red, action: {})
                .previewLayout(.sizeThatFits)
                .padding()

            NumberCell(value: "5", isHit: true, isBlow: false)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
