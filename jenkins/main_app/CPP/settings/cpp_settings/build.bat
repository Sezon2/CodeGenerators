@echo off
rem ************************************************************************************************
rem ������r���h�`�F�b�N
rem ************************************************************************************************
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ��cpp_settings_common�̊m�F
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if not exist "..\common\cpp_settings_common.cmd" (
	echo �ucpp_settings_common�v�����ݒ�ł��B
	echo �umain_app\CPP\settings\common�v�̃W���u�ŏ����ݒ���s�Ȃ��Ă��������B
	exit -1
)
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ************************************************************************************************

rem ************************************************************************************************
rem �����񏈗�
rem ************************************************************************************************
call ..\jenkins_settings.cmd
rem ------------------------------------------------------------------------------------------------
set PATH=%PATH%;%LibDirPath%
rem ************************************************************************************************

rem ************************************************************************************************
rem ���S�Ă̐ݒ�̌���
rem ************************************************************************************************
copy ..\common\cpp_settings_common.cmd cpp_settings.cmd /B /Y
copy cpp_settings.cmd+..\jenkins_settings.cmd cpp_settings.cmd /B /Y
copy cpp_settings.cmd ..\cpp_settings.cmd /B /Y
rem ************************************************************************************************

rem ************************************************************************************************
rem ���v���W�F�N�g����CodeGenerator�ɓK��
rem ************************************************************************************************
if exist "setting_copys\." (
	dir setting_copys\*.cmd /B>setting_copys.cmd
	mfind /W /Q "/^/call setting_copys\\/g" setting_copys.cmd
	call setting_copys.cmd
)
rem ************************************************************************************************