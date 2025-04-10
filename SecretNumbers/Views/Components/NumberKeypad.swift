//
//  NumberKeypad.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//

import SwiftUI

/// 数字キーパッドコンポーネント
struct NumberKeypad: View {
    /// 数字キーが押された時の処理
    let onDigitPressed: (String) -> Void
    
    /// クリアボタンが押された時の処理
    let onClear: () -> Void
    
    /// 決定ボタンが押された時の処理
    let onEnter: () -> Void
    
    /// キーパッドが無効かどうか
    let isDisabled: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            // 数字キー
            ForEach(GameConstants.keypadLayout, id: \.self) { row in
                HStack(spacing: 8) {
                    ForEach(row, id: \.self) { digit in
                        Button(action: {
                            onDigitPressed(digit)
                        }) {
                            Text(digit)
                                .frame(width: 50, height: 50)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .font(.title)
                                .cornerRadius(20)
                        }
                        .disabled(isDisabled)
                    }
                }
            }
            
            // クリア・決定ボタン
            HStack(spacing: 20) {
                Button(action: onClear) {
                    Text("Clear")
                        .padding(15)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .font(.title)
                        .cornerRadius(20)
                }
                .disabled(isDisabled)
                
                Button(action: onEnter) {
                    Text("Enter")
                        .padding(15)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .font(.title)
                        .cornerRadius(20)
                }
                .disabled(isDisabled)
            }
            .padding(.top, 8)
        }
        .padding()
    }
}

struct NumberKeypad_Previews: PreviewProvider {
    static var previews: some View {
        NumberKeypad(
            onDigitPressed: { _ in },
            onClear: {},
            onEnter: {},
            isDisabled: false
        )
        .previewLayout(.sizeThatFits)
    }
}
