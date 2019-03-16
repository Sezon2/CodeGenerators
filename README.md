# TmpCodeGenerators
**<以下、仕様未決定に付き、仮表記>**  
汎用性の無い、一時的なコードジェネレータです。  
「tmp_code_generator.bat」をダブルクリックする事でツールを使用することが出来ますが、  
Jenkinsへ登録してJenkinsから使用することも出来ます。  
Jenkinsから使用する場合はJenkinsが読み書き可能な場所に保存されている必要があります。  

## ソフトウェア概要
本ソフトウェアは主にプログラミング言語のコードを生成するのを目的としています。  
生成機はsrc内にコマンド名毎に「cmd」ファイルが置かれています。  
生成したいソースコードが増えたらsrc内に「cmd」ファイルを作成して、そこにソース生成内容を書いたあと、  
「tmp_code_generator.bat」にコマンド名を追加して追加した「cmd」をcallするようにしてください。  

## mdファイルの書き方について
GitHubで使われるドキュメントの形式「*.md」について、  
このファイルは規則にしたがって半角記号やスペースを入れることで簡単に  
文書をマークアップできるようになっています。  

マークアップの仕方は下記にありますので、ご確認ください。  
https://qiita.com/oreo/items/82183bfbaac69971917f  
