# アンケート記入方法

## 概要

https://github.com/oss-gate/workshop/tree/master/tutorial/retrospectives 以下にYAMLフォーマットでアンケート結果を集めます。

retrospectivesディレクトリー以下にはイベントごとに「`${YEAR}-${MONTH}-${DAY}-${LOCATION}`」というフォーマットのディレクトリーを作り、そのディレクトリーの下にアンケート結果をおきます。たとえば、[OSS Gate東京ワークショップ2017-07-29](https://oss-gate.doorkeeper.jp/events/61378)なら「`2017-07-29-tokyo`」ディレクトリーです。

アンケートの回答はpull requestします。

## 回答方法

まず、 https://github.com/oss-gate/workshop リポジトリーをforkします。

すでに自分のアカウントにforkしたものがある場合はリポジトリーを削除するか、下の2回目以降の回答方法をやってみてください。

画面の右上にある「Fork」ボタンを押すとforkできます。(Organizationに所属している場合はOrganizationも出てきますが、普通は自分のアカウントにforkします。)

forkできたら「forkした自分のリポジトリー」をcloneします。

例：

```console
% git clone https://github.com/kou/workshop.git
```

cloneした後、「`tutorial/retrospectives/${YEAR}-${MONTH}-${DAY}-${LOCATION}`」ディレクトリーに移動します。たとえば、[OSS Gate東京ワークショップ2017-07-29](https://oss-gate.doorkeeper.jp/events/61378)なら「`tutorial/retrospectives/2017-07-29-tokyo`」ディレクトリーです。(参加した日のディレクトリーがない場合は、以前に参加した時のものが残っているのかもしれません。下の2回目以降の回答方法をやってみてください。)

例：

```console
% cd tutorial/retrospectives/2017-07-29-tokyo
```

そのディレクトリーに以下のファイルがおいてあり、質問が書いてあります。

  * `beginner.yaml`：ビギナー用
  * `supporter.yaml`：サポーター用

自分の立場用（ビギナーなら`beginner.yaml`）のファイルを`${TYPE}-${アカウント名}.yaml`（`${TYPE}`は`beginner`または`supporter`）というファイル名でコピーします。(移動(ファイル名の変更)ではありません。移動されるとマージしにくくなってしまいます。)

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
% git checkout -b add-retrospective
% git commit -m"アンケート提出"
% git push origin add-retrospective
```

https://github.com/oss-gate/workshop にアクセスするとpull requestを作成するリンクができているはずなのでそのリンクからpull requestを作ります。

回答のYAMLファイルに文法エラーがある場合、pull requestのテストが失敗するので、CircleCIのリンクを辿ってエラー箇所を特定・修正し、もういちどadd・commit・pushしてください。これをエラーがなくなるまで繰り返します。

## 2回目以降の回答方法

`workshop`ディレクトリに移動します。

2回目の時は`git remote add upstream https://github.com/oss-gate/workshop`で`upstream`という`remote`を追加します。
すでに追加されているはずの3回目以降は不要です。

`git fetch upstream`で`upstream`の変更をとってきます。
`git checkout master`で`master`以外のブランチに切り替えていた場合は`master`ブランチに戻します。
`git rebase upstream/master`で`upstream`の`master`ブランチの変更を手元の`master`ブランチにマージします。

例：

```console
% cd workshop
% git remote add upstream https://github.com/oss-gate/workshop
% git fetch upstream
% git checkout master
% git merge upstream/master
```

以降は上の回答方法のcloneした後、「`tutorial/retrospectives/${YEAR}-${MONTH}-${DAY}-${LOCATION}`」ディレクトリーに移動するところからやってみてください。

## アンケートの準備方法

`prepare.rb` を実行して準備します。
ディレクトリ `${YEAR}-${MONTH}-${DAY}-${LOCATION}` と `workshop` を指定します。

「OSS Gate東京ワークショップ2017-07-29」の例：

```console
% ./prepare.rb 2017-07-29-tokyo workshop
```

### ビギナーのファイルを用意する

forkをせずに、GitHub上でアンケートを回答するビギナーが多いです。
その際、ビギナーにファイルをコピーしてもらう手順が難しかったり、`beginner`のスペルを打ち間違えることが多くありました。
なので、この方法でアンケートの前に各ビギナーのファイルを用意しておくとスムーズです。

休憩時間など、各ビギナーの作業メモissueが揃ったタイミングで、 `prepare_beginner_files.rb` を実行します。
事前に `prepare.rb` で作成したディレクトリを指定します。
これにより、open状態の作業メモissueのタイトルからアカウント名を抽出し、ビギナーのアンケートファイルを作成します。

```console
% ./prepare_beginner_files.rb 2017-07-29-tokyo
```

## アンケート集計方法

```console
% ./aggregate.rb 2018-03-10-tokyo beginner
% ./aggregate.rb 2018-03-10-tokyo supporter
```
