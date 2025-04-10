//
//  DifficultySettingsView.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//

import SwiftUI

// 難易度の定義
enum GameDifficulty: String, CaseIterable, Identifiable {
    case easy = "かんたん"
    case normal = "ふつう"
    case hard = "むずかしい"
    case expert = "エキスパート"

    var id: String { self.rawValue }

    // 桁数
    var digitCount: Int {
        switch self {
            case .easy: return 3
            case .normal: return 3
            case .hard: return 4
            case .expert: return 5
        }
    }

    // 制限回数
    var maxAttempts: Int {
        switch self {
            case .easy: return 10
            case .normal: return 7
            case .hard: return 8
            case .expert: return 10
        }
    }

    // 制限時間（秒）、0は無制限
    var timeLimit: Int {
        switch self {
            case .easy: return 0
            case .normal: return 0
            case .hard: return 180
            case .expert: return 240
        }
    }

    // 説明文
    var description: String {
        switch self {
            case .easy:
                return "3桁の数字を当てる。制限回数は10回。"
            case .normal:
                return "3桁の数字を当てる。制限回数は7回。"
            case .hard:
                return "4桁の数字を当てる。制限回数は8回。制限時間3分。"
            case .expert:
                return "5桁の数字を当てる。制限回数は10回。制限時間4分。"
        }
    }
}

struct DifficultySettingsView: View {
    @Binding var selectedDifficulty: GameDifficulty
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            // 背景
            BackgroundGradient()

            VStack(spacing: 24) {
                // タイトル
                Text("難易度設定")
                    .titleStyle()
                    .padding(.top, 40)

                // 難易度選択
                VStack(spacing: 16) {
                    ForEach(GameDifficulty.allCases) { difficulty in
                        DifficultyButton(
                            difficulty: difficulty,
                            isSelected: selectedDifficulty == difficulty,
                            action: {
                                withAnimation {
                                    selectedDifficulty = difficulty
                                }
                            }
                        )
                    }
                }
                .padding(.vertical, 24)

                // 選択した難易度の説明
                VStack(alignment: .leading, spacing: 8) {
                    Text("難易度: \(selectedDifficulty.rawValue)")
                        .subtitleStyle()

                    Text(selectedDifficulty.description)
                        .bodyStyle()
                        .fixedSize(horizontal: false, vertical: true)

                    // 桁数表示
                    HStack {
                        Text("桁数:")
                            .foregroundColor(.primaryText)
                            .font(.system(size: 16, weight: .semibold))

                        HStack(spacing: 8) {
                            ForEach(0..<selectedDifficulty.digitCount, id: \.self) { _ in
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.numberButton.opacity(0.4))
                                    .frame(width: 32, height: 32)
                            }
                        }
                    }
                    .padding(.top, 8)

                    // 制限時間表示（あれば）
                    if selectedDifficulty.timeLimit > 0 {
                        HStack {
                            Image(systemName: "timer")
                                .foregroundColor(.secondaryColor)

                            Text("制限時間: \(formatTime(selectedDifficulty.timeLimit))")
                                .foregroundColor(.primaryText)
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .padding(.top, 4)
                    }
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.numberButton.opacity(0.2))
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                )
                .padding(.horizontal, 16)

                Spacer()

                // 確定ボタン
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("確定")
                        .buttonTextStyle()
                        .padding(.vertical, 16)
                        .padding(.horizontal, 40)
                        .background(Color.enterButton)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                }
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 24)
        }
        .navigationBarTitle("難易度設定", displayMode: .inline)
    }

    // 秒数をmm:ss形式にフォーマット
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
}

// 難易度選択ボタン
struct DifficultyButton: View {
    let difficulty: GameDifficulty
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(difficulty.rawValue)
                    .foregroundColor(.primaryText)
                    .font(.system(size: 18, weight: .bold, design: .rounded))

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.enterButton)
                        .font(.system(size: 22))
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.numberButton.opacity(isSelected ? 0.5 : 0.2))
                    .shadow(color: Color.black.opacity(isSelected ? 0.15 : 0.05),
                            radius: isSelected ? 4 : 2,
                            x: 0,
                            y: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal, 16)
    }
}

struct DifficultySettings_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DifficultySettingsView(
                selectedDifficulty: .constant(.normal)
            )
        }
    }
}
