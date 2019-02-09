@echo off
rem ************************************************************************************************
rem ★入力チェック
rem ************************************************************************************************
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ■作成するCodeGeneratorの名前
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if "%GeneratorName%"=="" (
	echo 「GeneratorName」の入力は必須です。
	exit -1
)
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ************************************************************************************************

rem ************************************************************************************************
rem ★設定確認
rem ************************************************************************************************
echo 設定の確認中...
rem ------------------------------------------------------------------------------------------------
if not exist "..\settings\jenkins_settings.cmd" (
	echo 共通設定が生成されていません。
	echo 「settings\jenkins_settings」のジョブで初期設定を行なってください。
	exit -1
)
rem ************************************************************************************************

rem ************************************************************************************************
rem ★初回処理
rem ************************************************************************************************
call ..\settings\jenkins_settings.cmd
rem ------------------------------------------------------------------------------------------------
set PATH=%PATH%;%LibDirPath%
rem ------------------------------------------------------------------------------------------------
if exist "..\main_app\%GeneratorName%\." (
	echo 「%GeneratorName%」このGeneratorは作成済みです。
	exit -1
)
rem ************************************************************************************************


rem 〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜
rem ↓メイン処理

rem ************************************************************************************************
rem ★新しいCodeGeneratorのフォルダを作成
rem ************************************************************************************************
if not exist "..\main_app\." mkdir ..\main_app
if not exist "..\main_app\%GeneratorName%\." mkdir ..\main_app\%GeneratorName%
if not exist "..\main_app\%GeneratorName%\settings\." mkdir ..\main_app\%GeneratorName%\settings
rem ************************************************************************************************

rem ************************************************************************************************
rem ★共通設定のコピー
rem ************************************************************************************************
copy ..\settings\jenkins_settings.cmd ..\main_app\%GeneratorName%\settings\jenkins_settings.cmd /Y
rem ************************************************************************************************


rem 〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜
rem ↓他ジョブサポート関連

rem ************************************************************************************************
rem ★「settings」->「jenkins_settings」のジョブ設定更新先追加
rem ************************************************************************************************
if not exist "..\settings\jenkins_settings\setting_copys\." mkdir ..\settings\jenkins_settings\setting_copys
rem ------------------------------------------------------------------------------------------------
echo copy ..\jenkins_settings.cmd ..\..\main_app\%GeneratorName%\settings\jenkins_settings.cmd /Y>..\settings\jenkins_settings\setting_copys\%GeneratorName%.cmd
rem ************************************************************************************************


rem 〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜
rem ↓終了処理

rem ************************************************************************************************
rem ★完了メッセージ
rem ************************************************************************************************
echo 「%GeneratorName%」の新規作成が完了しました。
echo jenkinsに以下のフォルダを作成してください。
echo 「main_app」
echo 「main_app\%GeneratorName%」
echo 「main_app\%GeneratorName%\settings」
rem ************************************************************************************************
