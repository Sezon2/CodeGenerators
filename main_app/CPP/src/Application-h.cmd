rem //////////////////////////////////////////////////////////////////////////////////////////////////////////
rem 
rem     「Application.h」を自動生成するバッチ
rem 
rem //////////////////////////////////////////////////////////////////////////////////////////////////////////
rem 【必要なjenkins側の設定】
rem cpp_settings.cmd / app_settings_base.cmd
rem ----------------------------------------------------------------------------------------------------------
rem 【実行方法】※本バッチに対して以下のオプションを指定する事が出来ます。
rem set p1=<mode>
rem set p2=<mode_target>
rem set p3=<output_dir>
rem set p4=<include_class_path> ※【省略可】後からソースにinclude追加する時用。
rem set p5=<include_class_name> ※【省略可】後からソースにinclude追加する時用。
rem set p6=<include_class_jname>※【省略可】後からソースにinclude追加する時用。
rem set p7=<new_include_class_path> ※【省略可】既存のincludeを更新する時の新しいクラスパス。
rem set p8=<new_include_class_name> ※【省略可】既存のincludeを更新する時の新しいクラス名(英名)。
rem set p9=<new_include_class_jname>※【省略可】既存のincludeを更新する時の新しいクラス名(日本語名)。
rem Application-h.cmd
rem <mode>                   ：動作モード※値：/N＝新規作成[追加]・/U＝更新・/D＝削除
rem <mode_target>            ：動作対象※値：/ALL＝ファイル全体・/INC＝include部分
rem <output_dir>             ：出力先フォルダ（指定が無ければデフォルトの場所）
rem <include_class_path>     ：対象のinclude文のクラスフォルダとクラスのファイル名を除いたパス※「/」区切り。
rem <include_class_name>     ：対象のinclude文のクラスフォルダとクラスのファイル名(英名)
rem <include_class_jname>    ：対象のinclude文のクラスフォルダとクラスのファイル名(日本語名)
rem <new_include_class_path> ：新しいinclude文のクラスフォルダとクラスのファイル名を除いたパス※「/」区切り。
rem <new_include_class_name> ：新しいinclude文のクラスフォルダとクラスのファイル名(英名)
rem <new_include_class_jname>：新しいinclude文のクラスフォルダとクラスのファイル名(日本語名)
rem //////////////////////////////////////////////////////////////////////////////////////////////////////////

rem ************************************************************************************************
rem ★変数定義
rem ************************************************************************************************
set apph_prgname_=Application-h
set apph_task_id_=%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%
set apph_tmpl_dir_=%CppTemplateDirPath%\Application-h
rem ------------------------------------------------------------------------------------------------
set apph_is_use_asl_log_=%IsUseAslLog%
set apph_is_use_entry_point_class_=%IsUseEntryPointClass%
rem ------------------------------------------------------------------------------------------------
set apph_mode_=%p1%
set apph_mode2_=%p2%
set apph_output_=%AppDirPath%\result
set apph_class_path_=%p4%
set apph_class_name_=%p5%
set apph_class_jname_=%p6%
set apph_new_class_path_=%p7%
set apph_new_class_name_=%p8%
set apph_new_class_jname_=%p9%
rem ************************************************************************************************

rem ************************************************************************************************
rem ★引数適応/設定適応
rem ************************************************************************************************
if not "%p3%"=="" set apph_output_=%p3%
rem ------------------------------------------------------------------------------------------------
if not "%IsUseAslLog2%"=="" set apph_is_use_asl_log_=%IsUseAslLog2%
if not "%IsUseEntryPointClass2%"=="" set apph_is_use_entry_point_class_=%IsUseEntryPointClass2%
rem ************************************************************************************************

