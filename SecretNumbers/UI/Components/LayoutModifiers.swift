//
//  LayoutModifiers.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//

import SwiftUI

// 標準的な画面パディングを適用するViewModifier
struct StandardPadding: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
    }
}

// セクション間のスペースを適用するViewModifier
struct SectionSpacing: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 24)
    }
}

// カード的なスタイルを適用するViewModifier
struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(16)
            .background(Color.numberButton.opacity(0.3))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

// コンテナスタイルを適用するViewModifier
struct ContainerStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(20)
            .background(Color.primaryColor.opacity(0.1))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
    }
}

// 拡張を使って適用を簡単にする
extension View {
    func withStandardPadding() -> some View {
        self.modifier(StandardPadding())
    }

    func withSectionSpacing() -> some View {
        self.modifier(SectionSpacing())
    }

    func withCardStyle() -> some View {
        self.modifier(CardStyle())
    }

    func withContainerStyle() -> some View {
        self.modifier(ContainerStyle())
    }
}
