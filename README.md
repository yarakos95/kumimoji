## kumimoji

組文字を作成するためのパッケージです。

本パッケージでは、文字を縮小・長体にすることで組文字を再現することが出来ます。

### 組文字とは

[Wikipedia][wiki-kumimoji] によれば、以下のように説明されています。

[wiki-kumimoji]: https://ja.wikipedia.org/wiki/%E7%B5%84%E6%96%87%E5%AD%97 "組文字 - Wikipedia"

> 組文字（くみもじ）は、1 行の文字列中内に複数行記述する組版のことを言う。一般には、「㍍」「㍿」のように、全角サイズ 1 文字の領域に複数文字を入れる場合が多い。

例えば、[Unicode][unicode-kumimoji] には 4 文字の「㍍」や「㍿」の他にも、2 文字「㌔」や 3 文字「㌘」等もあり、最大で 6 文字「㌖」があります。

[unicode-kumimoji]: https://util.unicode.org/UnicodeJsps/list-unicodeset.jsp?a=%5Cp%7Bsubhead%3DSquared+Katakana+words%7D%0D%0A%5Cp%7Bsubhead%3DSquared+hiragana+from+ARIB+STD+B24%7D%0D%0A%5Cp%7Bsubhead%3DJapanese+corporation%7D&g=&i= "組文字 | Unicode Utilities: UnicodeSet"

kumimoji パッケージでは、これらのような複数文字を全角 1 文字の中に入れることで組文字を作成します。
加えて、「㍻」のような日本の年号における合字も作成可能です。（[参考][unicode-gohji]）

[unicode-gohji]: https://util.unicode.org/UnicodeJsps/list-unicodeset.jsp?a=%0D%0A%5Cp%7Bsubhead%3DJapanese+era+names%7D&g=&i= "合字 | Unicode Utilities: UnicodeSet"

### 要件

- LuaLaTeX＋luatex-ja
- expl3
- bxghost（オプション）

### パッケージ読み込み

プリアンブルで kumimoji を読み込みます。

```latex
\usepackage{kumimoji}
```

#### パッケージオプション

| オプション | 値                             | 説明                           |
| :--------: | ------------------------------ | ------------------------------ |
|   `font`   | フォント命令（`\bfseries` 等） | フォントの変更                 |
| `bxghost`  | boolean (default: `true`)      | bxghost パッケージを利用するか |
| `uplatex`  | boolean (default: `false`)     | (u)pLaTeX で利用するとき       |

### 使い方

kumimoji パッケージが提供するコマンドは 1 つです。

```latex
\kumimoji{〈組文字〉}
```

基本的に最小 2 文字、最大 6 文字を想定しています。1 文字の場合、そのまま出力します。

`*` オプションを使用すると、「㍻」のような合字を作成できます。

```latex
\kumimoji*{〈合字〉}
```

基本的に 2 文字を想定しています。単純に複数文字を 1 文字幅になるように構成しているため、文字数が多い場合、非常に細長い長体が出力されます。

#### 作成される組文字

`\kumimoji` によって作成される組文字は以下のようになります。

```latex
\kumimoji{１２}
\kumimoji{１２３}
\kumimoji{１２３４}
\kumimoji{１２３４５}
\kumimoji{１２３４５６}
```

![sample 1](./sample/image-png/sample-image-1.png)

7 文字以上であっても組文字は作成されます。偶数文字の場合は等分、奇数文字の場合は下段が上段より 1 文字多く配置されます。

```latex
\kumimoji{ミリシーベルト}   %% 7 文字
\kumimoji{オングストローム} %% 8 文字
```

![sample 2](./sample/image-png/sample-image-2.png)

文字数が多すぎると単純に読みづらいものになるため、コマンドオプションで文字幅を調整することをオススメします。

ただし、途中で改行されることを想定していないため、文章の挿入は避けてください。この場合は jlreq 文書クラスで提供される `\warichu` 等を利用してください。

#### コマンドオプション

`\kumimoji` にはコマンドオプションがあります。

コマンドオプションは `\kumimoji[〈オプション〉]` として key-value 形式で課します。

