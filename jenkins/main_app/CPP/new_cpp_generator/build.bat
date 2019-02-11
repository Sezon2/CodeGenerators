@echo off
rem ************************************************************************************************
rem ���ݒ�m�F
rem ************************************************************************************************
echo �ݒ�̊m�F��...
rem ------------------------------------------------------------------------------------------------
if not exist "..\settings\jenkins_settings.cmd" (
	echo ���ʐݒ肪��������Ă��܂���B
	echo �usettings\jenkins_settings�v�̃W���u�ŏ����ݒ���s�Ȃ��Ă��������B
	exit -1
)
rem ------------------------------------------------------------------------------------------------
if not exist "..\settings\cpp_settings.cmd" (
	echo CPP���ʐݒ肪��������Ă��܂���B
	echo �umain_app\CPP\settings\cpp_settings�v�̃W���u�ŏ����ݒ���s�Ȃ��Ă��������B
	exit -1
)
rem ************************************************************************************************

rem ************************************************************************************************
rem ���ϐ���`
rem ************************************************************************************************
set task_id_=%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%
rem ************************************************************************************************

rem ************************************************************************************************
rem �����񏈗�
rem ************************************************************************************************
call ..\settings\cpp_settings.cmd
rem ------------------------------------------------------------------------------------------------
set PATH=%PATH%;%LibDirPath%
rem ************************************************************************************************

rem ************************************************************************************************
rem �����̓`�F�b�N
rem ************************************************************************************************
call %GeneratorDirPath%\src\input_chk\required_input.cmd AppName %AppName%
call %GeneratorDirPath%\src\input_chk\required_input.cmd AppJName %AppJName%
call %GeneratorDirPath%\src\input_chk\required_input.cmd AppShortNameL %AppShortNameL%
call %GeneratorDirPath%\src\input_chk\required_input.cmd AppShortNameSL %AppShortNameSL%
rem ************************************************************************************************

