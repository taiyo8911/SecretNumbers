# SecretNumbersApp

「ナンバーハント」は、3桁の数字を当てるシンプルなiOSゲームアプリです。
https://apple.co/3odHKs2

## 概要
昔ながらの「数当てゲーム」をモダンなUIでリメイクしたアプリです。プレイヤーは隠された3つの数字を7回以内で当てることを目指します。

## 特徴
- グラデーションとアニメーションを備えたUI
- シンプルで直感的な操作感
- 挑戦回数と経過時間によるスコア管理

## ゲームルール
1. 3桁の数字（各桁は0-9の数字で、重複なし）を推測します
2. 挑戦できるのは7回までです
3. 各回の結果は以下のように表示されます:
   - ヒット(🔴): 数字と位置が両方合っている数
   - ブロー(🟡): 数字は合っているが位置が違う数

例えば：
- 正解が「123」の場合
- 「135」と入力すると
- 🔴1（「1」が数字も位置も一致）、🟡1（「3」が数字は含まれるが位置が異なる）

## 開発者向け情報
### 技術スタック
- SwiftUI
- MVVM アーキテクチャパターン
- Combine フレームワーク（データバインディング）

### 主要ファイル構成
```
SecretNumbers/
├── Game/
│   ├── GameLogicManager.swift    # ゲームのロジック部分
│   ├── GameTimerManager.swift    # タイマー機能
│   └── GameViewModel.swift       # ゲームのビューモデル
├── UI/
│   ├── Components/               # 再利用可能なUI要素
│   ├── Screens/                  # 画面レイアウト
│   └── Theme/                    # デザインシステム
└── Assets.xcassets/              # 画像リソース
```

### 主要な画面
- **SplashView**: アプリ起動時のスプラッシュ画面
- **MainView**: メニュー画面
- **GameView**: 実際のゲームプレイ画面
- **AboutView**: ゲームルールの説明画面
