////
////  PlayView.swift
////  SecretNumbers
////
////  Created by Taiyo Koshiba on 2023/06/14.
////
//
//import SwiftUI
//
//// 文字数
//private let stringLength = 3
//
//// チャレンジ回数の定義
//private let challengeNumber = 5
//
//// 入力数カウント
//private var userInputCount = 0
//
//// チャレンジ数カウント
//private var challengeCount = 0
//
//
//// ボタンの配置用テキスト
//private let viewButtonNumbers = [
//    ["5","6","7","8","9"],
//    ["0","1","2","3","4"]
//]
//
//
//
//
//struct PlayView: View {
//    // 初期化
//    func initializ() {
//        targetNumbers = [] // 正解の番号
//        userInputCount = 0 // 入力数カウンタ
//        challengeCount = 0 // 挑戦数カウンタ
//    }
//
//    // 問題を作る
//    @State private var targetNumbers: Array<String> = [] // 正解の番号
//
//    // 正解番号を作る関数
//    func createTargetNumbers() -> (Array<String>) {
//        // 乱数の保存用配列
//        var numbers: Set<String> = []
//        // 1つの乱数を保存する変数
//        var randNumber: Int
//        // numbersの要素数が3になるまで繰り返す
//        while numbers.count < stringLength {
//            // 0から9の範囲で整数の乱数を生成
//            randNumber = Int.random(in: 0...9)
//            // 文字列に変換して配列に追加
//            numbers.insert(String(randNumber))
//        }
//        // Set型からArray型に変換
//        let targetNumString = Array(numbers)
//
//        return targetNumString
//    }
//
//
//    // 入力を受け付ける
//    // ユーザ入力値
//    @State private var userInputNumbers = [
//        ["", "", ""],
//        ["", "", ""],
//        ["", "", ""],
//        ["", "", ""],
//        ["", "", ""],
//    ]
//
//
//    // 入力をチェックする
//    @State private var isClear = false // クリアフラグ
//    @State private var isGameOver = false // ゲームオーバーフラグ
//
//    // 文字数チェック
//    func checkstringLength(_ target: String) -> Bool {
//        if userInputCount >= stringLength {
//            return true
//        } else {
//            return false
//        }
//    }
//
//    // 挑戦回数チェック
//    func checkChallengeCount(_ target: String) -> Bool {
//        if challengeCount >= challengeNumber {
//            return true
//        } else {
//            return false
//        }
//    }
//
//    // 数字が同じかチェック
//    func checkSameString(_ target: String) -> Bool {
//        return target == userInputNumbers[challengeCount][0] || target == userInputNumbers[challengeCount][1] || target == userInputNumbers[challengeCount][2]
//    }
//
//    // すべてのチェックが通った場合のみ入力文字を表示する
//    func inputCheck(_ target: String) {
//        if isClear == true {
//            return
//        }
//        if checkstringLength(target) {
//            return
//        }
//        if checkChallengeCount(target) {
//            return
//        }
//        if checkSameString(target) {
//            return
//        } else {
//            userInputNumbers[challengeCount][userInputCount] = "\(target)"
//            userInputCount += 1
//        }
//    }
//
//
//    // 回答を判定する
//    // 正誤チェック①（場所も値も同じもの）
//    func correctCheck() -> (Array<Bool>) {
//        var correct: Array<Bool> = []
//        for i in 0..<stringLength {
//            if userInputNumbers[challengeCount][i] == targetNumbers[i] {
//                correct.append(true)
//            } else {
//                correct.append(false)
//            }
//        }
//        return correct
//    }
//    // 場所も値も同じ
//    @State private var correctBoolArray: [Array<Bool>] = [
//        [false, false, false],
//        [false, false, false],
//        [false, false, false],
//        [false, false, false],
//        [false, false, false]
//    ]
//
//
//    // 正誤チェック②（値は同じだが場所が違うもの）
//    func valueCheck() -> (Array<Bool>) {
//        var value: Array<Bool> = []
//        for i in 0..<stringLength {
//            if userInputNumbers[challengeCount][i] != targetNumbers[i] && targetNumbers.contains(userInputNumbers[challengeCount][i]) {
//                value.append(true)
//            } else {
//                value.append(false)
//            }
//        }
//        return value
//    }
//
//    // 値は同じだが場所が違う
//    @State private var valueBoolArray: [Array<Bool>] = [
//        [false, false, false],
//        [false, false, false],
//        [false, false, false],
//        [false, false, false],
//        [false, false, false]
//    ]
//
//    // 背景を塗りつぶす
//    func getCellBackground(col: Int, aa: [Bool], bb: [Bool]) -> Color {
//        if col == 0 {
//            return aa[col] ? Color.red : bb[col] ? Color.yellow : Color.clear
//        } else if col == 1 {
//            return aa[col] ? Color.red : bb[col] ? Color.yellow : Color.clear
//        } else if col == 2 {
//            return aa[col] ? Color.red : bb[col] ? Color.yellow : Color.clear
//        }
//        return Color.clear
//    }
//
//    var body: some View {
//        ZStack {
//            VStack {
//                // デバッグ用
//                //                Text("\(targetNumbers)" as String)
//
//
//                // ディスプレイ
//                HStack {
//                    ForEach(0..<3) { col in
//                        Text("\(userInputNumbers[0][col])")
//                            .frame(width: 50, height: 50)
//                            .border(Color.gray)
//                            .background(getCellBackground(col: col, aa: correctBoolArray[0], bb: valueBoolArray[0]))
//                            .foregroundColor(Color.black)
//                            .font(.title)
//                            .padding(5)
//                    }
//                }
//                HStack {
//                    ForEach(0..<3) { col in
//                        Text("\(userInputNumbers[1][col])")
//                            .frame(width: 50, height: 50)
//                            .border(Color.gray)
//                            .background(getCellBackground(col: col, aa: correctBoolArray[1], bb: valueBoolArray[1]))
//                            .foregroundColor(Color.black)
//                            .font(.title)
//                            .padding(5)
//                    }
//                }
//                HStack {
//                    ForEach(0..<3) { col in
//                        Text("\(userInputNumbers[2][col])")
//                            .frame(width: 50, height: 50)
//                            .border(Color.gray)
//                            .background(getCellBackground(col: col, aa: correctBoolArray[2], bb: valueBoolArray[2]))
//                            .foregroundColor(Color.black)
//                            .font(.title)
//                            .padding(5)
//                    }
//                }
//                HStack {
//                    ForEach(0..<3) { col in
//                        Text("\(userInputNumbers[3][col])")
//                            .frame(width: 50, height: 50)
//                            .border(Color.gray)
//                            .background(getCellBackground(col: col, aa: correctBoolArray[3], bb: valueBoolArray[3]))
//                            .foregroundColor(Color.black)
//                            .font(.title)
//                            .padding(5)
//                    }
//                }
//                HStack {
//                    ForEach(0..<3) { col in
//                        Text("\(userInputNumbers[4][col])")
//                            .frame(width: 50, height: 50)
//                            .border(Color.gray)
//                            .background(getCellBackground(col: col, aa: correctBoolArray[4], bb: valueBoolArray[4]))
//                            .foregroundColor(Color.black)
//                            .font(.title)
//                            .padding(5)
//                    }
//                }
//
//                // キーボード
//                ForEach(viewButtonNumbers, id:\.self) { row in
//                    HStack(spacing:10) {
//                        ForEach(row, id:\.self) { col in
//                            Button("\(col)", action:{
//                                inputCheck(col)
//                            })
//                            .frame(width: 50, height: 50)
//                            .background(Color.gray)
//                            .foregroundColor(Color.white)
//                            .font(.title)
//                            .cornerRadius(20)
//                            .padding(5)
//                        }
//                    }
//                }
//
//                // ボタン
//                HStack {
//                    // 消去ボタン
//                    Button(action: {
//                        // 挑戦回数が0の時は何もしない
//                        if challengeCount == challengeNumber {
//                            return
//                        } else if userInputCount <= stringLength {
//                            userInputCount = 0
//                            userInputNumbers[challengeCount] = ["", "", ""]
//                        }
//                    }){
//                        Text("C")
//                            .padding(15)
//                            .background(Color.gray)
//                            .foregroundColor(Color.white)
//                            .cornerRadius(20)
//                            .font(.title)
//                    }
//
//                    // 送信ボタン
//                    Button(action: {
//                        // 規定の文字数の入力があり、挑戦回数が規定値より小さい場合
//                        if userInputCount == stringLength && challengeCount < challengeNumber {
//
//                            // 値の正誤チェックをする
//                            correctBoolArray[challengeCount] = correctCheck()
//                            valueBoolArray[challengeCount] = valueCheck()
//
//                            if correctBoolArray[challengeCount] == [true, true, true] {
//                                // クリアフラグを立てる
//                                isClear = true
//                            } else if challengeCount == challengeNumber - 1 {
//                                // ゲームオーバーフラグを立てる
//                            }
//
//                            // 入力文字数カウンタをリセット
//                            userInputCount = 0
//                            // 挑戦回数をカウントする
//                            challengeCount += 1
//                        }
//                    }){
//                        Text("Enter")
//                            .padding(15)
//                            .background(Color.gray)
//                            .foregroundColor(Color.white)
//                            .cornerRadius(20)
//                            .font(.title)
//                    }
//                }
//            }
//            // 画面が読み込まれたら行う処理
//            .onAppear {
//                Task {
//                    // 値を初期化する
//                    initializ()
//
//                    // 正解の番号を作る
//                    targetNumbers = createTargetNumbers()
//                }
//            }
//
//        }
//    }
//}
//
//
//
//
//
//
//struct PlayView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayView()
//    }
//}
