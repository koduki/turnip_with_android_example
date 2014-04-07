Feature: 設定画面
  Scenario: 端末情報を表示する
    Given テスト対象は "android" 端末
    When "About phone" をタップする
    Then Android Version は "4.2.2" が表示されていること
