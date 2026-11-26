# 第6回 解答

## 演習

<!-- [tool call] の行は、表示された行をそのまま貼り付けてください。終わらなかった STEP は、空欄のままでかまいません。 -->

- STEP 1 のツールの名前：glossary_search_glossary
- STEP 2 の [tool call]：glossary_search_glossary({'query': '3レベル'})
- STEP 3 の [tool call]：fetch_fetch({'url': 'https://modelcontextprotocol.io/'})
- STEP 4 の [tool call]：　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　         -aws_aws___search_documentation({'search_phrase': 'Amazon S3 バージョニング 概要', 'topics': ['general']})
- aws_aws___search_documentation({'topics': ['general'], 'search_phrase': 'Using versioning Amazon S3'})
- 気づき・疑問：MCPを利用することで、エージェント本体のコードを変更せず、設定ファイルに数行追加するだけで、利用できるツールが1個から2個、さらに7個に増えることを確認できた。また、公開されているMCPサーバーを自分の環境で起動する方法と、外部で稼働しているMCPサーバーにURLで接続する方法の違いを理解できた。

## 宿題

<!-- 基礎・実装・発展のどれか1つに取り組めば完了です。 -->

- 取り組んだレベル：基礎 
- やったこと：app/mcp_server.py に server.tool()(tools.get_lecture_summary) の1行を追加し、　講義の要点を取得するツールを公開した。
- 結果：
　- モデルに見えているツールが7個から8個に増えた。
  - glossary_get_lecture_summary がツール一覧に追加された。
  - 「第2回では何を学びますか？」と質問し、以下のツールが呼び出され、第2回の講義内容が回答された。
  - 「第2回では何を学びますか？」と質問し、glossary_get_lecture_summary が呼び出され、第2回の講　　義の要点が取得できることを確認した。
  - uv run pytest -q を実行し、22個のテストがすべて成功した（22 passed in 4.24s）。
- 気づき・疑問：MCPサーバー側にコードを1行追加するだけで、エージェント側のコードや設定ファイルを変更することなく、新しいツールを利用できることを確認した。MCPを利用することで、機能の追加や拡張が容易になることを理解できた。
