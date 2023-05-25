//
//  GameView.swift
//  SecretNumbers
//
//  Created by Taiyo Koshiba on 2023/05/10.
//


import SwiftUI

struct GameView: View {
    // ボタンの配置用テキスト
    let viewButtonNumbers = [
        ["5","6","7","8","9"],
        ["0","1","2","3","4"]
    ]
    
    // メッセージ内容
    @State var message = "残り10回"
    
    
    // 正解番号の数
    let stringMaxDigit = 3
    
    // 正解番号
    @State var targetNumbers: Array<String> = []
    
    // 正解番号を作る関数
    func createTargetNumbers() -> (Array<String>) {
        // 乱数の保存用配列
        var numbers: Set<String> = []
        // 1つの乱数を保存する変数
        var randNumber: Int
        // numbersの要素数が3になるまで繰り返す
        while numbers.count < stringMaxDigit {
            // 0から9の範囲で整数の乱数を生成
            randNumber = Int.random(in: 0...9)
            // 文字列に変換して配列に追加
            numbers.insert(String(randNumber))
        }
        // Set型からArray型に変換
        let targetNumString = Array(numbers)
        
        return targetNumString
    }
    
    
    // ユーザーの入力番号を保存する配列
    @State var userInputNumbers:[String] = ["", "", ""]
    
    // ユーザーの入力数のカウンター
    @State var userInputCount = 0
    
    
    // ヒット数とブロー数
    @State var score: [String] = ["", ""]
    
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
    
    // ゲームできる回数
    @State var remaining: Int = 10
    
    // ゲームクリアフラグ
    @State var isGameClear = false
    // ゲームオーバーフラグ
    @State var isGameOver = false
    
    
    struct Score: Identifiable {
        var id: Int
        var input: String
        var score: String
    }
    
    
    // 記録用配列
    @State var Scores: [Score] = []
    
    var body: some View {
        VStack {
            Text(message)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(40)

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
            .frame(height: 200)
            
            Spacer()
            
            // デバッグ用
//            Text("\(targetNumbers)" as String)
            
            // ユーザー入力の表示
            Text(userInputNumbers[0]+userInputNumbers[1]+userInputNumbers[2])
                .frame(width: 300, height: 50)
                .background(Color.black)
                .foregroundColor(Color.white)
                .font(.title)
        
            Spacer()

            
            // ユーザー入力用数字ボタン
            ForEach(viewButtonNumbers, id:\.self) { row in
                HStack(spacing:10) {
                    ForEach(row, id:\.self) { col in
                        Button("\(col)", action:{
                            // 入力制限
                            // ゲームクリアしていない、ゲームオーバーでもない場合に処理をする。それ以外は何もしない。
                            if(isGameClear == false && isGameOver == false) {
                                // 入力した数字が同じじゃない場合
                                if(col != userInputNumbers[0] && col != userInputNumbers[1]){
                                    // 文字数が3文字未満の場合
                                    if(userInputCount < stringMaxDigit) {
                                        // 入力を受け付ける
                                        userInputNumbers[userInputCount] = "\(col)"
                                        userInputCount += 1
                                    }
                                }
                            }
                            
                        })
                        .frame(width: 50, height: 50)
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .font(.title)
                        .cornerRadius(20)
                        .padding(5)
                    }
                }
            }
            
            
            Spacer()

            
            HStack {
                
                Spacer()
                
                // 消去ボタン
                Button(action: {
                    // クリア処理
                    // ゲームクリアしていない、ゲームオーバーでもない場合に処理をする。それ以外は何もしない。
                    if(isGameClear == false && isGameOver == false) {
                        // 配列を初期化
                        userInputNumbers = ["", "", ""]
                        // 入力文字のカウントを初期化
                        userInputCount = 0
                    }
                    
                }){
                    Text("消去")
                        .padding(20)
                        .background(Color.orange)
                        .foregroundColor(Color.white)
                        .font(.title)
                }
                
                
                Spacer()
                
                // 判定ボタン
                Button(action: {
                    // 正誤判定処理
                    // クリアしていない、ゲームオーバーでもない、入力が3文字の場合に処理をする。それ以外は何もしない。
                    if(isGameClear == false && isGameOver == false && userInputCount == 3) {
                        // ゲーム回数をデクリメントする
                        remaining -= 1
                        // ゲーム残り回数が0の場合はゲームオーバー
                        if(remaining == 0) {
                            isGameOver = true
                        }
                        
                        // ヒット数とブロー数を数える
                        score = count(array1:userInputNumbers, array2:targetNumbers)
                        
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
                            message = "クリア！ \(10 - remaining)回"
                        } else if(isGameOver == true){
                            message = "ゲームオーバー"
                        } else {
                            message = "残り\(remaining)回"
                                                        
                            // ユーザー入力を消去する
                            userInputNumbers = ["", "", ""]
                            // 入力文字のカウントを初期化
                            userInputCount = 0
                        }
                    }
                }){
                    Text("判定")
                        .padding(20)
                        .background(Color.orange)
                        .foregroundColor(Color.white)
                        .font(.title)
                }
                
                Spacer()
            }
            Spacer()
            
        }
        .onAppear {
            Task {
                // 画面が読み込まれたら正解の番号を作る
                targetNumbers = createTargetNumbers()
            }
        }
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
