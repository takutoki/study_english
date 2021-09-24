# 英語学習アプリ

## 環境

iOS 14.5 以上  
RxSwift 5.4.4  
Alamofire 6.2.0  

## アーキテクチャ

### MVVM  

・ModelにAPIリクエストの機能を持せている。初期の問題データの取得はModelの初期化時に走る。  
・Modelprotocolに準拠をして、ViewModelに公開したいプロパティ・メソッドのみをModelprotocolに定義する。  
・APIから取得したデータはこのModel内でのみ値を変更したいので、大元である`BehaviorRelay()`はprivate letで定義してViewModelには公開していない。  
・Viewに伝播させるために`Observable`の型に直してViewModel/Viewに公開する。  
・ViewModelは、上記のModelの`Observable`をViewに流すとともに、Viewの操作によって状態が発生する場合、その値を保持する役割。  
・今回でいうと問題に対して回答したときの選択肢を保持する。回答画面ではこの選択した回答をもとにViewに反映させる。  
・ViewはModelから流れてきた`Observable`の値をViewコンポーネントにバインドしている。  
・新たに問題をAPIから取得したときはViewに値がバインドされているので、自動で切り替わる。  
・時間的制約でView側の実装がほとんどできていないが、回答ボタンなどの使い回しができそうなコンポーネントはカスタムで独自クラスを作っている。

## 動作確認
本リポジトリをクローン後、Xcodeでビルドをする。  
実機で確認する場合、iPhoneの設定から、study_englishのApple Developerを信頼する設定を行う。