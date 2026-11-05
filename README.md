# AIE2026 演習・宿題リポジトリ

AIエンジニアリング実践講座（AIE2026）の演習と宿題で使うリポジトリです。
講座を通して、**AIエンジニアリングの学習を支援するエージェント**を少しずつ育てていきます。

## 想定する環境

演習は **ブラウザだけで** 進められるように作っています。自分の PC への導入は不要です。

| 使うもの | 用途 | 注意 |
|---|---|---|
| GitHub の **個人** アカウント | このリポジトリを fork し、作業ブランチと PR で提出する | 会社や学校が管理するアカウントでは Codespaces・Copilot が制限されることがあります |
| GitHub Codespaces | 第1・3・5回などの開発環境。`.devcontainer/` の設定で Python 3.12・uv・Node.js が入ったコンテナが自動で用意されます | 個人アカウントの無料枠は月 120 コア時間（2 コアで約 60 時間）。**使い終わったら停止**してください |
| GitHub Copilot（Free でよい） | コードの補完とチャット。第5回の発展課題では MCP クライアントとしても使います | Free は補完・チャットの回数に月の上限があります |
| Gemini API（Google AI Studio の無料枠） | LLM の呼び出し。**個人**の Google アカウントでキーを発行し、Codespaces secret `GEMINI_API_KEY` で渡します | 無料枠には 1 分あたり・1 日あたりの上限があります（下の「前提と制約」） |
| Google Colab（T4 GPU、無料枠） | 第2回の LoRA 学習だけに使います | GPU の利用時間に上限があります。終わったらランタイムを削除してください |

