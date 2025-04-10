//
//  GameView.swift
//  SecretNumbers
//
//  Created by Taiyo KOSHIBA on 2025/04/10.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        ZStack {
            // 背景
            GameConstants.Colors.background
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // ステータスメッセージ
                Text(viewModel.message)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                
                // 入力数字表示
                GameGrid(numbers: viewModel.userInput)
                
                // スコア履歴
                ScoreList(scores: viewModel.scores)
                    .frame(height: 300)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                    .padding()
                
                // デバッグ用（コメントアウト）
                // Text(viewModel.debugCorrectNumbers())
                //    .foregroundColor(.white)
                
                // キーパッド
                NumberKeypad(
                    onDigitPressed: { digit in
                        viewModel.digitPressed(digit)
                    },
                    onClear: {
                        viewModel.clearInput()
                    },
                    onEnter: {
                        viewModel.submitInput()
                    },
                    isDisabled: viewModel.isGameCleared || viewModel.isGameOver
                )
                
                // リスタートボタン（ゲーム終了時のみ表示）
                if viewModel.isGameCleared || viewModel.isGameOver {
                    Button(action: {
                        viewModel.resetGame()
                    }) {
                        Text("もう一度プレイ")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom)
                }
            }
        }
        .onAppear {
            // 5秒間入力が無かったらアラートを表示
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                if viewModel.inputCount == 0 && !viewModel.isGameCleared && !viewModel.isGameOver {
                    viewModel.message = "入力してください"
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