|      キー      | 値                             | 説明                 |
| :------------: | ------------------------------ | -------------------- |
|     `font`     | フォント命令（`\bfseries` 等） | フォントの変更       |
|    `width`     | 寸法（`2 \zh` 等）             | 組文字の文字幅の変更 |
|     `top`      | `left`・`center`・`right`      | 組文字上段の揃え位置 |
|    `bottom`    | `left`・`center`・`right`      | 組文字下段の揃え位置 |
|  `scale-top`   | 数値                           | 組文字上段のスケール |
| `scale-bottom` | 数値                           | 組文字下段のスケール |
|    `color`     | 色                             | 文字の色付け         |

例えば、以下のように利用できます。

```latex
\kumimoji[font = \gtfamily]{有限会社} %
\kumimoji[width = 2\zw]{オングストローム} %
\kumimoji[top = center]{木|木木} % 森の疑似的再現
\kumimoji[width = 1.5\zw, top = left, bottom = right]{などなど} %
```

![sample 3](./sample/image-png/sample-image-3.png)




#### 区切り位置の調整

組文字は上段と下段に分かれていますが、これは文字数によって自動的に采配されます。
しかしながら、上段と下段の文字数を手動で調整したいこともあるでしょう。

Unicode でも、5 文字の組文字は多くの場合「㌕」や「㌠」のように 2/3 となっていますが、「㌙」は 3/2 となっています。kumimoji パッケージでは 2/3 に采配するようになっています。

kumimoji パッケージでは区切り位置を明らかにするために `|` を利用します。例えば以下のようにします。

```latex
\kumimoji{グラムトン}  %%
\kumimoji{グラム|トン} %% 区切り文字の指定あり
```

![sample 4](./sample/image-png/sample-image-4.png)

#### 異体字セレクタへの対応

日本語には異体字セレクタによる字形の指定があります。異体字セレクタ自体には字形がなく目に見えません。

kumimoji パッケージでは異体字セレクタも文字数としてカウントされるため、デフォルト動作による自動的な配置では奇妙な結果を得ることになります。

例えば、辻と言う文字にはシンニョウの点が 2 つのもの（辻 (U+98F4)）と 1 つのもの（辻󠄀 (U+98F4, U+E0100)）があります。

そのため、組文字にするときに以下のようにすると、奇妙な結果を得ることがあります。

```latex
\kumimoji{辻野さん} %%
\kumimoji{辻󠄀野さん} %% 異体字セレクタを含む
```

![sample 5](./sample/image-png/sample-image-5.png)

これを回避するには、2 つの処理を施してください。

- 区切り位置を明らかにする
- 上段と下段の文字数を明らかにする

上の例を基に、2 つの処理をすると以下のようになります。

```latex
\kumimoji{辻󠄀野|さん}[2, 2]
```

![sample 6](./sample/image-png/sample-image-6.png)

これによって上手く処理できるようになります。

この他、[Mn カテゴリ][compart-mn] に分類されるような文字数としてカウントされるべきでない文字が含まれる場合でも、上のように区切り位置と文字数を明らかにしてください。

[compart-mn]: https://www.compart.com/en/unicode/category/Mn "List of Unicode Characters of Category “Nonspacing Mark”"

#### 合字

`*` オプションによって合字になります。

```latex
\kumimoji*{令和} % 2 文字
\kumimoji*{三畳紀} % 3 文字
```

![sample 7](./sample/image-png/sample-image-7.png)

コマンドオプションは次の通りです。

|  キー   | 値                             | 説明                 |
| :-----: | ------------------------------ | -------------------- |
| `font`  | フォント命令（`\bfseries` 等） | フォントの変更       |
| `width` | 寸法（`2 \zh` 等）             | 組文字の文字幅の変更 |
| `color` | 色                             | 文字の色付け         |

## 既知の問題

現在、知られた問題はありません。

### 他の LaTeX エンジンへの対応に関する問題

- badbox (`Underfull \hbox (badness 10000)`) が発行される
- 縦書きに対応していない
- `\regex_replace_all` による置換するとエラーを発行する

## 展望

- デバッグモード
- 組文字の深さ量
