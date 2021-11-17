---
name: ワークショップ準備
about: ワークショップ開催までのタスク管理
---

## 開催内容

- [イベントページ](https://oss-gate.doorkeeper.jp/events/TODO)
- 会場: 
- 時間: YYYY-MM-DDT10:30/17:00 or YYYY-MM-DDT13:00/19:00
- 会場係: @
- 進行役: @
- このイベントに関する窓口: @

## 会場設備確認（オフライン開催の場合）

参考：[ワークショップ会場の提供](https://oss-gate.github.io/sponsors/wanted.html#workshop-space)

- [ ] 10人以上座れる机と椅子（参加人数が20人を超えることはほとんどありません）
- [ ] プロジェクタと投影できるところ (スクリーンじゃなくとも見えればOKです！)
- [ ] WiFi
- [ ] 電源タップ (参加人数の半分以上の口があるとうれしいです)
- [ ] 夜間、土日祝日の入場方法について（必要な場合のみ）
- [ ] プロジェクタの入出力端子 (HDMIなど)

## やること

- [ ] Doorkeeperのイベントページ作成（要管理権限）
- タイムライン、メッセージ送信予定（要管理権限）
  - 開催1ヵ月前（YYYY-MM-DD）
    - [ ] 進行役決定
    - [ ] 窓口決定（オフライン開催の場合）
    - [ ] 会場決定（オフライン開催の場合）
    - [ ] イベント未登録者向け：[サポーター募集文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_reminder_before_2_weeks.md)
  - 開催2週間前（YYYY-MM-DD）
    - [ ] 参加者、キャンセル待ち向け：[不参加の場合のキャンセルを呼びかける文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_reminder_before_2_weeks.md)
    - [ ] イベント未登録者向け：[イベント告知、サポーター募集文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_supporter_invitation_before_2_weeks.md)
    - [ ] イベント未登録者向け：[前半枠のみサポーター募集の場合の文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_supporter_invitation_only_first_half.md)
    - [ ] イベント未登録者向け：[後半枠のみサポーター募集の場合の文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_supporter_invitation_only_second_half.md)
  - 開催1週間前（YYYY-MM-DD）
    - [ ] [ビギナーの繰り上がり](https://oss-gate.github.io/workshop/beginner-preferential-treatment.html)処理
    - [ ] 参加者、キャンセル待ち向け：[不参加の場合のキャンセルを呼びかける文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_reminder_before_1_week.md)
    - [ ] 参加者向け：[Discord招待URLの通知用文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_discord_url.md)（オンライン開催の場合）
  - 開催3日前（YYYY-MM-DD）
    - [ ] 参加者、キャンセル待ち向け：[サポーター不足による中止を伝える文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_canceled.md)）
    - [ ] 参加者向け：[場案内の通知用文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_location.md)（オフライン開催の場合）
  - 開催1日前（YYYY-MM-DD）
    - [ ] 参加者、キャンセル待ち向け：[サポーター不足による中止を伝える文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_canceled.md)）
    - [ ] 参加者向け：[会場案内の通知用文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_location_reminder.md)（オフライン開催の場合）
    - [ ] 参加者向け：[Discord招待URLの通知用文面](https://github.com/oss-gate/workshop/raw/master/template/workshop_discord_url_reminder.md)（オンライン開催の場合）
    - [ ] `tutorial/retrospectives/prepare.rb` を実行してアンケートのテンプレートを追加する（ #1337 ）（要コミット権）
- [ ] 4回分先までのDoorkeeperイベントページの作成（要管理権限）
  1. [イベントリスト](https://manage.doorkeeper.jp/groups/oss-gate/events)を開く。
  2. 「1月と4月と7月と10月は最終土曜日に10:30から17:00で開催」「3月と6月と9月と12月は第2土曜日に13:00から19:00で開催」のルールに従い、同じ開催時刻の未開催イベントまたは過去イベントから「コピーして新規イベント作成」を実行する。
  3. 2のルールに従って開催日を変更する。
  4. 開催日をイベントタイトルに反映する。
  5. ビギナー人数を0に変更する。
  6. イベントを作成する。
  7. イベントに対応するワークショップ準備用issueを作成する。