自分の PC で動かす場合は、Python 3.12 と [uv](https://docs.astral.sh/uv/) を入れて `uv sync --frozen` を実行し、環境変数 `GEMINI_API_KEY` を設定してください。

## はじめに（第1回）

1. このリポジトリを自分のアカウントに **fork** する
2. [Google AI Studio](https://aistudio.google.com/apikey) で Gemini API キーを作る
3. GitHub の **Settings → Codespaces → Secrets** に `GEMINI_API_KEY` を登録し、使う repository に自分の fork を選ぶ
4. 自分の fork で **Code → Codespaces → Create codespace on main**
5. ターミナルで動作確認

```bash
uv run pytest -q
uv run python -m app.ask "LoRAとは何ですか？"
```

詳しい手順は [lectures/01/problem.md](lectures/01/problem.md) を見てください。

## 環境構築・実行・保存の手順

### 動作要件

| 項目 | 内容 |
|---|---|
| Python | 3.12（`.python-version` と `pyproject.toml` の `requires-python >= 3.12`） |
| パッケージ管理 | [uv](https://docs.astral.sh/uv/) |
| 依存ライブラリ | `google-genai==2.31.0`、`pydantic-ai-slim[google,mcp]==2.57.0`、開発用に `pytest>=8`（版は `uv.lock` で固定） |
| 環境変数 | `GEMINI_API_KEY`（必須。LLM を呼ぶ場合のみ）、`AIE_MODEL`（任意） |

### 環境構築

- **Codespaces**：作成すると `.devcontainer/` の設定で Python 3.12・uv・Node.js が入り、`uv sync --frozen` まで自動で実行されます。
- **自分の PC**：

```bash
git clone https://github.com/<あなたのユーザー名>/lecture-ai-engineering-2026.git
cd lecture-ai-engineering-2026
uv sync --frozen                 # .venv を作り、固定された版をインストール
export GEMINI_API_KEY="..."      # LLM を呼ぶときだけ必要（コードやコミットに書かない）
```

### 実行

```bash
uv run pytest -q                                   # テスト（APIキー不要）
uv run python -m app.ask "LoRAとは何ですか？"        # 第1回（要 GEMINI_API_KEY）
uv run python -m app.agent --list-tools            # 第3回：ツール一覧（APIキー不要）
uv run python -m app.agent --mcp --list-tools      # 第5回：MCP のツール一覧（APIキー不要）
```

第2回は Google Colab で行います（[lectures/02/problem.md](lectures/02/problem.md)）。

### 保存（提出）

作業内容は Codespaces のコンテナ内にあるだけでは、削除されると失われます。回ごとに **commit して自分の fork に push** してください。

```bash
git switch -c lecNN              # 回ごとの作業ブランチ
git add -A && git commit -m "第N回 演習"
git push -u origin lecNN
```

PR は **自分の fork の `lecNN` → 自分の fork の `main`** で作成します。PR 画面で base repository が自分の fork になっていることを必ず確認してください（講座 repo に出さない）。

> **注意**：fork の画面から PR を作ると、base repository が講座 repo（`matsuolab/...`）になっていることがあります。次のどちらかで、base を確実に自分の fork にしてください。
>
> 1. **専用 URL を開く**（base が自分の fork に固定されます）。`<ユーザー名>` と `lecNN` を置き換えます。
>    `https://github.com/<ユーザー名>/lecture-ai-engineering-2026/compare/main...lecNN?expand=1`
> 2. **スクリプトを使う**：push と PR 作成を、base 固定で行います。
>    ```bash
>    bash scripts/submit_pr.sh "第N回 演習"
>    ```
>
> 画面で作る場合は、PR 作成画面上部の「base repository」が自分の fork か、確認してから Create します。

### よくあるエラー

| 症状 | 対処 |
|---|---|
| `環境変数 GEMINI_API_KEY が見つかりません` | Codespaces secret を登録（対象 repository に自分の fork を選ぶ）し、Codespaces を再起動 |
| `レート制限に達しました` | 1 分ほど待つ |
| `uv sync --frozen` が失敗する | `uv.lock` を書き換えていないか確認。Python 3.12 を使っているか `uv run python --version` で確認 |

## 構成

```
.devcontainer/   Codespaces の環境定義（Python 3.12、uv、Node.js。起動時に uv sync --frozen）
.github/workflows/test.yml  PR ごとにテストを実行（fork では Actions タブで有効化が必要）
app/
  config.py      モデル名とAPIキーの読み込み
  ask.py         第1回：LLMに質問する
  tools.py       第3回：エージェントのツール（用語集の検索など）
  agent.py       第3回：Pydantic AI の学習支援エージェント（第5回：--mcp で MCP 経由）
  mcp_server.py  第5回：用語集を公開する MCP サーバー
  mcp_servers.json 第5回：使う MCP サーバーの設定（mcpServers 形式）
data/
  glossary.json  講座の用語集
  lectures/      各回の要点
lectures/NN/
  problem.md     その回の演習と宿題
  answer.md      あなたが記入して提出するファイル
notebooks/       第2回：Google Colab で動かす LoRA のノートブック（lora_format_tuning.ipynb）
scripts/         補助スクリプト
tests/           テスト（APIキー不要）
pyproject.toml / uv.lock  依存パッケージとその固定版
```

## 提出のしかた

1. 回ごとに作業ブランチを作る（例：`git switch -c lec01`）
2. 演習・宿題を行い、`lectures/NN/answer.md` に記入する
3. push して、**自分の fork の中で** 作業ブランチ → `main` の PR を作る

宿題は「基礎・実装・発展」の3レベルがあり、どれか1つに取り組めば完了です。

## 前提と制約

- **依存パッケージの版は固定**しています（`uv.lock`。Python 3.12、pydantic-ai-slim 2.57.0、google-genai 2.31.0）。講座の期間中は上げません。`uv sync --frozen` でそのまま入れてください。
- **既定のモデルは `gemini-3.5-flash-lite`** です。環境変数 `AIE_MODEL` で切り替えられます（下の「モデルの切り替え」）。ほかのモデルや自前契約の API を使ってもかまいません
- **Gemini API の無料枠にはレート制限**があります。エージェント（第3回以降）は 1 つの質問で LLM を複数回呼ぶので、第1回より早く上限に達します。`レート制限に達しました` と出たら 1 分ほど待ってください。`モデルが混み合っています（503）` が続くときは `AIE_MODEL=gemini-3.1-flash-lite` を試してください
- **API キーは環境変数 `GEMINI_API_KEY` だけ**で渡します。コード・コミット・チャットに貼らないでください。漏れたら AI Studio で削除して作り直します
- Codespaces からインターネットへは出られますが、外から Codespaces の中へは接続できません（ポート転送は既定で非公開）。第5回の MCP サーバーは Codespaces の中で動かします
- テスト（`uv run pytest -q`）は API キーなしで動きます（LLM を呼ばない TestModel を使用）

## 守ってほしいこと

- **APIキーをコードやコミットに書かない。** Codespaces secret で渡します
- **使い終わったら Codespaces を停止する。** 無料枠を使い切ると起動できなくなります
- AIツール（Copilot など）は使ってかまいません。提案されたコードは、読んで理解してから採用してください

## モデルの切り替え

既定モデルは `gemini-3.5-flash-lite` です。環境変数 `AIE_MODEL` で切り替えられます。

```bash
AIE_MODEL=gemini-3.5-flash uv run python -m app.ask "LoRAとは何ですか？"
```

無料枠には1分あたり・1日あたりのリクエスト上限があります。上限は [Gemini API のレート制限のページ](https://ai.google.dev/gemini-api/docs/rate-limits) で確認してください。
