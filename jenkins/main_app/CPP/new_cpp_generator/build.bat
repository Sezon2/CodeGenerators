@echo off
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
rem ------------------------------------------------------------------------------------------------
if not exist "..\settings\cpp_settings.cmd" (
	echo CPP共通設定が生成されていません。
	echo 「main_app\CPP\settings\cpp_settings」のジョブで初期設定を行なってください。
	exit -1
)
rem ************************************************************************************************

rem ************************************************************************************************
rem ★変数定義
rem ************************************************************************************************
set task_id_=%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%
rem ************************************************************************************************

rem ************************************************************************************************
rem ★初回処理
rem ************************************************************************************************
call ..\settings\cpp_settings.cmd
rem ------------------------------------------------------------------------------------------------
set PATH=%PATH%;%LibDirPath%
rem ************************************************************************************************

rem ************************************************************************************************
rem ★入力チェック
rem ************************************************************************************************
call %GeneratorDirPath%\src\input_chk\required_input.cmd AppName %AppName%
call %GeneratorDirPath%\src\input_chk\required_input.cmd AppJName %AppJName%
call %GeneratorDirPath%\src\input_chk\required_input.cmd AppShortNameL %AppShortNameL%
call %GeneratorDirPath%\src\input_chk\required_input.cmd AppShortNameSL %AppShortNameSL%
rem ************************************************************************************************

rem ************************************************************************************************
rem ★ジョブの実行に関する有効性の確認
rem ************************************************************************************************
if exist "..\%AppName%\." (
	echo 「%AppName%」このアプリケーションは作成済みです。
	exit -1
)
rem ------------------------------------------------------------------------------------------------
set p1=%CppTemplateDirPath%
set p2=コードテンプレートフォルダ
call %GeneratorDirPath%\src\filedir_chk\required_dir.cmd
rem ------------------------------------------------------------------------------------------------
set p1=%CppDirPath%\src
set p2=コード生成モジュールソースフォルダ
call %GeneratorDirPath%\src\filedir_chk\required_dir.cmd
rem ************************************************************************************************


rem ～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～
rem ↓メイン処理

rem ************************************************************************************************
rem ★新しいアプリケーションのフォルダを作成
rem ************************************************************************************************
if not exist "..\%AppName%\." mkdir ..\%AppName%
if not exist "..\%AppName%\settings\." mkdir ..\%AppName%\settings
if not exist "..\%AppName%\settings\app_settings\." mkdir ..\%AppName%\settings\app_settings
rem ------------------------------------------------------------------------------------------------
if not exist "%CppDirPath%\%AppName%\." mkdir %CppDirPath%\%AppName%
if not exist "%CppDirPath%\%AppName%\result\." mkdir %CppDirPath%\%AppName%\result
rem ************************************************************************************************

rem ************************************************************************************************
rem ★各種設定の書き出し
rem ************************************************************************************************
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ■入力された値系※存在確認不要系
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if not "%AppName%"=="" echo set AppName=%AppName%>AppName.cmd
if not "%AppName%"=="" echo 「AppName」設定完了。[AppName:%AppName%]
rem --------------------------------------------------------
if not "%AppJName%"=="" echo set AppJName=%AppJName%>AppJName.cmd
if not "%AppJName%"=="" echo 「AppJName」設定完了。[AppJName:%AppJName%]
rem --------------------------------------------------------
if not "%AppShortNameL%"=="" echo set AppShortNameL=%AppShortNameL%>AppShortNameL.cmd
if not "%AppShortNameL%"=="" echo 「AppShortNameL」設定完了。[AppShortNameL:%AppShortNameL%]
rem --------------------------------------------------------
if not "%AppShortNameSL%"=="" echo set AppShortNameSL=%AppShortNameSL%>AppShortNameSL.cmd
if not "%AppShortNameSL%"=="" echo 「AppShortNameSL」設定完了。[AppShortNameSL:%AppShortNameSL%]
rem --------------------------------------------------------
if not "%IsUseAslLog2%"=="共通設定を使用" echo set IsUseAslLog2=%IsUseAslLog2%>IsUseAslLog2.cmd
if not "%IsUseAslLog2%"=="共通設定を使用" echo 「IsUseAslLog2」設定完了。[IsUseAslLog2:%IsUseAslLog2%]
if "%IsUseAslLog2%"=="共通設定を使用" echo set IsUseAslLog2=>IsUseAslLog2.cmd
if "%IsUseAslLog2%"=="共通設定を使用" echo 「IsUseAslLog2」設定完了。[IsUseAslLog2:%IsUseAslLog2%]
rem --------------------------------------------------------
if not "%IsUseEntryPointClass2%"=="共通設定を使用" echo set IsUseEntryPointClass2=%IsUseEntryPointClass2%>IsUseEntryPointClass2.cmd
if not "%IsUseEntryPointClass2%"=="共通設定を使用" echo 「IsUseEntryPointClass2」設定完了。[IsUseEntryPointClass2:%IsUseEntryPointClass2%]
if "%IsUseEntryPointClass2%"=="共通設定を使用" echo set IsUseEntryPointClass2=>IsUseEntryPointClass2.cmd
if "%IsUseEntryPointClass2%"=="共通設定を使用" echo 「IsUseEntryPointClass2」設定完了。[IsUseEntryPointClass2:%IsUseEntryPointClass2%]
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ■システム追加保存
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo set AppDirPath=%CppDirPath%\%AppName%>AppDirPath.cmd
echo 「AppDirPath」設定完了。[AppDirPath:%CppDirPath%\%AppName%]
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ************************************************************************************************

