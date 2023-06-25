//
//  GameView.swift
//  SecretNumbers
//
//  Created by Taiyo Koshiba on 2023/05/10.
//


import SwiftUI

// キーボードの要素
private let keybordButtons = [
    ["5","6","7","8","9"],
    ["0","1","2","3","4"]
]

// ゲームの最大回数
private let challengeNumber = 7

// 正解文字の桁数
private let stringLength = 3


struct GameView: View {
    // ディスプレイメッセージ
    @State private var message = "残り\(challengeNumber)回"
    
    // 問題を作る
    // 規定の文字数でランダムな文字の配列を作る関数
    func createCorrectNumbers() -> (Array<String>) {
        // 文字の保存用配列
        var numbers: Set<String> = []
        // 1つの乱数を保存する変数
        var randNumber: Int
        // numbersの要素数が3になるまで繰り返す
        while numbers.count < stringLength {
            // 0から9の範囲で整数の乱数を生成
            randNumber = Int.random(in: 0...9)
            // 文字列に変換して配列に追加
            numbers.insert(String(randNumber))
        }
        // Set型からArray型に変換
        let targetNumString = Array(numbers)
        
        return targetNumString
    }
    
    // 正解の文字を保存する配列
    @State private var correctNumbers:[String] = []
    
    
    // ユーザーの入力を受け付ける
    @State private var userInputNumbers:[String] = ["", "", ""]
    // 入力をチェックする
    @State private var isGameClear = false // ゲームクリアフラグ
    @State private var isGameOver = false // ゲームオーバーフラグ
    @State private var userInputCount = 0 // 入力文字数カウンタ
    @State private var remaining: Int = challengeNumber // ゲームできる回数
    
    // 文字数チェック
    func checkStringLength(_ target: String) -> Bool {
        if userInputCount >= stringLength {
            return true
        } else {
            return false
        }
    }
    
    // 同じ文字じゃないかチェック
    func checkSameString(_ target: String) -> Bool {
        return target == userInputNumbers[0] || target == userInputNumbers[1] || target == userInputNumbers[2]
    }
    
    // すべてのチェックが通った場合のみ入力文字を表示する
    func inputCheck(_ target: String) {
        if isGameClear == true {
            return
        }
        if isGameOver == true {
            return
        }
        if checkStringLength(target) {
            return
        }
        if checkSameString(target) {
            return
        } else {
            userInputNumbers[userInputCount] = "\(target)"
            userInputCount += 1
        }
    }
    
    
    // 正誤判定する
    // ヒット数とブロー数
    @State private var score: [String] = ["", ""]
    
    // ヒット数とブロー数を計算する関数
    func count(array1: [String], array2: [String]) -> (Array<String>) {
        // ヒット数を数える（同じインデックスに同じ要素があるか数える）
        let hitCount = zip(array1, array2).filter{$0 == $1}.count
        
        // ブロー数を数える（配列内のどこかに同じ要素があるか数える）
        var blowCount = array1.filter({$0 == array2[0] || $0 == array2[1] || $0 == array2[2]}).count
        // 同じ要素のカウントからヒット数を引いた値がブロー数
        blowCount = blowCount - hitCount
        
        let myArray = [String(hitCount), String(blowCount)]
        
        return myArray
    }
    
    
    // スコアの構造体
    struct Score: Identifiable {
        var id: Int
        var input: String
        var score: String
    }
    // スコア記録配列
    @State private var Scores: [Score] = []
    
    
    var body: some View {
        VStack {
            Text(message)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(40)
            
            HStack {
                VStack {
                    Text("\(userInputNumbers[0])")
                        .frame(width: 50, height: 50)
                        .font(.title)
                    Text("")
                        .frame(width: 50, height: 1)
                        .background(Color.gray)
                }
                VStack {
                    Text("\(userInputNumbers[1])")
                        .frame(width: 50, height: 50)
                        .font(.title)
                    Text("")
                        .frame(width: 50, height: 1)
                        .background(Color.gray)
                }
                VStack {
                    Text("\(userInputNumbers[2])")
                        .frame(width: 50, height: 50)
                        .font(.title)
                    Text("")
                        .frame(width: 50, height: 1)
                        .background(Color.gray)
                }
            }
            
            
            Spacer()
            
            // 記録表示
            List(Scores) { Score in
                HStack(spacing: 0) {
                    Text("No." + String(Score.id))
                    Spacer()
                    Text(Score.input)
                    Spacer()
                    Text(Score.score)
                }
            }
            .frame(height: 300)
            
            Spacer()
            
            // デバッグ用
            //            Text("\(correctNumbers)" as String)
            
            // キーボード
            ForEach(keybordButtons, id:\.self) { row in
                HStack() {
                    ForEach(row, id:\.self) { col in
                        Button("\(col)", action:{
                            // 入力チェック
                            inputCheck(col)
                        })
                        .frame(width: 50, height: 50)
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .font(.title)
                        .cornerRadius(20)
                        .padding(4)
                    }
                }
            }
            
            HStack {
                Spacer()
                
                // 消去ボタン
                Button(action: {
                    // ゲームクリアかゲームオーバーの場合は何もしない。
                    if(isGameClear == true || isGameOver == true) {
                        return
                    } else {
                        // 配列を初期化
                        userInputNumbers = ["", "", ""]
                        // 入力文字カウントを初期化
                        userInputCount = 0
                    }
                }){
                    Text("Clear")
                        .padding(15)
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .font(.title)
                        .cornerRadius(20)
                }
                
                Spacer()
                
                // 判定ボタン
                Button(action: {
                    // 正誤判定処理
                    if isGameClear || isGameOver || userInputCount != 3 {
                        return
                    }
                    // ゲームカウンタをデクリメントする
                    remaining -= 1
                    // ゲームカウンタが0の場合はゲームオーバー
                    if(remaining == 0) {
                        isGameOver = true
                    }
                    
                    // ヒット数とブロー数を数える
                    score = count(array1:userInputNumbers, array2:correctNumbers)
                    
                    // 記録を追加する
                    Scores.insert(
                        Score(
                            id: Scores.count+1,
                            input: userInputNumbers[0]+userInputNumbers[1]+userInputNumbers[2],
                            score: score[0]+"ヒット "+score[1]+"ブロー"
                        )
                        ,at: 0
                    )
                    
                    
                    if(score[0] == "3") {
                        isGameClear = true
                        message = "クリア！ \(challengeNumber - remaining)回"
                    } else if(isGameOver == true){
                        message = "ゲームオーバー"
                    } else {
                        message = "残り\(remaining)回"
                        
                        // ユーザー入力を消去する
                        userInputNumbers = ["", "", ""]
                        // 入力文字のカウントを初期化
                        userInputCount = 0
                    }
                }){
                    Text("Enter")
                        .padding(15)
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .font(.title)
                        .cornerRadius(20)
                }
                
                Spacer()
            }
            Spacer()
            
        }
        // 画面が読み込まれた時の処理
        .onAppear {
            Task {
                // 問題の番号を作る
                correctNumbers = createCorrectNumbers()
                
                // 5秒間入力が無かったらアラートを表示する
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    if userInputCount == 0 {
                        message = "入力してください"
                    }
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