rem ************************************************************************************************
rem ★必要なファイルとフォルダの存在確認※適当ｗ
rem ************************************************************************************************
if not exist "%apph_tmpl_dir_%\." goto Error1
if not exist "%apph_tmpl_dir_%\base.h" goto Error2
if not exist "%apph_tmpl_dir_%\tag_include.cmd" goto Error3
if not exist "%apph_tmpl_dir_%\tag_include_*.cmd" goto Error3
if not exist "%apph_tmpl_dir_%\tag_*.cmd" goto Error3
if not exist "%apph_tmpl_dir_%\tagsys_*.cmd" goto Error4
if not exist "%apph_tmpl_dir_%\taguser_*.cmd" goto Error5
if not exist "%apph_tmpl_dir_%\tmpl_include_AslLog.cmd" goto Error6
if not exist "%apph_tmpl_dir_%\tmpl_include_Class.cmd" goto Error6
if not exist "%apph_tmpl_dir_%\tmpl_include_EntryPoint.cmd" goto Error6
if not exist "%apph_tmpl_dir_%\tmpl_*.cmd" goto Error6
if not exist "%apph_output_%\." goto Error7
rem ************************************************************************************************

rem ************************************************************************************************
rem ★動作モード判定と分岐
rem ************************************************************************************************
if "%apph_mode_%%apph_mode2_%"=="/N/ALL" goto LblNewAll
if "%apph_mode_%%apph_mode2_%"=="/N/INC" goto LblNewInclude
rem --------------------------------------------------------
rem if "%apph_mode_%%apph_mode2_%"=="/U/ALL" goto LblUpdateAll
if "%apph_mode_%%apph_mode2_%"=="/U/INC" goto LblUpdateInclude
rem --------------------------------------------------------
rem if "%apph_mode_%%apph_mode2_%"=="/D/ALL" goto LblDeleteAll
if "%apph_mode_%%apph_mode2_%"=="/D/INC" goto LblDeleteInclude
rem --------------------------------------------------------
goto Error100
rem ************************************************************************************************


rem ～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～
rem ↓メイン処理[新規作成＋ファイル全体]※初回作成時。

rem ************************************************************************************************
rem ★バッチの実行に関する有効性の確認
rem ************************************************************************************************
if exist "%apph_output_%\%AppName%.h" goto Error101
rem ************************************************************************************************

