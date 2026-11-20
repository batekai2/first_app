# FirstApp

投稿アプリ（Rails 8.1 / Ruby 3.3.14）です。認証付き投稿と基本的なセキュリティ対策を含みます。
Ruby 3.3.14 は Ruby2Shell（CVE-2026-132825）を含む 2026-11 のセキュリティ修正入りです。

## セットアップ

```bash
bundle install
# credentials が復号できない場合は作り直す:
# rm -f config/credentials.yml.enc && EDITOR=true bin/rails credentials:edit
bin/rails db:prepare
BOOTSTRAP_USER_PASSWORD='your-strong-password' bin/rails db:seed
bin/rails server
```

既存の MySQL データを使っていた場合はスキーマ変更があるため、`bin/rails db:drop db:prepare db:seed` で初期化してください（開発/テストは SQLite3）。

開発用のデフォルトシード（本番では `BOOTSTRAP_USER_PASSWORD` 必須）:

- email: `admin@example.com`
- password: `ChangeMeNow!123`

## セキュリティ関連のポイント

- Ruby 3.3.14（Ruby2Shell 修正版）/ Rails 8.1 / 現行系 Puma・Rack へ更新
- 投稿作成はログイン必須
- Strong Parameters・投稿文字数制限・レート制限（Rack::Attack）
- 本番で `force_ssl` / CSP / セキュア Cookie / `log_level=info`
- `config/master.key` はリポジトリに含めない

## テスト

```bash
bin/rails test
```
