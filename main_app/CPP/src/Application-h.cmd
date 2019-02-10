rem //////////////////////////////////////////////////////////////////////////////////////////////////////////
rem 
rem     �uApplication.h�v��������������o�b�`
rem 
rem //////////////////////////////////////////////////////////////////////////////////////////////////////////
rem �y�K�v��jenkins���̐ݒ�z
rem cpp_settings.cmd / app_settings_base.cmd
rem ----------------------------------------------------------------------------------------------------------
rem �y���s���@�z���{�o�b�`�ɑ΂��Ĉȉ��̃I�v�V�������w�肷�鎖���o���܂��B
rem set p1=<mode>
rem set p2=<mode_target>
rem set p3=<output_dir>
rem set p4=<include_class_path> ���y�ȗ��z�ォ��\�[�X��include�ǉ����鎞�p�B
rem set p5=<include_class_name> ���y�ȗ��z�ォ��\�[�X��include�ǉ����鎞�p�B
rem set p6=<include_class_jname>���y�ȗ��z�ォ��\�[�X��include�ǉ����鎞�p�B
rem set p7=<new_include_class_path> ���y�ȗ��z������include���X�V���鎞�̐V�����N���X�p�X�B
rem set p8=<new_include_class_name> ���y�ȗ��z������include���X�V���鎞�̐V�����N���X��(�p��)�B
rem set p9=<new_include_class_jname>���y�ȗ��z������include���X�V���鎞�̐V�����N���X��(���{�ꖼ)�B
rem Application-h.cmd
rem <mode>                   �F���샂�[�h���l�F/N���V�K�쐬[�ǉ�]�E/U���X�V�E/D���폜
rem <mode_target>            �F����Ώہ��l�F/ALL���t�@�C���S�́E/INC��include����
rem <output_dir>             �F�o�͐�t�H���_�i�w�肪������΃f�t�H���g�̏ꏊ�j
rem <include_class_path>     �F�Ώۂ�include���̃N���X�t�H���_�ƃN���X�̃t�@�C�������������p�X���u/�v��؂�B
rem <include_class_name>     �F�Ώۂ�include���̃N���X�t�H���_�ƃN���X�̃t�@�C����(�p��)
rem <include_class_jname>    �F�Ώۂ�include���̃N���X�t�H���_�ƃN���X�̃t�@�C����(���{�ꖼ)
rem <new_include_class_path> �F�V����include���̃N���X�t�H���_�ƃN���X�̃t�@�C�������������p�X���u/�v��؂�B
rem <new_include_class_name> �F�V����include���̃N���X�t�H���_�ƃN���X�̃t�@�C����(�p��)
rem <new_include_class_jname>�F�V����include���̃N���X�t�H���_�ƃN���X�̃t�@�C����(���{�ꖼ)
rem //////////////////////////////////////////////////////////////////////////////////////////////////////////

rem ************************************************************************************************
rem ���ϐ���`
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
rem �������K��/�ݒ�K��
rem ************************************************************************************************
if not "%p3%"=="" set apph_output_=%p3%
rem ------------------------------------------------------------------------------------------------
if not "%IsUseAslLog2%"=="" set apph_is_use_asl_log_=%IsUseAslLog2%
if not "%IsUseEntryPointClass2%"=="" set apph_is_use_entry_point_class_=%IsUseEntryPointClass2%
rem ************************************************************************************************

rem ************************************************************************************************
rem ���K�v�ȃt�@�C���ƃt�H���_�̑��݊m�F���K����
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
rem �����샂�[�h����ƕ���
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


rem �`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`
rem �����C������[�V�K�쐬�{�t�@�C���S��]������쐬���B

rem ************************************************************************************************
rem ���o�b�`�̎��s�Ɋւ���L�����̊m�F
rem ************************************************************************************************
if exist "%apph_output_%\%AppName%.h" goto Error101
rem ************************************************************************************************

rem ************************************************************************************************
rem ���\�[�X�t�@�C���̍\�z
rem ************************************************************************************************
:LblNewAll
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ���C���N���[�h�̈�̃Z�b�g�A�b�v
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
rem ��AslLog�̃C���N���[�h�ǉ����ݒ�ɉ����ē���Ȃ��B
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
rem ��EntryPoint�̃C���N���[�h�ǉ����ݒ�ɉ����ē���Ȃ��B
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
rem ���o�b�`�ݒ�l�̒u��
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
call %apph_tmpl_dir_%\tagsys_task_id_.cmd
set replace_left_=%tagsys_mfind_%
set replace_right_=%apph_task_id_%
mfind /W /Q "/%replace_left_%/%replace_right_%/g" %apph_output_%\%AppName%.h
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ��Jenkins�ݒ�l�̒u��
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
set p1=%apph_output_%\%AppName%.h
call %GeneratorDirPath%\src\jenkins_env_replace.cmd
if not %ERRORLEVEL%==0 goto Error200
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
rem �����[�U�[�ݒ�l�̒u��
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


rem �`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`
rem �����C������[�C���N���[�h�̒ǉ�]

rem ************************************************************************************************
rem ���o�b�`�̎��s�Ɋւ���L�����̊m�F
rem ************************************************************************************************
if not exist "%apph_output_%\%AppName%.h" goto Error102
rem ************************************************************************************************

rem ************************************************************************************************
rem ��
rem ************************************************************************************************
:LblNewInclude
rem ------------------------------------------------------------------------------------------------
goto LblFinish
rem ************************************************************************************************


rem �`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`
rem �����C������[�C���N���[�h�̍X�V]

rem ************************************************************************************************
rem ���o�b�`�̎��s�Ɋւ���L�����̊m�F
rem ************************************************************************************************
if not exist "%apph_output_%\%AppName%.h" goto Error102
rem ************************************************************************************************

rem ************************************************************************************************
rem ��
rem ************************************************************************************************
:LblUpdateInclude
rem ------------------------------------------------------------------------------------------------
goto LblFinish
rem ************************************************************************************************


rem �`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`
rem �����C������[�C���N���[�h�̍폜]

rem ************************************************************************************************
rem ���o�b�`�̎��s�Ɋւ���L�����̊m�F
rem ************************************************************************************************
if not exist "%apph_output_%\%AppName%.h" goto Error102
rem ************************************************************************************************

rem ************************************************************************************************
rem ��
rem ************************************************************************************************
:LblDeleteInclude
rem ------------------------------------------------------------------------------------------------
goto LblFinish
rem ************************************************************************************************


rem �`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`
rem ���I������

rem ************************************************************************************************
rem ���������b�Z�[�W
rem ************************************************************************************************
:LblFinish
echo [%apph_prgname_%]_�u%AppName%.h�v�쐬�����B
exit /b 0
rem ************************************************************************************************


rem �`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`�`
rem ���G���[����

rem ************************************************************************************************
rem ���G���[���b�Z�[�W
rem ************************************************************************************************
:Error1
echo [%apph_prgname_%]_[Error]�e���v���[�g�f�B���N�g����������܂���B
echo ���p���悤�Ƃ����l�F%apph_tmpl_dir_%
exit /b -1
rem ------------------------------------------------------------------------------------------------
:Error2
echo [%apph_prgname_%]_[Error]�\�[�X�����p�̊�{�e���v���[�g�t�@�C����������܂���B
echo ���p���悤�Ƃ����l�F%apph_tmpl_dir_%\base.h
exit /b -1
rem ------------------------------------------------------------------------------------------------
:Error3
echo [%apph_prgname_%]_[Error]�K�v�Ȓu���p����^�O��`�t�@�C��������܂���B
echo ���p���悤�Ƃ����l�F%apph_tmpl_dir_%\tag_*.cmd
exit /b -1
rem ------------------------------------------------------------------------------------------------
:Error4
echo [%apph_prgname_%]_[Error]�K�v�Ȓu���p����^�O��`�t�@�C��^(�V�X�e���p^)������܂���B
echo ���p���悤�Ƃ����l�F%apph_tmpl_dir_%\tagsys_*.cmd
exit /b -1
rem ------------------------------------------------------------------------------------------------
:Error5
echo [%apph_prgname_%]_[Error]�K�v�Ȓu���p����^�O��`�t�@�C��^(���[�U�[�ݒ�p^)������܂���B
echo ���p���悤�Ƃ����l�F%apph_tmpl_dir_%\taguser_*.cmd
exit /b -1
rem ------------------------------------------------------------------------------------------------
:Error6
echo [%apph_prgname_%]_[Error]�K�v�ȃe���v���[�g�R�}���h�t�@�C��������܂���B
echo ���p���悤�Ƃ����l�F%apph_tmpl_dir_%\tmpl_*.cmd
exit /b -1
rem ------------------------------------------------------------------------------------------------
:Error7
echo [%apph_prgname_%]_[Error]�o�͐�t�H���_��������܂���B
echo ���p���悤�Ƃ����l�F%apph_output_%
exit /b -1
rem ------------------------------------------------------------------------------------------------
:Error100
echo [%apph_prgname_%]_[Error]�s���ȃ��[�h�̑g�ݍ��킹�ł��B[mode:%apph_mode_%][mode2:%apph_mode2_%]
exit /b -2
rem ------------------------------------------------------------------------------------------------
:Error101
echo [%apph_prgname_%]_[Error]���Ƀ\�[�X�t�@�C���͍쐬�ς݂ł��B
exit /b -2
rem ------------------------------------------------------------------------------------------------
:Error102
echo [%apph_prgname_%]_[Error]�\�[�X�t�@�C��������܂���B
exit /b -2
rem ------------------------------------------------------------------------------------------------
:Error200
echo [%apph_prgname_%]_[Error]���W���[���̎��s���ɃG���[���������܂����B
exit /b -3
rem ************************************************************************************************

rem //////////////////////////////////////////////////////////////////////////////////////////////////////////
