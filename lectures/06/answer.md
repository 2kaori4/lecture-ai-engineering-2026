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

- 取り組んだレベル：基礎 / 実装 / 発展
- やったこと：
- 結果：
- 気づき・疑問：
