# 開発環境

## psql
brew install postgresql

### error
PG: could not connect to server: No such file or directory
	Is the server running locally and accepting
	connections on Unix domain socket "/tmp/.s.PGSQL.5432"?
### solve
	http://tstomoki.com/programming/posgre_inst
	> brew install postgresql
	> initdb /usr/local/var/postgres -E utf8
	> 多分エラーがでる
	> rm -rf /usr/local/var/postgres/* 
	> 再実行
	> initdb /usr/local/var/postgres -E utf8
##### サーバー起動
	> pg_ctl -D /usr/local/var/postgres -l logfile start 
	> 起動確認
	> psql -l
##### サーバー終了
	> pg_ctl -D /usr/local/var/postgres stop -s -m fast

## 初期データの投入
bundle exec rake db:setup

## pslqへの接続
init db時に作成されている
psql -d postgres

## Rspecの動作
brew install phantomjs

## rails server 動作確認
http://test.lvh.me:3000
にアクセスする。
accountとuserの関連が上手くわからんな。
localhostだと上手く動かん。。。

#画面解説
メールによるユーザ追加制御
http://test.lvh.me:3000/invitations/c4cd76cdcae56c74c16961d5674f0840/accept
http://test.lvh.me:3000/invitations/:token/accept