rem ************************************************************************************************
rem ★ソースファイルの構築
rem ************************************************************************************************
:LblNewAll
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ■インクルード領域のセットアップ
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
copy %apph_tmpl_dir_%\base.h %apph_output_%\%AppName%.h /Y
rem --------------------------------------------------------------------------------------
call %apph_tmpl_dir_%\tag_include.cmd
set replace_left_=\/\/%tag_mfind_%
call %apph_tmpl_dir_%\tag_include_next_root.cmd
set replace_right_=\/\/%tag_mfind_%\n\n{__join__}
mfind /W /Q "/%replace_left_%/%replace_right_%/g" %apph_output_%\%AppName%.h
rem --------------------------------------------------------
set replace_left_={__join__}
call %apph_tmpl_dir_%\tag_include.cmd
set replace_right_=\/\/%tag_mfind_%
mfind /W /Q "/%replace_left_%/%replace_right_%/g" %apph_output_%\%AppName%.h
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ■AslLogのインクルード追加※設定に応じて入れない。
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if not %apph_is_use_asl_log_%==true goto LblNA_Skip_AslLog
rem --------------------------------------------------------------------------------------
call %apph_tmpl_dir_%\tag_include_next_root.cmd
set replace_left_=\/\/%tag_mfind_%
call %apph_tmpl_dir_%\tmpl_include_AslLog.cmd
set replace_right_=%linetext_mfind_%\n{__join__}
mfind /W /Q "/%replace_left_%/%replace_right_%/g" %apph_output_%\%AppName%.h
rem --------------------------------------------------------
set replace_left_={__join__}
call %apph_tmpl_dir_%\tag_include_next_root.cmd
set replace_right_=\/\/%tag_mfind_%
mfind /W /Q "/%replace_left_%/%replace_right_%/g" %apph_output_%\%AppName%.h
rem --------------------------------------------------------------------------------------
:LblNA_Skip_AslLog
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ■EntryPointのインクルード追加※設定に応じて入れない。
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if not %apph_is_use_entry_point_class_%==true goto LblNA_Skip_EntryPoint
rem --------------------------------------------------------------------------------------
call %apph_tmpl_dir_%\tag_include.cmd
set replace_left_=\/\/%tag_mfind_%
call %apph_tmpl_dir_%\tag_include_next_System.cmd
set replace_right_=\/\/%tag_mfind_%\n\n{__join__}
mfind /W /Q "/%replace_left_%/%replace_right_%/g" %apph_output_%\%AppName%.h
rem --------------------------------------------------------
set replace_left_={__join__}
call %apph_tmpl_dir_%\tag_include.cmd
set replace_right_=\/\/%tag_mfind_%
mfind /W /Q "/%replace_left_%/%replace_right_%/g" %apph_output_%\%AppName%.h
rem --------------------------------------------------------------------------------------
call %apph_tmpl_dir_%\tag_include_next_System.cmd
set replace_left_=\/\/%tag_mfind_%
call %apph_tmpl_dir_%\tmpl_include_EntryPoint.cmd
set replace_right_=%linetext_mfind_%\n{__join__}
mfind /W /Q "/%replace_left_%/%replace_right_%/g" %apph_output_%\%AppName%.h
rem --------------------------------------------------------
set replace_left_={__join__}
call %apph_tmpl_dir_%\tag_include_next_System.cmd
set replace_right_=\/\/%tag_mfind_%
mfind /W /Q "/%replace_left_%/%replace_right_%/g" %apph_output_%\%AppName%.h
rem --------------------------------------------------------------------------------------
:LblNA_Skip_EntryPoint
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ■バッチ設定値の置換
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
call %apph_tmpl_dir_%\tagsys_task_id_.cmd
set replace_left_=%tagsys_mfind_%
set replace_right_=%apph_task_id_%
mfind /W /Q "/%replace_left_%/%replace_right_%/g" %apph_output_%\%AppName%.h
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ■Jenkins設定値の置換
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
set p1=%apph_output_%\%AppName%.h
call %GeneratorDirPath%\src\jenkins_env_replace.cmd
if not %ERRORLEVEL%==0 goto Error200
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ■ユーザー設定値の置換
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
call %apph_tmpl_dir_%\taguser_AppName.cmd
set replace_left_=%taguser_mfind_%
set replace_right_=%AppName%
mfind /W /Q "/%replace_left_%/%replace_right_%/g" %apph_output_%\%AppName%.h
rem --------------------------------------------------------
call %apph_tmpl_dir_%\taguser_AppJName.cmd
set replace_left_=%taguser_mfind_%
set replace_right_=%AppJName%
mfind /W /Q "/%replace_left_%/%replace_right_%/g" %apph_output_%\%AppName%.h
rem --------------------------------------------------------
call %apph_tmpl_dir_%\taguser_AppShortNameL.cmd
set replace_left_=%taguser_mfind_%
set replace_right_=%AppShortNameL%
mfind /W /Q "/%replace_left_%/%replace_right_%/g" %apph_output_%\%AppName%.h
rem --------------------------------------------------------
call %apph_tmpl_dir_%\taguser_AppShortNameSL.cmd
set replace_left_=%taguser_mfind_%
set replace_right_=%AppShortNameSL%
mfind /W /Q "/%replace_left_%/%replace_right_%/g" %apph_output_%\%AppName%.h
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
goto LblFinish
rem ************************************************************************************************


rem ～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～
rem ↓メイン処理[インクルードの追加]

rem ************************************************************************************************
rem ★バッチの実行に関する有効性の確認
rem ************************************************************************************************
if not exist "%apph_output_%\%AppName%.h" goto Error102
rem ************************************************************************************************

rem ************************************************************************************************
rem ★
rem ************************************************************************************************
:LblNewInclude
rem ------------------------------------------------------------------------------------------------
goto LblFinish
rem ************************************************************************************************


