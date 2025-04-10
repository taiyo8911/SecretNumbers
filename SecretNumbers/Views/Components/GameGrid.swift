//
//  GameGrid.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//


import SwiftUI

/// 入力数字表示コンポーネント
struct GameGrid: View {
    /// 表示する数字
    let numbers: [String]
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(0..<numbers.count, id: \.self) { index in
                VStack {
                    Text(numbers[index])
                        .frame(width: 50, height: 50)
                        .font(.title)
                    
                    Text("")
                        .frame(width: 50, height: 1)
                        .background(Color.gray)
                }
            }
        }
        .padding()
    }
}

/// スコア表示コンポーネント
struct ScoreList: View {
    /// 表示するスコア
    let scores: [Score]
    
    var body: some View {
        List {
            ForEach(scores) { score in
                HStack(spacing: 0) {
                    Text("No.\(score.id)")
                    Spacer()
                    Text(score.input)
                    Spacer()
                    Text(score.scoreText)
                }
                .font(.system(size: 16, weight: .medium))
                .padding(.vertical, 4)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct GameComponents_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameGrid(numbers: ["1", "2", "3"])
                .previewLayout(.sizeThatFits)
                .previewDisplayName("GameGrid")
            
            ScoreList(scores: [
                Score(id: 1, input: "123", hitCount: 1, blowCount: 1),
                Score(id: 2, input: "456", hitCount: 0, blowCount: 2)
            ])
            .frame(height: 200)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("ScoreList")
        }
    }
}