rem ************************************************************************************************
rem ★各種設定の結合とJenkinsのアプリ設定フォルダに設定を格納
rem ************************************************************************************************
copy AppName.cmd app_settings_base.cmd /Y
copy app_settings_base.cmd+AppJName.cmd app_settings_base.cmd /B /Y
copy app_settings_base.cmd+AppShortNameL.cmd app_settings_base.cmd /B /Y
copy app_settings_base.cmd+AppShortNameSL.cmd app_settings_base.cmd /B /Y
copy app_settings_base.cmd+IsUseAslLog2.cmd app_settings_base.cmd /B /Y
copy app_settings_base.cmd+IsUseEntryPointClass2.cmd app_settings_base.cmd /B /Y
copy app_settings_base.cmd+AppDirPath.cmd app_settings_base.cmd /B /Y
rem ------------------------------------------------------------------------------------------------
copy app_settings_base.cmd ..\%AppName%\settings\app_settings\app_settings_base.cmd /Y
rem ------------------------------------------------------------------------------------------------
call app_settings_base.cmd
rem ************************************************************************************************

rem ************************************************************************************************
rem ★共通設定のコピー
rem ************************************************************************************************
copy ..\settings\cpp_settings.cmd ..\%AppName%\settings\cpp_settings.cmd /Y
rem ************************************************************************************************

rem ************************************************************************************************
rem ★テンプレートからコードを生成する
rem ************************************************************************************************
set p1=/N
set p2=/ALL
set p3=
set p4=
set p5=
set p6=
set p7=
set p8=
set p9=
call %CppDirPath%\src\Application-h.cmd
if not %ERRORLEVEL%==0 exit %ERRORLEVEL%
rem ------------------------------------------------------------------------------------------------
rem ************************************************************************************************


rem ～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～
rem ↓他ジョブサポート関連

rem ************************************************************************************************
rem ★「settings」->「cpp_settings」のジョブ設定更新先追加
rem ************************************************************************************************
if not exist "..\settings\cpp_settings\setting_copys\." mkdir ..\settings\cpp_settings\setting_copys
rem ------------------------------------------------------------------------------------------------
echo copy ..\cpp_settings.cmd ..\..\%AppName%\settings\cpp_settings.cmd /Y>..\settings\cpp_settings\setting_copys\%AppName%.cmd
rem ************************************************************************************************


rem ～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～
rem ↓終了処理

rem ************************************************************************************************
rem ★完了メッセージ
rem ************************************************************************************************
echo 「%AppName%」の新規作成が完了しました。
echo _
echo jenkinsに以下のフォルダを作成してください。
echo 「%AppName%」
echo 「%AppName%\settings」
echo _
echo jenkinsに以下のジョブを作成してください。
echo 「%AppName%\settings\app_settings」
exit 0
rem ************************************************************************************************


rem ～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～
rem ↓エラー処理

rem ************************************************************************************************
rem ★エラーメッセージ
rem ************************************************************************************************
rem ************************************************************************************************
