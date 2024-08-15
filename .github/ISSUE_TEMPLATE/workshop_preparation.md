---
name: ワークショップ準備
about: ワークショップ開催までのタスク管理
---

## 開催内容

- [イベントページ](https://oss-gate.doorkeeper.jp/events/TODO)
- 時間: YYYY-MM-DDT10:30/17:00 or YYYY-MM-DDT13:00/19:00
- 進行役: @

## やること

- [ ] Doorkeeperのイベントページ作成（要管理権限）
- [ ] 以下の各日付`YYYY-MM-DD`をセットする
  - `prepare/get_preparation_issue_converted_dates.rb` を実行する
  - `prepare workshop`ラベルが付いている各ワークショップ準備issueについて、日付部分を計算して置換したテキストが得られる
  - 上コマンドで得られたテキストから本issueの部分をコピーして、この内容を差し替える
- タイムライン、メッセージ送信予定（要管理権限）
  - 開催1ヵ月前（YYYY-MM-DD）
    - [ ] イベント未登録者向け：[サポーター募集文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_supporter_invitation.md)
    - [ ] [GitHubのannouncement](https://github.com/oss-gate/workshop/discussions/categories/announcements)を作る(要メンテナー権限): [サポーター募集文面](https://github.com/oss-gate/workshop/raw/master/template/event_notice_for_github_announcements.md)
  - 開催2週間前（YYYY-MM-DD）
    - [ ] 参加者、キャンセル待ち向け：[不参加の場合のキャンセルを呼びかける文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_reminder_before_2_weeks.md)
    - [ ] イベント未登録者向け：[イベント告知、サポーター募集文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_supporter_invitation_before_2_weeks.md)
    - [ ] (もし前半枠のサポーターが足りなければ) イベント未登録者向け：[前半枠のみサポーター募集の場合の文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_supporter_invitation_only_first_half.md)
    - [ ] (もし後半枠のサポーターが足りなければ) イベント未登録者向け：[後半枠のみサポーター募集の場合の文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_supporter_invitation_only_second_half.md)
  - 開催1週間前（YYYY-MM-DD）
    - [ ] 進行役決定
    - [ ] [ビギナーの繰り上がり](https://oss-gate.github.io/workshop/beginner-preferential-treatment.html)処理
    - [ ] 参加者、キャンセル待ち向け：[当日の参加方法案内および不参加の場合のキャンセルを呼びかける文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_reminder_before_1_week.md)
  - 開催3日前（YYYY-MM-DD）
    - [ ] (もしサポーターが集まらず開催できない場合) 参加者、キャンセル待ち向け：[サポーター不足による中止を伝える文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_canceled.md)
  - 開催1日前（YYYY-MM-DD）
    - [ ] (もしサポーターが集まらず開催できない場合) 参加者、キャンセル待ち向け：[サポーター不足による中止を伝える文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_canceled.md)
    - [ ] `tutorial/retrospectives/prepare.rb` を実行してアンケートのテンプレートを追加する（ #1337 ）（要コミット権）
- [ ] 4回分先までのDoorkeeperイベントページの作成（要管理権限）
  1. [イベントリスト](https://manage.doorkeeper.jp/groups/oss-gate/events)を開く。
  2. 「1月と4月と7月と10月は最終土曜日に10:30から17:00で開催」「3月と6月と9月と12月は第2土曜日に13:00から19:00で開催」のルールに従い、同じ開催時刻の未開催イベントまたは過去イベントから「コピーして新規イベント作成」を実行する。
  3. 2のルールに従って開催日を変更する。
  4. 開催日をイベントタイトルに反映する。
  5. ビギナー人数を0に変更する。
  6. イベントを作成する。
  7. イベントに対応するワークショップ準備用issueを作成する。
