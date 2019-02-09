@echo off
rem ************************************************************************************************
rem ★初回ビルドチェック
rem ************************************************************************************************
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ■CodeGeneratorのルートパス
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if not exist "GeneratorDirPath.cmd" if "%GeneratorDirPath%"=="" (
	echo 初回ビルド時は「GeneratorDirPath」の入力は必須です。
	exit -1
)
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ■CodeGenerator(C/C++)のルートパス
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if not exist "CppDirPath.cmd" if "%CppDirPath%"=="" (
	echo 初回ビルド時は「CppDirPath」の入力は必須です。
	exit -1
)
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ************************************************************************************************

rem ************************************************************************************************
rem ★変数定義
rem ************************************************************************************************
set cur_dir_=%cd%
rem ************************************************************************************************

rem ************************************************************************************************
rem ★ファイルの新規作成(ない場合)と初期設定呼び出し
rem ************************************************************************************************
echo ファイルの存在チェックと必要に応じて新規作成中...
if not exist "GeneratorDirPath.cmd" echo set GeneratorDirPath=>GeneratorDirPath.cmd
if not exist "CppDirPath.cmd" echo set CppDirPath=>CppDirPath.cmd
rem ------------------------------------------------------------------------------------------------
if "%GeneratorDirPath%"=="" call GeneratorDirPath.cmd
rem ************************************************************************************************

rem ************************************************************************************************
rem ★各種設定の書き出し
rem ************************************************************************************************
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ■CodeGeneratorのルートパス
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if not "%GeneratorDirPath%"=="" (
	if not exist "%GeneratorDirPath%\." (
		echo CodeGeneratorのルートパスが見つかりません。
		echo 設定された値：%GeneratorDirPath%
		exit -1
	)
	echo set GeneratorDirPath=%GeneratorDirPath%>GeneratorDirPath.cmd
	echo 「GeneratorDirPath」設定完了。[GeneratorDirPath:%GeneratorDirPath%]
)
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ■CodeGenerator(C/C++)のルートパス
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if not "%CppDirPath%"=="" (
	if not exist "%GeneratorDirPath%\main_app\%CppDirPath%\." (
		echo C/C++用のCodeGeneratorのパスが見つかりません。
		echo 設定された値：%GeneratorDirPath%\main_app\%CppDirPath%
		exit -1
	)
	echo set CppDirPath=%GeneratorDirPath%\main_app\%CppDirPath%>CppDirPath.cmd
	echo 「CppDirPath」設定完了。[CppDirPath:%GeneratorDirPath%\main_app\%CppDirPath%]
)
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ■共通コマンド拡張フォルダパス
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if not "%GeneratorDirPath%"=="" (
	if not exist "%GeneratorDirPath%\lib\." (
		echo 共通コマンド拡張フォルダパスが見つかりません。
		echo 設定された値：%GeneratorDirPath%\lib
		exit -1
	)
	echo set LibDirPath=%GeneratorDirPath%\lib>LibDirPath.cmd
	echo 「LibDirPath」設定完了。[LibDirPath:%GeneratorDirPath%\lib]
)
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ■jenkinsのルートフォルダパス
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
cd ..\..\..\
echo set JenkinsRootDirPath=%cd%>%cur_dir_%\JenkinsRootDirPath.cmd
echo 「JenkinsRootDirPath」設定完了。[JenkinsRootDirPath:%cd%]
cd %cur_dir_%
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ************************************************************************************************

rem ************************************************************************************************
rem ★存在しないフォルダの作成
rem ************************************************************************************************
if not exist "%GeneratorDirPath%\settings\." mkdir %GeneratorDirPath%\settings
rem ************************************************************************************************

rem ************************************************************************************************
rem ★全ての設定の結合
rem ************************************************************************************************
copy GeneratorDirPath.cmd+CppDirPath.cmd jenkins_include_paths.cmd /B /Y
copy jenkins_include_paths.cmd+LibDirPath.cmd jenkins_include_paths.cmd /B /Y
copy jenkins_include_paths.cmd+JenkinsRootDirPath.cmd jenkins_include_paths.cmd /B /Y
rem ************************************************************************************************