rem ************************************************************************************************
rem ���W���u�̎��s�Ɋւ���L�����̊m�F
rem ************************************************************************************************
if exist "..\%AppName%\." (
	echo �u%AppName%�v���̃A�v���P�[�V�����͍쐬�ς݂ł��B
	exit -1
)
rem ------------------------------------------------------------------------------------------------
set p1=%CppTemplateDirPath%
set p2=�R�[�h�e���v���[�g�t�H���_
call %GeneratorDirPath%\src\filedir_chk\required_dir.cmd
rem ------------------------------------------------------------------------------------------------
set p1=%CppDirPath%\src
set p2=�R�[�h�������W���[���\�[�X�t�H���_
call %GeneratorDirPath%\src\filedir_chk\required_dir.cmd
rem ************************************************************************************************


rem �`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`
rem �����C������

rem ************************************************************************************************
rem ���V�����A�v���P�[�V�����̃t�H���_���쐬
rem ************************************************************************************************
if not exist "..\%AppName%\." mkdir ..\%AppName%
if not exist "..\%AppName%\settings\." mkdir ..\%AppName%\settings
if not exist "..\%AppName%\settings\app_settings\." mkdir ..\%AppName%\settings\app_settings
rem ------------------------------------------------------------------------------------------------
if not exist "%CppDirPath%\%AppName%\." mkdir %CppDirPath%\%AppName%
if not exist "%CppDirPath%\%AppName%\result\." mkdir %CppDirPath%\%AppName%\result
rem ************************************************************************************************

rem ************************************************************************************************
rem ���e��ݒ�̏����o��
rem ************************************************************************************************
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem �����͂��ꂽ�l�n�����݊m�F�s�v�n
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if not "%AppName%"=="" echo set AppName=%AppName%>AppName.cmd
if not "%AppName%"=="" echo �uAppName�v�ݒ芮���B[AppName:%AppName%]
rem --------------------------------------------------------
if not "%AppJName%"=="" echo set AppJName=%AppJName%>AppJName.cmd
if not "%AppJName%"=="" echo �uAppJName�v�ݒ芮���B[AppJName:%AppJName%]
rem --------------------------------------------------------
if not "%AppShortNameL%"=="" echo set AppShortNameL=%AppShortNameL%>AppShortNameL.cmd
if not "%AppShortNameL%"=="" echo �uAppShortNameL�v�ݒ芮���B[AppShortNameL:%AppShortNameL%]
rem --------------------------------------------------------
if not "%AppShortNameSL%"=="" echo set AppShortNameSL=%AppShortNameSL%>AppShortNameSL.cmd
if not "%AppShortNameSL%"=="" echo �uAppShortNameSL�v�ݒ芮���B[AppShortNameSL:%AppShortNameSL%]
rem --------------------------------------------------------
if not "%IsUseAslLog2%"=="���ʐݒ���g�p" echo set IsUseAslLog2=%IsUseAslLog2%>IsUseAslLog2.cmd
if not "%IsUseAslLog2%"=="���ʐݒ���g�p" echo �uIsUseAslLog2�v�ݒ芮���B[IsUseAslLog2:%IsUseAslLog2%]
if "%IsUseAslLog2%"=="���ʐݒ���g�p" echo set IsUseAslLog2=>IsUseAslLog2.cmd
if "%IsUseAslLog2%"=="���ʐݒ���g�p" echo �uIsUseAslLog2�v�ݒ芮���B[IsUseAslLog2:%IsUseAslLog2%]
rem --------------------------------------------------------
if not "%IsUseEntryPointClass2%"=="���ʐݒ���g�p" echo set IsUseEntryPointClass2=%IsUseEntryPointClass2%>IsUseEntryPointClass2.cmd
if not "%IsUseEntryPointClass2%"=="���ʐݒ���g�p" echo �uIsUseEntryPointClass2�v�ݒ芮���B[IsUseEntryPointClass2:%IsUseEntryPointClass2%]
if "%IsUseEntryPointClass2%"=="���ʐݒ���g�p" echo set IsUseEntryPointClass2=>IsUseEntryPointClass2.cmd
if "%IsUseEntryPointClass2%"=="���ʐݒ���g�p" echo �uIsUseEntryPointClass2�v�ݒ芮���B[IsUseEntryPointClass2:%IsUseEntryPointClass2%]
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ���V�X�e���ǉ��ۑ�
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo set AppDirPath=%CppDirPath%\%AppName%>AppDirPath.cmd
echo �uAppDirPath�v�ݒ芮���B[AppDirPath:%CppDirPath%\%AppName%]
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ************************************************************************************************

rem ************************************************************************************************
rem ���e��ݒ�̌�����Jenkins�̃A�v���ݒ�t�H���_�ɐݒ���i�[
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
rem �����ʐݒ�̃R�s�[
rem ************************************************************************************************
copy ..\settings\cpp_settings.cmd ..\%AppName%\settings\cpp_settings.cmd /Y
rem ************************************************************************************************

rem ************************************************************************************************
rem ���e���v���[�g����R�[�h�𐶐�����
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


rem �`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`
rem �����W���u�T�|�[�g�֘A

rem ************************************************************************************************
rem ���usettings�v->�ucpp_settings�v�̃W���u�ݒ�X�V��ǉ�
rem ************************************************************************************************
if not exist "..\settings\cpp_settings\setting_copys\." mkdir ..\settings\cpp_settings\setting_copys
rem ------------------------------------------------------------------------------------------------
echo copy ..\cpp_settings.cmd ..\..\%AppName%\settings\cpp_settings.cmd /Y>..\settings\cpp_settings\setting_copys\%AppName%.cmd
rem ************************************************************************************************


rem �`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`
rem ���I������

rem ************************************************************************************************
rem ���������b�Z�[�W
rem ************************************************************************************************
echo �u%AppName%�v�̐V�K�쐬���������܂����B
echo _
echo jenkins�Ɉȉ��̃t�H���_���쐬���Ă��������B
echo �u%AppName%�v
echo �u%AppName%\settings�v
echo _
echo jenkins�Ɉȉ��̃W���u���쐬���Ă��������B
echo �u%AppName%\settings\app_settings�v
exit 0
rem ************************************************************************************************


rem �`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`
rem ���G���[����

rem ************************************************************************************************
rem ���G���[���b�Z�[�W
rem ************************************************************************************************
rem ************************************************************************************************
