# アンケート記入方法

## 概要

https://github.com/oss-gate/workshop/tree/master/tutorial/retrospectives 以下にYAMLフォーマットでアンケート結果を集めます。

retrospectivesディレクトリー以下にはイベントごとに「`${YEAR}-${MONTH}-${DAY}-${LOCATION}`」というフォーマットのディレクトリーを作り、そのディレクトリーの下にアンケート結果をおきます。たとえば、[OSS Gate東京ワークショップ2017-07-29](https://oss-gate.doorkeeper.jp/events/61378)なら「`2017-07-29-tokyo`」ディレクトリーです。

アンケートの回答はpull requestします。

## 回答方法

まず、 https://github.com/oss-gate/workshop リポジトリーをforkします。

すでに自分のアカウントにforkしたものがある場合はリポジトリーを削除します。（索条方法の説明を書く？）

画面の右上にある「Fork」ボタンを押すとforkできます。

forkできたら「forkした自分のリポジトリー」をcloneします。

例：

```console
% git clone https://github.com/kou/workshop.git
```

cloneした後、「`tutorial/retrospectives/${YEAR}-${MONTH}-${DAY}-${LOCATION}`」ディレクトリーに移動します。たとえば、[OSS Gate東京ワークショップ2017-07-29](https://oss-gate.doorkeeper.jp/events/61378)なら「`tutorial/retrospectives/2017-07-29-tokyo`」ディレクトリーです。

例：

```console
% cd tutorial/retrospectives/2017-07-29-tokyo
```

そのディレクトリーに以下のファイルがあります。質問が書いてあります。

  * `beginner.yaml`：ビギナー用
  * `supporter.yaml`：サポーター用

自分の立場用（ビギナーなら`beginner.yaml`）のファイルを`${TYPE}-${アカウント名}.yaml`（`${TYPE}`は`beginner`または`supporter`）というファイル名でコピーします。

ビギナーの例：

```console
% cp beginner.yaml beginner-kou.yaml
```

サポーターの例：

```console
% cp supporter{,-kou}.yaml
```

エディターで`${TYPE}-${アカウント名}.yaml`のファイル内にあるアンケートに回答します。

回答後、add・commit・pushします。

例：

```console
% git add beginner-kou.yaml
% git checkout -b {適当なブランチ名}
% git commit -m"アンケート提出"
% git push {適当なブランチ名}
```

https://github.com/oss-gate/workshop にアクセスするとpull requestを作成するリンクができているはずなのでそのリンクからpull requestを作ります。

## アンケートの準備方法

TODO（`tutorial/retrospectives`にあるテンプレートをコピーするとか。）