rem ～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～
rem ↓メイン処理[インクルードの更新]

rem ************************************************************************************************
rem ★バッチの実行に関する有効性の確認
rem ************************************************************************************************
if not exist "%apph_output_%\%AppName%.h" goto Error102
rem ************************************************************************************************

rem ************************************************************************************************
rem ★
rem ************************************************************************************************
:LblUpdateInclude
rem ------------------------------------------------------------------------------------------------
goto LblFinish
rem ************************************************************************************************


rem ～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～
rem ↓メイン処理[インクルードの削除]

rem ************************************************************************************************
rem ★バッチの実行に関する有効性の確認
rem ************************************************************************************************
if not exist "%apph_output_%\%AppName%.h" goto Error102
rem ************************************************************************************************

rem ************************************************************************************************
rem ★
rem ************************************************************************************************
:LblDeleteInclude
rem ------------------------------------------------------------------------------------------------
goto LblFinish
rem ************************************************************************************************


rem ～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～
rem ↓終了処理

rem ************************************************************************************************
rem ★完了メッセージ
rem ************************************************************************************************
:LblFinish
echo [%apph_prgname_%]_「%AppName%.h」作成完了。
exit /b 0
rem ************************************************************************************************


rem ～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～～
rem ↓エラー処理

rem ************************************************************************************************
rem ★エラーメッセージ
rem ************************************************************************************************
:Error1
echo [%apph_prgname_%]_[Error]テンプレートディレクトリが見つかりません。
echo 利用しようとした値：%apph_tmpl_dir_%
exit /b -1
rem ------------------------------------------------------------------------------------------------
:Error2
echo [%apph_prgname_%]_[Error]ソース生成用の基本テンプレートファイルが見つかりません。
echo 利用しようとした値：%apph_tmpl_dir_%\base.h
exit /b -1
rem ------------------------------------------------------------------------------------------------
:Error3
echo [%apph_prgname_%]_[Error]必要な置換用特殊タグ定義ファイルがありません。
echo 利用しようとした値：%apph_tmpl_dir_%\tag_*.cmd
exit /b -1
rem ------------------------------------------------------------------------------------------------
:Error4
echo [%apph_prgname_%]_[Error]必要な置換用特殊タグ定義ファイル^(システム用^)がありません。
echo 利用しようとした値：%apph_tmpl_dir_%\tagsys_*.cmd
exit /b -1
rem ------------------------------------------------------------------------------------------------
:Error5
echo [%apph_prgname_%]_[Error]必要な置換用特殊タグ定義ファイル^(ユーザー設定用^)がありません。
echo 利用しようとした値：%apph_tmpl_dir_%\taguser_*.cmd
exit /b -1
rem ------------------------------------------------------------------------------------------------
:Error6
echo [%apph_prgname_%]_[Error]必要なテンプレートコマンドファイルがありません。
echo 利用しようとした値：%apph_tmpl_dir_%\tmpl_*.cmd
exit /b -1
rem ------------------------------------------------------------------------------------------------
:Error7
echo [%apph_prgname_%]_[Error]出力先フォルダが見つかりません。
echo 利用しようとした値：%apph_output_%
exit /b -1
rem ------------------------------------------------------------------------------------------------
:Error100
echo [%apph_prgname_%]_[Error]不明なモードの組み合わせです。[mode:%apph_mode_%][mode2:%apph_mode2_%]
exit /b -2
rem ------------------------------------------------------------------------------------------------
:Error101
echo [%apph_prgname_%]_[Error]既にソースファイルは作成済みです。
exit /b -2
rem ------------------------------------------------------------------------------------------------
:Error102
echo [%apph_prgname_%]_[Error]ソースファイルがありません。
exit /b -2
rem ------------------------------------------------------------------------------------------------
:Error200
echo [%apph_prgname_%]_[Error]モジュールの実行中にエラーが発生しました。
exit /b -3
rem ************************************************************************************************

rem //////////////////////////////////////////////////////////////////////////////////////////////////////////
