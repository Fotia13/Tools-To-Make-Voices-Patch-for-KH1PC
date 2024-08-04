REM Hello I'm the batch that does everything, if you want to make a voice patch for KH1 put every files needed in "OGFilesHere" and run me
@echo off

python --version >nul 2>&1
if errorlevel 1 (
	echo Python is needed at a moment in the script please download and install it on www.python.org/downloads
	exit /b 1
)


REM First action: Normalize every volume with ffmpeg
for /D %%f in (OGFilesHere/*) do (
	if not exist "input\%%f" (
		mkdir "input\%%f"
    )
	for %%w in ("OGFilesHere/%%f/*.wav") do (
		echo Normalizing %%f
		ffmpeg-normalize "OGFilesHere/%%f/%%w" -nt peak -t -0.12 -o "input/%%f/%%w"
	)
	for %%s in ("OGFilesHere/%%f/*.scd") do (
		copy "OGFilesHere\%%f\%%s" "input\%%f\."
	)
)
echo Every files is now normalized switching to the packing!


REM Second action: Pack every wav files into scd files that the game use
for /D %%f in (input/*) do (
	if not exist "output\%%f" (
		mkdir "output\%%f\"
	)
	if not exist input/%%f/1.wav (
		for %%w in (input/%%f/*.wav) do (
			copy "input\%%f\%%w" .
			copy "input\%%f\%%~nw.win32.scd" .
			ren "%%w" "1.wav"

			MultiEncoder.exe "%%~nw.win32.scd" 10
			copy "output\%%~nw.win32.scd" "output\%%f\."
			del /Q output\*.scd
			del /Q *.scd
			del /Q *.wav
		)
	)
	if exist input/%%f/1.wav (
		copy "input/%%f" .
		for %%s in (*.scd) do (
			MultiEncoder.exe "%%s" 10
			copy "output\%%~ns.scd" "output\%%f\."
			del /Q output\*.scd
		)
		del /Q *.scd
		del /Q *.wav
	)
)
echo Every files is now packed in scd switching to the hex edit!
rmdir /Q /S input


REM Third action: Edit every files in hexadecimal to maximise the volume
for /D %%f in (output/*) do (
	for %%s in ("output/%%f/*.scd") do (
		HexEditVolumeToMax.py output\%%f\%%s
	)
)
echo Every files is now hex edited to be the highest possible volume, the volume cannot be higher without clipping switching to the purging of useless files!


REM Fourth action: Creating the empty files that replace the useless files to make space
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_ex_4042.mdls\ge01at00.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_ex_4042.mdls\ge01ex03.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_ex_4042.mdls\ge01ma01.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_ex_4042.mdls\ge01ma02.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_ex_4042.mdls\ge01ma03-2.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_ex_4042.mdls\ge01ma04.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_ex_4042.mdls\ge01ma05.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_ex_4042.mdls\ge01ma06.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_ex_4042.mdls\ge01ma09.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_ex_4042.mdls\ge01ma10.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_ex_4042.mdls\ge01ma11.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_ex_4042.mdls\ge01ma12.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_ex_4042.mdls\ge01ma13.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_ex_4042.mdls\ge01mx14.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_ex_4060.mdls\mu00ex00.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_ex_4060.mdls\mu00ex01.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_tz_3040.mdls\cl00at00.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_tz_3040.mdls\cl00at01.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_tz_3040.mdls\cl00at07.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_tz_3040.mdls\cl00at10.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_tz_3040.mdls\cl00at12.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_tz_3040.mdls\cl00ex01.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_tz_3040.mdls\cl00ex04.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_tz_3040.mdls\cl00ex05.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_tz_3040.mdls\cl00ex06.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_tz_3040.mdls\cl00ex10.win32.scd"
xcopy "videofficiel.scd" "kh1_fifth\remastered\xa_tz_3040.mdls\cl00ex13.win32.scd"
xcopy "videofficiel.scd" "kh1_first\remastered\voice\event\di\di_021.vset\di1603sr.win32.scd"
xcopy "videofficiel.scd" "kh1_first\remastered\voice\event\tw\tw_002.vset\tw0115sr.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\ew\ew_012.vset\ew0222an.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\he\he_051.vset\he2418sr.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\lm\lm_004.vset\lm0402sr.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_001.vset\nm0501jc.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_001.vset\nm0502fi.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_001.vset\nm0503jc.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_001.vset\nm0504jc.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_001.vset\nm0505fi.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_001.vset\nm0506jc.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_001.vset\nm0507fi.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_002.vset\nm0601jc.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_002.vset\nm0602sr.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_002.vset\nm0603jc.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_002.vset\nm0604sr.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_002.vset\nm0605jc.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_002.vset\nm0606jc.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_002.vset\nm0607jc.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_003.vset\nm0701my.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_003.vset\nm0702my.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_003.vset\nm0703jc.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_004.vset\nm1101bo.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_004.vset\nm1102bo.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_006.vset\nm1801jc.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_008.vset\nm2202bo.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_008.vset\nm2203bo.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_008.vset\nm2204bo.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_008.vset\nm22a1bo.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_009.vset\nm2301bo.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_010.vset\nm0608jc.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_010.vset\nm0609jc.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_010.vset\nm0610fi.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_010.vset\nm0611jc.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_010.vset\nm0612jc.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_010.vset\nm0613jc.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\nm\nm_010.vset\nm0614jc.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pc\pc_073.vset\pc0417do.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pc\pc_073.vset\pc0418go.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pc\pc_102.vset\pc0609rk.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pc\pc_202.vset\pc14a1go.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pc\pc_202.vset\pc14a2go.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pc\pc_241.vset\pc18a1do.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pc\pc_241.vset\pc18a2go.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pc\pc_321.vset\pc2201go.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pc\pc_321.vset\pc2202le.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pi\pi_017.vset\pi17a1ji.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pi\pi_019.vset\pi17a1ji.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\po\po_016.vset\po1101po.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\po\po_016.vset\po1102ti.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\po\po_016.vset\po1103ti.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\po\po_016.vset\po1104ti.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\po\po_016.vset\po1105ti.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\po\po_016.vset\po1106ti.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pp\pp_000.vset\pp0008ma.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pp\pp_000.vset\pp0009ma.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pp\pp_000.vset\pp0010ma.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pp\pp_000.vset\pp0011ma.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pp\pp_000.vset\pp0012rk.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pp\pp_001.vset\pp0001rk.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pp\pp_001.vset\pp0002ma.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pp\pp_001.vset\pp0003rk.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pp\pp_001.vset\pp0004ma.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pp\pp_001.vset\pp0005rk.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pp\pp_001.vset\pp0006ma.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pp\pp_001.vset\pp0007ma.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pp\pp_120.vset\pp14a1sr.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pp\pp_120.vset\pp14a2do.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\pp\pp_120.vset\pp14a3go.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\tw\tw_020.vset\tw13a3do.win32.scd"
xcopy "videofficiel.scd" "kh1_fourth\remastered\voice\event\tw\tw_020.vset\tw13b3do.win32.scd"
xcopy "videofficiel.scd" "kh1_third\remastered\voice\event\al\al_001.vset\al0101do.win32.scd"
xcopy "videofficiel.scd" "kh1_third\remastered\voice\event\al\al_001.vset\al0103go.win32.scd"
xcopy "videofficiel.scd" "kh1_third\remastered\voice\event\al\al_001.vset\al0104go.win32.scd"
xcopy "videofficiel.scd" "kh1_third\remastered\voice\event\al\al_001.vset\al0105do.win32.scd"
xcopy "videofficiel.scd" "kh1_third\remastered\voice\event\al\al_002.vset\al0202ja.win32.scd"
xcopy "videofficiel.scd" "kh1_third\remastered\voice\event\al\al_002.vset\al0203ja.win32.scd"
xcopy "videofficiel.scd" "kh1_third\remastered\voice\event\al\al_002.vset\al0204ia.win32.scd"
xcopy "videofficiel.scd" "kh1_third\remastered\voice\event\al\al_002.vset\al0205ja.win32.scd"
xcopy "videofficiel.scd" "kh1_third\remastered\voice\event\al\al_002.vset\al0207ja.win32.scd"
xcopy "videofficiel.scd" "kh1_third\remastered\voice\event\al\al_002.vset\al0208ja.win32.scd"
echo The empty files are created switching to the copying!


REM Fifth action: Copy every files to just put in AntonioDePau's KHPCPatchManager.exe or OpenKH's Mods Manager
xcopy output\xa_ex_2172.mdls\ output\kh1_fifth\remastered\xa_ex_2172.mdls\ /S
xcopy output\xa_ex_3000.mdls\ output\kh1_fifth\remastered\xa_ex_3000.mdls\ /S
xcopy output\xa_ex_4010.mdls\ output\kh1_fifth\remastered\xa_ex_4010.mdls\ /S
xcopy output\xa_ex_4040.mdls\ output\kh1_fifth\remastered\xa_ex_4040.mdls\ /S
xcopy output\xa_ex_4042.mdls\ output\kh1_fifth\remastered\xa_ex_4042.mdls\ /S
xcopy output\xa_ex_4060.mdls\ output\kh1_fifth\remastered\xa_ex_4060.mdls\ /S
xcopy output\xa_he_1010.mdls\ output\kh1_fifth\remastered\xa_he_1010.mdls\ /S
xcopy output\xa_lm_1050.mdls\ output\kh1_fifth\remastered\xa_lm_1050.mdls\ /S
xcopy output\xa_lm_3000.mdls\ output\kh1_fifth\remastered\xa_lm_3000.mdls\ /S
xcopy output\xa_lm_3020.mdls\ output\kh1_fifth\remastered\xa_lm_3020.mdls\ /S
xcopy output\xa_nm_1030.mdls\ output\kh1_fifth\remastered\xa_nm_1030.mdls\ /S
xcopy output\xa_nm_1040.mdls\ output\kh1_fifth\remastered\xa_nm_1040.mdls\ /S
xcopy output\xa_nm_1050.mdls\ output\kh1_fifth\remastered\xa_nm_1050.mdls\ /S
xcopy output\xa_nm_3000.mdls\ output\kh1_fifth\remastered\xa_nm_3000.mdls\ /S
xcopy output\xa_pi_1000.mdls\ output\kh1_fifth\remastered\xa_pi_1000.mdls\ /S
xcopy output\xa_pp_3000.mdls\ output\kh1_fifth\remastered\xa_pp_3000.mdls\ /S
xcopy output\xa_tz_3010.mdls\ output\kh1_fifth\remastered\xa_tz_3010.mdls\ /S
xcopy output\xa_tz_3020.mdls\ output\kh1_fifth\remastered\xa_tz_3020.mdls\ /S
xcopy output\xs_genie.dat\ output\kh1_fifth\remastered\xs_genie.dat\ /S
xcopy output\xs_mushu.dat\ output\kh1_fifth\remastered\xs_mushu.dat\ /S
xcopy output\di_sora.vsb\ output\kh1_first\remastered\voice\di_sora.vsb\ /S
xcopy output\dc_001.vset\ output\kh1_first\remastered\voice\event\dc\dc_001.vset\ /S
xcopy output\dc_002.vset\ output\kh1_first\remastered\voice\event\dc\dc_002.vset\ /S
xcopy output\dc_003.vset\ output\kh1_first\remastered\voice\event\dc\dc_003.vset\ /S
xcopy output\dc_004.vset\ output\kh1_first\remastered\voice\event\dc\dc_004.vset\ /S
xcopy output\dc_005.vset\ output\kh1_first\remastered\voice\event\dc\dc_005.vset\ /S
xcopy output\dc_006.vset\ output\kh1_first\remastered\voice\event\dc\dc_006.vset\ /S
xcopy output\dc_007.vset\ output\kh1_first\remastered\voice\event\dc\dc_007.vset\ /S
xcopy output\di_001.vset\ output\kh1_first\remastered\voice\event\di\di_001.vset\ /S
xcopy output\di_002.vset\ output\kh1_first\remastered\voice\event\di\di_002.vset\ /S
xcopy output\di_003.vset\ output\kh1_first\remastered\voice\event\di\di_003.vset\ /S
xcopy output\di_004.vset\ output\kh1_first\remastered\voice\event\di\di_004.vset\ /S
xcopy output\di_005.vset\ output\kh1_first\remastered\voice\event\di\di_005.vset\ /S
xcopy output\di_006.vset\ output\kh1_first\remastered\voice\event\di\di_006.vset\ /S
xcopy output\di_009.vset\ output\kh1_first\remastered\voice\event\di\di_009.vset\ /S
xcopy output\di_010.vset\ output\kh1_first\remastered\voice\event\di\di_010.vset\ /S
xcopy output\di_011.vset\ output\kh1_first\remastered\voice\event\di\di_011.vset\ /S
xcopy output\di_012.vset\ output\kh1_first\remastered\voice\event\di\di_012.vset\ /S
xcopy output\di_013.vset\ output\kh1_first\remastered\voice\event\di\di_013.vset\ /S
xcopy output\di_014.vset\ output\kh1_first\remastered\voice\event\di\di_014.vset\ /S
xcopy output\di_015.vset\ output\kh1_first\remastered\voice\event\di\di_015.vset\ /S
xcopy output\di_016.vset\ output\kh1_first\remastered\voice\event\di\di_016.vset\ /S
xcopy output\di_017.vset\ output\kh1_first\remastered\voice\event\di\di_017.vset\ /S
xcopy output\di_018.vset\ output\kh1_first\remastered\voice\event\di\di_018.vset\ /S
xcopy output\di_019.vset\ output\kh1_first\remastered\voice\event\di\di_019.vset\ /S
xcopy output\di_020.vset\ output\kh1_first\remastered\voice\event\di\di_020.vset\ /S
xcopy output\di_021.vset\ output\kh1_first\remastered\voice\event\di\di_021.vset\ /S
xcopy output\di_022.vset\ output\kh1_first\remastered\voice\event\di\di_022.vset\ /S
xcopy output\tw_001.vset\ output\kh1_first\remastered\voice\event\tw\tw_001.vset\ /S
xcopy output\tw_002.vset\ output\kh1_first\remastered\voice\event\tw\tw_002.vset\ /S
xcopy output\tw_sora.vsb\ output\kh1_first\remastered\voice\tw_sora.vsb\ /S
xcopy output\xa_di_1010.mdls\ output\kh1_first\remastered\xa_di_1010.mdls\ /S
xcopy output\xa_di_1020.mdls\ output\kh1_first\remastered\xa_di_1020.mdls\ /S
xcopy output\xa_di_1030.mdls\ output\kh1_first\remastered\xa_di_1030.mdls\ /S
xcopy output\xa_ex_1010.mdls\ output\kh1_first\remastered\xa_ex_1010.mdls\ /S
xcopy output\ew_001.vset\ output\kh1_fourth\remastered\voice\event\ew\ew_001.vset\ /S
xcopy output\ew_002.vset\ output\kh1_fourth\remastered\voice\event\ew\ew_002.vset\ /S
xcopy output\ew_004.vset\ output\kh1_fourth\remastered\voice\event\ew\ew_004.vset\ /S
xcopy output\ew_005.vset\ output\kh1_fourth\remastered\voice\event\ew\ew_005.vset\ /S
xcopy output\ew_006.vset\ output\kh1_fourth\remastered\voice\event\ew\ew_006.vset\ /S
xcopy output\ew_007.vset\ output\kh1_fourth\remastered\voice\event\ew\ew_007.vset\ /S
xcopy output\ew_008.vset\ output\kh1_fourth\remastered\voice\event\ew\ew_008.vset\ /S
xcopy output\ew_009.vset\ output\kh1_fourth\remastered\voice\event\ew\ew_009.vset\ /S
xcopy output\ew_010.vset\ output\kh1_fourth\remastered\voice\event\ew\ew_010.vset\ /S
xcopy output\ew_011.vset\ output\kh1_fourth\remastered\voice\event\ew\ew_011.vset\ /S
xcopy output\ew_012.vset\ output\kh1_fourth\remastered\voice\event\ew\ew_012.vset\ /S
xcopy output\ew_013.vset\ output\kh1_fourth\remastered\voice\event\ew\ew_013.vset\ /S
xcopy output\ew_014.vset\ output\kh1_fourth\remastered\voice\event\ew\ew_014.vset\ /S
xcopy output\ew_015.vset\ output\kh1_fourth\remastered\voice\event\ew\ew_015.vset\ /S
xcopy output\he_001.vset\ output\kh1_fourth\remastered\voice\event\he\he_001.vset\ /S
xcopy output\he_002.vset\ output\kh1_fourth\remastered\voice\event\he\he_002.vset\ /S
xcopy output\he_003.vset\ output\kh1_fourth\remastered\voice\event\he\he_003.vset\ /S
xcopy output\he_004.vset\ output\kh1_fourth\remastered\voice\event\he\he_004.vset\ /S
xcopy output\he_005.vset\ output\kh1_fourth\remastered\voice\event\he\he_005.vset\ /S
xcopy output\he_006.vset\ output\kh1_fourth\remastered\voice\event\he\he_006.vset\ /S
xcopy output\he_007.vset\ output\kh1_fourth\remastered\voice\event\he\he_007.vset\ /S
xcopy output\he_015.vset\ output\kh1_fourth\remastered\voice\event\he\he_015.vset\ /S
xcopy output\he_016.vset\ output\kh1_fourth\remastered\voice\event\he\he_016.vset\ /S
xcopy output\he_018.vset\ output\kh1_fourth\remastered\voice\event\he\he_018.vset\ /S
xcopy output\he_020.vset\ output\kh1_fourth\remastered\voice\event\he\he_020.vset\ /S
xcopy output\he_022.vset\ output\kh1_fourth\remastered\voice\event\he\he_022.vset\ /S
xcopy output\he_023.vset\ output\kh1_fourth\remastered\voice\event\he\he_023.vset\ /S
xcopy output\he_024.vset\ output\kh1_fourth\remastered\voice\event\he\he_024.vset\ /S
xcopy output\he_030.vset\ output\kh1_fourth\remastered\voice\event\he\he_030.vset\ /S
xcopy output\he_035.vset\ output\kh1_fourth\remastered\voice\event\he\he_035.vset\ /S
xcopy output\he_036.vset\ output\kh1_fourth\remastered\voice\event\he\he_036.vset\ /S
xcopy output\he_040.vset\ output\kh1_fourth\remastered\voice\event\he\he_040.vset\ /S
xcopy output\he_041.vset\ output\kh1_fourth\remastered\voice\event\he\he_041.vset\ /S
xcopy output\he_042.vset\ output\kh1_fourth\remastered\voice\event\he\he_042.vset\ /S
xcopy output\he_043.vset\ output\kh1_fourth\remastered\voice\event\he\he_043.vset\ /S
xcopy output\he_044.vset\ output\kh1_fourth\remastered\voice\event\he\he_044.vset\ /S
xcopy output\he_050.vset\ output\kh1_fourth\remastered\voice\event\he\he_050.vset\ /S
xcopy output\lm_001.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_001.vset\ /S
xcopy output\lm_002.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_002.vset\ /S
xcopy output\lm_003.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_003.vset\ /S
xcopy output\lm_004.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_004.vset\ /S
xcopy output\lm_005.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_005.vset\ /S
xcopy output\lm_006.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_006.vset\ /S
xcopy output\lm_007.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_007.vset\ /S
xcopy output\lm_008.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_008.vset\ /S
xcopy output\lm_009.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_009.vset\ /S
xcopy output\lm_010.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_010.vset\ /S
xcopy output\lm_011.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_011.vset\ /S
xcopy output\lm_012.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_012.vset\ /S
xcopy output\lm_013.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_013.vset\ /S
xcopy output\lm_014.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_014.vset\ /S
xcopy output\lm_015.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_015.vset\ /S
xcopy output\lm_016.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_016.vset\ /S
xcopy output\lm_017.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_017.vset\ /S
xcopy output\lm_018.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_018.vset\ /S
xcopy output\lm_019.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_019.vset\ /S
xcopy output\lm_020.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_020.vset\ /S
xcopy output\lm_021.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_021.vset\ /S
xcopy output\lm_022.vset\ output\kh1_fourth\remastered\voice\event\lm\lm_022.vset\ /S
xcopy output\nm_005.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_005.vset\ /S
xcopy output\nm_007.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_007.vset\ /S
xcopy output\nm_011.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_011.vset\ /S
xcopy output\nm_014.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_014.vset\ /S
xcopy output\nm_018.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_018.vset\ /S
xcopy output\nm_019.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_019.vset\ /S
xcopy output\nm_022.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_022.vset\ /S
xcopy output\nm_023.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_023.vset\ /S
xcopy output\nm_024.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_024.vset\ /S
xcopy output\nm_025.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_025.vset\ /S
xcopy output\nm_027.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_027.vset\ /S
xcopy output\nm_061.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_061.vset\ /S
xcopy output\nm_062.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_062.vset\ /S
xcopy output\nm_063.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_063.vset\ /S
xcopy output\nm_100.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_100.vset\ /S
xcopy output\nm_101.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_101.vset\ /S
xcopy output\nm_102.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_102.vset\ /S
xcopy output\nm_103.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_103.vset\ /S
xcopy output\nm_104.vset\ output\kh1_fourth\remastered\voice\event\nm\nm_104.vset\ /S
xcopy output\pc_011.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_011.vset\ /S
xcopy output\pc_012.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_012.vset\ /S
xcopy output\pc_071.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_071.vset\ /S
xcopy output\pc_072.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_072.vset\ /S
xcopy output\pc_073.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_073.vset\ /S
xcopy output\pc_074.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_074.vset\ /S
xcopy output\pc_075.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_075.vset\ /S
xcopy output\pc_076.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_076.vset\ /S
xcopy output\pc_077.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_077.vset\ /S
xcopy output\pc_091.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_091.vset\ /S
xcopy output\pc_101.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_101.vset\ /S
xcopy output\pc_102.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_102.vset\ /S
xcopy output\pc_103.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_103.vset\ /S
xcopy output\pc_104.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_104.vset\ /S
xcopy output\pc_111.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_111.vset\ /S
xcopy output\pc_131.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_131.vset\ /S
xcopy output\pc_132.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_132.vset\ /S
xcopy output\pc_141.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_141.vset\ /S
xcopy output\pc_142.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_142.vset\ /S
xcopy output\pc_151.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_151.vset\ /S
xcopy output\pc_171.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_171.vset\ /S
xcopy output\pc_172.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_172.vset\ /S
xcopy output\pc_181.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_181.vset\ /S
xcopy output\pc_191.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_191.vset\ /S
xcopy output\pc_192.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_192.vset\ /S
xcopy output\pc_193.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_193.vset\ /S
xcopy output\pc_201.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_201.vset\ /S
xcopy output\pc_202.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_202.vset\ /S
xcopy output\pc_203.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_203.vset\ /S
xcopy output\pc_204.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_204.vset\ /S
xcopy output\pc_211.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_211.vset\ /S
xcopy output\pc_241.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_241.vset\ /S
xcopy output\pc_242.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_242.vset\ /S
xcopy output\pc_311.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_311.vset\ /S
xcopy output\pc_331.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_331.vset\ /S
xcopy output\pc_341.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_341.vset\ /S
xcopy output\pc_371.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_371.vset\ /S
xcopy output\pc_381.vset\ output\kh1_fourth\remastered\voice\event\pc\pc_381.vset\ /S
xcopy output\pi_001.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_001.vset\ /S
xcopy output\pi_002.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_002.vset\ /S
xcopy output\pi_003.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_003.vset\ /S
xcopy output\pi_004.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_004.vset\ /S
xcopy output\pi_005.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_005.vset\ /S
xcopy output\pi_006.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_006.vset\ /S
xcopy output\pi_007.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_007.vset\ /S
xcopy output\pi_008.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_008.vset\ /S
xcopy output\pi_009.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_009.vset\ /S
xcopy output\pi_010.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_010.vset\ /S
xcopy output\pi_011.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_011.vset\ /S
xcopy output\pi_012.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_012.vset\ /S
xcopy output\pi_013.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_013.vset\ /S
xcopy output\pi_014.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_014.vset\ /S
xcopy output\pi_015.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_015.vset\ /S
xcopy output\pi_016.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_016.vset\ /S
xcopy output\pi_017.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_017.vset\ /S
xcopy output\pi_018.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_018.vset\ /S
xcopy output\pi_019.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_019.vset\ /S
xcopy output\pi_020.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_020.vset\ /S
xcopy output\pi_021.vset\ output\kh1_fourth\remastered\voice\event\pi\pi_021.vset\ /S
xcopy output\po_001.vset\ output\kh1_fourth\remastered\voice\event\po\po_001.vset\ /S
xcopy output\po_002.vset\ output\kh1_fourth\remastered\voice\event\po\po_002.vset\ /S
xcopy output\po_003.vset\ output\kh1_fourth\remastered\voice\event\po\po_003.vset\ /S
xcopy output\po_004.vset\ output\kh1_fourth\remastered\voice\event\po\po_004.vset\ /S
xcopy output\po_005.vset\ output\kh1_fourth\remastered\voice\event\po\po_005.vset\ /S
xcopy output\po_006.vset\ output\kh1_fourth\remastered\voice\event\po\po_006.vset\ /S
xcopy output\po_007.vset\ output\kh1_fourth\remastered\voice\event\po\po_007.vset\ /S
xcopy output\po_008.vset\ output\kh1_fourth\remastered\voice\event\po\po_008.vset\ /S
xcopy output\po_009.vset\ output\kh1_fourth\remastered\voice\event\po\po_009.vset\ /S
xcopy output\po_010.vset\ output\kh1_fourth\remastered\voice\event\po\po_010.vset\ /S
xcopy output\po_011.vset\ output\kh1_fourth\remastered\voice\event\po\po_011.vset\ /S
xcopy output\po_012.vset\ output\kh1_fourth\remastered\voice\event\po\po_012.vset\ /S
xcopy output\po_013.vset\ output\kh1_fourth\remastered\voice\event\po\po_013.vset\ /S
xcopy output\po_014.vset\ output\kh1_fourth\remastered\voice\event\po\po_014.vset\ /S
xcopy output\po_015.vset\ output\kh1_fourth\remastered\voice\event\po\po_015.vset\ /S
xcopy output\pp_000.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_000.vset\ /S
xcopy output\pp_001.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_001.vset\ /S
xcopy output\pp_099.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_099.vset\ /S
xcopy output\pp_103.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_103.vset\ /S
xcopy output\pp_104.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_104.vset\ /S
xcopy output\pp_105.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_105.vset\ /S
xcopy output\pp_106.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_106.vset\ /S
xcopy output\pp_107.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_107.vset\ /S
xcopy output\pp_108.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_108.vset\ /S
xcopy output\pp_109.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_109.vset\ /S
xcopy output\pp_110.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_110.vset\ /S
xcopy output\pp_111.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_111.vset\ /S
xcopy output\pp_112.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_112.vset\ /S
xcopy output\pp_113.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_113.vset\ /S
xcopy output\pp_114.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_114.vset\ /S
xcopy output\pp_115.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_115.vset\ /S
xcopy output\pp_116.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_116.vset\ /S
xcopy output\pp_117.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_117.vset\ /S
xcopy output\pp_118.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_118.vset\ /S
xcopy output\pp_119.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_119.vset\ /S
xcopy output\pp_120.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_120.vset\ /S
xcopy output\pp_121.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_121.vset\ /S
xcopy output\pp_122.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_122.vset\ /S
xcopy output\pp_123.vset\ output\kh1_fourth\remastered\voice\event\pp\pp_123.vset\ /S
xcopy output\tw_006.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_006.vset\ /S
xcopy output\tw_007.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_007.vset\ /S
xcopy output\tw_008.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_008.vset\ /S
xcopy output\tw_009.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_009.vset\ /S
xcopy output\tw_010.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_010.vset\ /S
xcopy output\tw_011.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_011.vset\ /S
xcopy output\tw_012.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_012.vset\ /S
xcopy output\tw_013.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_013.vset\ /S
xcopy output\tw_014.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_014.vset\ /S
xcopy output\tw_015.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_015.vset\ /S
xcopy output\tw_016.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_016.vset\ /S
xcopy output\tw_017.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_017.vset\ /S
xcopy output\tw_018.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_018.vset\ /S
xcopy output\tw_019.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_019.vset\ /S
xcopy output\tw_020.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_020.vset\ /S
xcopy output\tw_030.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_030.vset\ /S
xcopy output\tw_031.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_031.vset\ /S
xcopy output\tw_032.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_032.vset\ /S
xcopy output\tw_033.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_033.vset\ /S
xcopy output\tw_034.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_034.vset\ /S
xcopy output\tw_035.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_035.vset\ /S
xcopy output\tw_040.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_040.vset\ /S
xcopy output\tw_050.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_050.vset\ /S
xcopy output\tw_051.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_051.vset\ /S
xcopy output\tw_052.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_052.vset\ /S
xcopy output\tw_053.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_053.vset\ /S
xcopy output\tw_054.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_054.vset\ /S
xcopy output\tw_055.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_055.vset\ /S
xcopy output\tw_060.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_060.vset\ /S
xcopy output\tw_061.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_061.vset\ /S
xcopy output\tw_071.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_071.vset\ /S
xcopy output\tw_090.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_090.vset\ /S
xcopy output\tw_091.vset\ output\kh1_fourth\remastered\voice\event\tw\tw_091.vset\ /S
xcopy output\tz_001.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_001.vset\ /S
xcopy output\tz_002.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_002.vset\ /S
xcopy output\tz_003.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_003.vset\ /S
xcopy output\tz_004.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_004.vset\ /S
xcopy output\tz_005.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_005.vset\ /S
xcopy output\tz_006.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_006.vset\ /S
xcopy output\tz_007.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_007.vset\ /S
xcopy output\tz_008.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_008.vset\ /S
xcopy output\tz_009.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_009.vset\ /S
xcopy output\tz_010.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_010.vset\ /S
xcopy output\tz_011.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_011.vset\ /S
xcopy output\tz_012.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_012.vset\ /S
xcopy output\tz_013.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_013.vset\ /S
xcopy output\tz_014.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_014.vset\ /S
xcopy output\tz_015.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_015.vset\ /S
xcopy output\tz_016.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_016.vset\ /S
xcopy output\tz_017.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_017.vset\ /S
xcopy output\tz_018.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_018.vset\ /S
xcopy output\tz_019.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_019.vset\ /S
xcopy output\tz_020.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_020.vset\ /S
xcopy output\tz_021.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_021.vset\ /S
xcopy output\tz_022.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_022.vset\ /S
xcopy output\tz_023.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_023.vset\ /S
xcopy output\tz_024.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_024.vset\ /S
xcopy output\tz_025.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_025.vset\ /S
xcopy output\tz_026.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_026.vset\ /S
xcopy output\tz_090.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_090.vset\ /S
xcopy output\tz_091.vset\ output\kh1_fourth\remastered\voice\event\tz\tz_091.vset\ /S
xcopy output\ew_donald.vsb\ output\kh1_fourth\remastered\voice\ew_donald.vsb\ /S
xcopy output\ew_goofy.vsb\ output\kh1_fourth\remastered\voice\ew_goofy.vsb\ /S
xcopy output\ew_sora.vsb\ output\kh1_fourth\remastered\voice\ew_sora.vsb\ /S
xcopy output\he_donald.vsb\ output\kh1_fourth\remastered\voice\he_donald.vsb\ /S
xcopy output\he_goofy.vsb\ output\kh1_fourth\remastered\voice\he_goofy.vsb\ /S
xcopy output\he_sora.vsb\ output\kh1_fourth\remastered\voice\he_sora.vsb\ /S
xcopy output\jack.vsb\ output\kh1_fourth\remastered\voice\jack.vsb\ /S
xcopy output\lm_donald.vsb\ output\kh1_fourth\remastered\voice\lm_donald.vsb\ /S
xcopy output\lm_goofy.vsb\ output\kh1_fourth\remastered\voice\lm_goofy.vsb\ /S
xcopy output\lm_sora.vsb\ output\kh1_fourth\remastered\voice\lm_sora.vsb\ /S
xcopy output\nm_donald.vsb\ output\kh1_fourth\remastered\voice\nm_donald.vsb\ /S
xcopy output\nm_goofy.vsb\ output\kh1_fourth\remastered\voice\nm_goofy.vsb\ /S
xcopy output\nm_sora.vsb\ output\kh1_fourth\remastered\voice\nm_sora.vsb\ /S
xcopy output\pc_donald.vsb\ output\kh1_fourth\remastered\voice\pc_donald.vsb\ /S
xcopy output\pc_goofy.vsb\ output\kh1_fourth\remastered\voice\pc_goofy.vsb\ /S
xcopy output\pc_sora.vsb\ output\kh1_fourth\remastered\voice\pc_sora.vsb\ /S
xcopy output\peterpan.vsb\ output\kh1_fourth\remastered\voice\peterpan.vsb\ /S
xcopy output\pi_donald.vsb\ output\kh1_fourth\remastered\voice\pi_donald.vsb\ /S
xcopy output\pi_goofy.vsb\ output\kh1_fourth\remastered\voice\pi_goofy.vsb\ /S
xcopy output\pi_sora.vsb\ output\kh1_fourth\remastered\voice\pi_sora.vsb\ /S
xcopy output\po_sora.vsb\ output\kh1_fourth\remastered\voice\po_sora.vsb\ /S
xcopy output\pp_donald.vsb\ output\kh1_fourth\remastered\voice\pp_donald.vsb\ /S
xcopy output\pp_goofy.vsb\ output\kh1_fourth\remastered\voice\pp_goofy.vsb\ /S
xcopy output\pp_sora.vsb\ output\kh1_fourth\remastered\voice\pp_sora.vsb\ /S
xcopy output\tarzan.vsb\ output\kh1_fourth\remastered\voice\tarzan.vsb\ /S
xcopy output\tw_donald.vsb\ output\kh1_fourth\remastered\voice\tw_donald.vsb\ /S
xcopy output\tw_goofy.vsb\ output\kh1_fourth\remastered\voice\tw_goofy.vsb\ /S
xcopy output\tz_donald.vsb\ output\kh1_fourth\remastered\voice\tz_donald.vsb\ /S
xcopy output\tz_goofy.vsb\ output\kh1_fourth\remastered\voice\tz_goofy.vsb\ /S
xcopy output\tz_sora.vsb\ output\kh1_fourth\remastered\voice\tz_sora.vsb\ /S
xcopy output\xa_al_1020.mdls\ output\kh1_fourth\remastered\xa_al_1020.mdls\ /S
xcopy output\xa_al_3010.mdls\ output\kh1_fourth\remastered\xa_al_3010.mdls\ /S
xcopy output\xa_al_3020.mdls\ output\kh1_fourth\remastered\xa_al_3020.mdls\ /S
xcopy output\xa_aw_1010.mdls\ output\kh1_fourth\remastered\xa_aw_1010.mdls\ /S
xcopy output\xa_ew_3020.mdls\ output\kh1_fourth\remastered\xa_ew_3020.mdls\ /S
xcopy output\xa_ex_1030.mdls\ output\kh1_fourth\remastered\xa_ex_1030.mdls\ /S
xcopy output\xa_ex_1040.mdls\ output\kh1_fourth\remastered\xa_ex_1040.mdls\ /S
xcopy output\xa_ex_1090.mdls\ output\kh1_fourth\remastered\xa_ex_1090.mdls\ /S
xcopy output\xa_ex_1150.mdls\ output\kh1_fourth\remastered\xa_ex_1150.mdls\ /S
xcopy output\xa_ex_1160.mdls\ output\kh1_fourth\remastered\xa_ex_1160.mdls\ /S
xcopy output\xa_ex_1560.mdls\ output\kh1_fourth\remastered\xa_ex_1560.mdls\ /S
xcopy output\xa_ex_1580.mdls\ output\kh1_fourth\remastered\xa_ex_1580.mdls\ /S
xcopy output\xa_ex_1630.mdls\ output\kh1_fourth\remastered\xa_ex_1630.mdls\ /S
xcopy output\aladdin.vsb\ output\kh1_third\remastered\voice\aladdin.vsb\ /S
xcopy output\al_donald.vsb\ output\kh1_third\remastered\voice\al_donald.vsb\ /S
xcopy output\al_goofy.vsb\ output\kh1_third\remastered\voice\al_goofy.vsb\ /S
xcopy output\al_sora.vsb\ output\kh1_third\remastered\voice\al_sora.vsb\ /S
xcopy output\ariel.vsb\ output\kh1_third\remastered\voice\ariel.vsb\ /S
xcopy output\aw_donald.vsb\ output\kh1_third\remastered\voice\aw_donald.vsb\ /S
xcopy output\aw_goofy.vsb\ output\kh1_third\remastered\voice\aw_goofy.vsb\ /S
xcopy output\aw_sora.vsb\ output\kh1_third\remastered\voice\aw_sora.vsb\ /S
xcopy output\beast.vsb\ output\kh1_third\remastered\voice\beast.vsb\ /S
xcopy output\al_010.vset\ output\kh1_third\remastered\voice\event\al\al_010.vset\ /S
xcopy output\al_011.vset\ output\kh1_third\remastered\voice\event\al\al_011.vset\ /S
xcopy output\al_012.vset\ output\kh1_third\remastered\voice\event\al\al_012.vset\ /S
xcopy output\al_013.vset\ output\kh1_third\remastered\voice\event\al\al_013.vset\ /S
xcopy output\al_014.vset\ output\kh1_third\remastered\voice\event\al\al_014.vset\ /S
xcopy output\al_015.vset\ output\kh1_third\remastered\voice\event\al\al_015.vset\ /S
xcopy output\al_016.vset\ output\kh1_third\remastered\voice\event\al\al_016.vset\ /S
xcopy output\al_017.vset\ output\kh1_third\remastered\voice\event\al\al_017.vset\ /S
xcopy output\al_090.vset\ output\kh1_third\remastered\voice\event\al\al_090.vset\ /S
xcopy output\al_091.vset\ output\kh1_third\remastered\voice\event\al\al_091.vset\ /S
xcopy output\al_100.vset\ output\kh1_third\remastered\voice\event\al\al_100.vset\ /S
xcopy output\al_101.vset\ output\kh1_third\remastered\voice\event\al\al_101.vset\ /S
xcopy output\al_102.vset\ output\kh1_third\remastered\voice\event\al\al_102.vset\ /S
xcopy output\al_103.vset\ output\kh1_third\remastered\voice\event\al\al_103.vset\ /S
xcopy output\al_104.vset\ output\kh1_third\remastered\voice\event\al\al_104.vset\ /S
xcopy output\al_105.vset\ output\kh1_third\remastered\voice\event\al\al_105.vset\ /S
xcopy output\al_106.vset\ output\kh1_third\remastered\voice\event\al\al_106.vset\ /S
xcopy output\al_201.vset\ output\kh1_third\remastered\voice\event\al\al_201.vset\ /S
xcopy output\al_202.vset\ output\kh1_third\remastered\voice\event\al\al_202.vset\ /S
xcopy output\al_203.vset\ output\kh1_third\remastered\voice\event\al\al_203.vset\ /S
xcopy output\al_204.vset\ output\kh1_third\remastered\voice\event\al\al_204.vset\ /S
xcopy output\al_205.vset\ output\kh1_third\remastered\voice\event\al\al_205.vset\ /S
xcopy output\al_206.vset\ output\kh1_third\remastered\voice\event\al\al_206.vset\ /S
xcopy output\al_207.vset\ output\kh1_third\remastered\voice\event\al\al_207.vset\ /S
xcopy output\al_208.vset\ output\kh1_third\remastered\voice\event\al\al_208.vset\ /S
xcopy output\al_209.vset\ output\kh1_third\remastered\voice\event\al\al_209.vset\ /S
xcopy output\aw_001.vset\ output\kh1_third\remastered\voice\event\aw\aw_001.vset\ /S
xcopy output\aw_003.vset\ output\kh1_third\remastered\voice\event\aw\aw_003.vset\ /S
xcopy output\aw_005.vset\ output\kh1_third\remastered\voice\event\aw\aw_005.vset\ /S
xcopy output\aw_006.vset\ output\kh1_third\remastered\voice\event\aw\aw_006.vset\ /S
xcopy output\aw_007.vset\ output\kh1_third\remastered\voice\event\aw\aw_007.vset\ /S
xcopy output\aw_008.vset\ output\kh1_third\remastered\voice\event\aw\aw_008.vset\ /S
xcopy output\aw_009.vset\ output\kh1_third\remastered\voice\event\aw\aw_009.vset\ /S
xcopy output\aw_010.vset\ output\kh1_third\remastered\voice\event\aw\aw_010.vset\ /S
xcopy output\aw_011.vset\ output\kh1_third\remastered\voice\event\aw\aw_011.vset\ /S
xcopy output\di_007.vset\ output\kh1_third\remastered\voice\event\di\di_007.vset\ /S
echo Every files is now copied to the right directory switching to the patch maker!


REM Sixth action: Copy the folders for a mod or create a patch
set /p patcher=Enter 1 if you want to make an OpenKH Mod, enter 2 if you want a KHPCPatchManager Patch, enter 3 if you just want a folder like a KHPCPatchManager Patch:
if not exist "MyPatch" (
	mkdir "MyPatch"
)
move output\kh1_fifth MyPatch
move output\kh1_first MyPatch
move output\kh1_fourth MyPatch
move output\kh1_second MyPatch
move output\kh1_third MyPatch
rmdir /Q /S output

if %patcher%==1 (
	if not exist "MyGithubUsername" (
		mkdir "MyGithubUsername"
	)
	move MyPatch MyGithubUsername
	
	echo Creation of the mod.yml...
	set /p title=What's the title of the mod?
	set /p originalAuthor=Who is/are the original Author of the mod?
	set /p description=What's the description of the mod?
	set /p subtitles=Do you have modified subtitles files? Write yes or anything else for no
	if %subtitles%==yes (
		echo Please put them in the right folder inside MyGithubUsername\MyPatch
		set /p language=What's the language of the subtitles? Write FR for French, GR for German, IT for Italian, SP for Spanish, US for English
		echo The files expected are:
		echo btltbl.bin/%language%_ItemHelp.bin
		echo uitex.bin/%language%_uitex_bin20c0.png
		echo If you have any other files you have to modify the mod.yml file.
	)
	
	echo title: %title%>>MyGithubUsername\MyPatch\mod.yml
	echo originalAuthor: %originalAuthor%>>MyGithubUsername\MyPatch\mod.yml
	echo description: %description%>>MyGithubUsername\MyPatch\mod.yml
	echo dependencies: >>MyGithubUsername\MyPatch\mod.yml
	echo assets:>>MyGithubUsername\MyPatch\mod.yml
	if %subtitles%==yes (
		echo - name: remastered/btltbl.bin/%language%_ItemHelp.bin>>MyGithubUsername\MyPatch\mod.yml
		echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
		echo   source:>>MyGithubUsername\MyPatch\mod.yml
		echo   - name: kh1_first/remastered/btltbl.bin/%language%_ItemHelp.bin>>MyGithubUsername\MyPatch\mod.yml
		echo - name: remastered/command2/uitex.bin/%language%_uitex_bin20c0.png>>MyGithubUsername\MyPatch\mod.yml
		echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
		echo   source:>>MyGithubUsername\MyPatch\mod.yml
		echo   - name: kh1_first/remastered/command2/uitex.bin/%language%_uitex_bin20c0.png>>MyGithubUsername\MyPatch\mod.yml
	)
	echo - name: remastered/xa_ex_2172.mdls/js00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_2172.mdls/js00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_2172.mdls/js00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_2172.mdls/js00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex14.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex14.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex15.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex15.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex16.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex16.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex17.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex17.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex18.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex18.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex19.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex19.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex20.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex20.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex21.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex21.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex22.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex22.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex23.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex23.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex24.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex24.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex25.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex25.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex26.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex26.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex27.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex27.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex28.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex28.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex29.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex29.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex30.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex30.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex31.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex31.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex32.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex32.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex33.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex33.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex34.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex34.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_3000.mdls/sp00ex35.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_3000.mdls/sp00ex35.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4010.mdls/hc00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4010.mdls/hc00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4010.mdls/hc00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4010.mdls/hc00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4010.mdls/hc00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4010.mdls/hc00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4010.mdls/hc00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4010.mdls/hc00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4010.mdls/hc00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4010.mdls/hc00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4010.mdls/hc00at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4010.mdls/hc00at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4010.mdls/hc00at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4010.mdls/hc00at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4010.mdls/hc00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4010.mdls/hc00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4010.mdls/hc00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4010.mdls/hc00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4010.mdls/hc00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4010.mdls/hc00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4010.mdls/hc00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4010.mdls/hc00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4040.mdls/ge00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4040.mdls/ge00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4040.mdls/ge00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4040.mdls/ge00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4040.mdls/ge00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4040.mdls/ge00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4040.mdls/ge00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4040.mdls/ge00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4040.mdls/ge00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4040.mdls/ge00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4040.mdls/ge00at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4040.mdls/ge00at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4040.mdls/ge00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4040.mdls/ge00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4040.mdls/ge00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4040.mdls/ge00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4040.mdls/ge00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4040.mdls/ge00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4040.mdls/ge00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4040.mdls/ge00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4040.mdls/ge00ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4040.mdls/ge00ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4040.mdls/ge00ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4040.mdls/ge00ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4040.mdls/ge00ex07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4040.mdls/ge00ex07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4042.mdls/ge01at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4042.mdls/ge01at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4042.mdls/ge01ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4042.mdls/ge01ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4042.mdls/ge01ma01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4042.mdls/ge01ma01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4042.mdls/ge01ma02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4042.mdls/ge01ma02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4042.mdls/ge01ma03-2.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4042.mdls/ge01ma03-2.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4042.mdls/ge01ma04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4042.mdls/ge01ma04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4042.mdls/ge01ma05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4042.mdls/ge01ma05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4042.mdls/ge01ma06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4042.mdls/ge01ma06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4042.mdls/ge01ma09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4042.mdls/ge01ma09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4042.mdls/ge01ma10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4042.mdls/ge01ma10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4042.mdls/ge01ma11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4042.mdls/ge01ma11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4042.mdls/ge01ma12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4042.mdls/ge01ma12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4042.mdls/ge01ma13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4042.mdls/ge01ma13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4042.mdls/ge01mx14.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4042.mdls/ge01mx14.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4060.mdls/mu00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4060.mdls/mu00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_4060.mdls/mu00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_ex_4060.mdls/mu00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_he_1010.mdls/ha00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_he_1010.mdls/ha00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_he_1010.mdls/ha00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_he_1010.mdls/ha00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_he_1010.mdls/ha00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_he_1010.mdls/ha00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_he_1010.mdls/ha00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_he_1010.mdls/ha00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_he_1010.mdls/ha00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_he_1010.mdls/ha00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_he_1010.mdls/ha00at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_he_1010.mdls/ha00at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_he_1010.mdls/ha00at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_he_1010.mdls/ha00at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_he_1010.mdls/ha00at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_he_1010.mdls/ha00at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_he_1010.mdls/ha00at08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_he_1010.mdls/ha00at08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_he_1010.mdls/ha00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_he_1010.mdls/ha00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_he_1010.mdls/ha00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_he_1010.mdls/ha00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_he_1010.mdls/ha00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_he_1010.mdls/ha00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_he_1010.mdls/ha00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_he_1010.mdls/ha00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_he_1010.mdls/ha00da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_he_1010.mdls/ha00da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_he_1010.mdls/ha00da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_he_1010.mdls/ha00da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_he_1010.mdls/ha00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_he_1010.mdls/ha00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_he_1010.mdls/ha00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_he_1010.mdls/ha00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_1050.mdls/ur02at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_1050.mdls/ur02at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_1050.mdls/ur02at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_1050.mdls/ur02at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_1050.mdls/ur02at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_1050.mdls/ur02at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_1050.mdls/ur02at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_1050.mdls/ur02at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_1050.mdls/ur02da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_1050.mdls/ur02da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_1050.mdls/ur02da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_1050.mdls/ur02da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_1050.mdls/ur02da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_1050.mdls/ur02da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_1050.mdls/ur02da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_1050.mdls/ur02da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_1050.mdls/ur02da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_1050.mdls/ur02da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_1050.mdls/ur02da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_1050.mdls/ur02da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_1050.mdls/ur02ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_1050.mdls/ur02ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01at09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01at09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01at11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01at11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01at13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01at13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01at14.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01at14.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01at15.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01at15.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01at18.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01at18.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01at19.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01at19.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3000.mdls/ur01ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3000.mdls/ur01ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3020.mdls/fs00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3020.mdls/fs00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3020.mdls/fs00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3020.mdls/fs00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3020.mdls/fs00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3020.mdls/fs00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3020.mdls/fs00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3020.mdls/fs00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3020.mdls/fs00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3020.mdls/fs00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3020.mdls/fs00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3020.mdls/fs00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3020.mdls/fs00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3020.mdls/fs00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3020.mdls/fs00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3020.mdls/fs00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3020.mdls/jt00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3020.mdls/jt00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3020.mdls/jt00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3020.mdls/jt00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3020.mdls/jt00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3020.mdls/jt00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3020.mdls/jt00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3020.mdls/jt00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3020.mdls/jt00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3020.mdls/jt00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3020.mdls/jt00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3020.mdls/jt00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3020.mdls/jt00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3020.mdls/jt00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_lm_3020.mdls/jt00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_lm_3020.mdls/jt00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1030.mdls/ro00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1030.mdls/ro00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1030.mdls/ro00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1030.mdls/ro00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1030.mdls/ro00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1030.mdls/ro00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1030.mdls/ro00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1030.mdls/ro00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1030.mdls/ro00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1030.mdls/ro00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1030.mdls/ro00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1030.mdls/ro00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1030.mdls/ro00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1030.mdls/ro00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1040.mdls/so00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1040.mdls/so00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1040.mdls/so00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1040.mdls/so00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1040.mdls/so00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1040.mdls/so00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1040.mdls/so00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1040.mdls/so00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1040.mdls/so00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1040.mdls/so00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1040.mdls/so00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1040.mdls/so00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1040.mdls/so00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1040.mdls/so00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1050.mdls/ba00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1050.mdls/ba00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1050.mdls/ba00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1050.mdls/ba00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1050.mdls/ba00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1050.mdls/ba00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1050.mdls/ba00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1050.mdls/ba00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1050.mdls/ba00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1050.mdls/ba00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1050.mdls/ba00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1050.mdls/ba00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_1050.mdls/ba00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_1050.mdls/ba00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00ex07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00ex07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00ex08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00ex08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00ex09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00ex09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00ex10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00ex10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00ex11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00ex11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00ex12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00ex12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_nm_3000.mdls/bo00ex13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_nm_3000.mdls/bo00ex13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pi_1000.mdls/pc00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pi_1000.mdls/pc00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pi_1000.mdls/pc00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pi_1000.mdls/pc00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pi_1000.mdls/pc00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pi_1000.mdls/pc00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00da06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00da06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00da07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00da07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_pp_3000.mdls/ho00ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_pp_3000.mdls/ho00ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00at03_1.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00at03_1.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00at08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00at08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00at11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00at11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00at13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00at13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00da06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00da06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3010.mdls/cl00ex07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3010.mdls/cl00ex07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3020.mdls/cl00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3020.mdls/cl00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3020.mdls/cl00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3020.mdls/cl00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3020.mdls/cl00at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3020.mdls/cl00at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3020.mdls/cl00at10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3020.mdls/cl00at10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3020.mdls/cl00at12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3020.mdls/cl00at12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3020.mdls/cl00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3020.mdls/cl00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3020.mdls/cl00ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3020.mdls/cl00ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3020.mdls/cl00ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3020.mdls/cl00ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3020.mdls/cl00ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3020.mdls/cl00ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3020.mdls/cl00ex10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3020.mdls/cl00ex10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3020.mdls/cl00ex13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3020.mdls/cl00ex13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3040.mdls/cl00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3040.mdls/cl00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3040.mdls/cl00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3040.mdls/cl00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3040.mdls/cl00at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3040.mdls/cl00at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3040.mdls/cl00at10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3040.mdls/cl00at10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3040.mdls/cl00at12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3040.mdls/cl00at12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3040.mdls/cl00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3040.mdls/cl00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3040.mdls/cl00ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3040.mdls/cl00ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3040.mdls/cl00ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3040.mdls/cl00ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3040.mdls/cl00ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3040.mdls/cl00ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3040.mdls/cl00ex10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3040.mdls/cl00ex10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_tz_3040.mdls/cl00ex13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xa_tz_3040.mdls/cl00ex13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xs_genie.dat/ge01at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xs_genie.dat/ge01at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xs_genie.dat/ge01ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xs_genie.dat/ge01ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xs_genie.dat/ge01ma01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xs_genie.dat/ge01ma01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xs_genie.dat/ge01ma02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xs_genie.dat/ge01ma02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xs_genie.dat/ge01ma03-2.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xs_genie.dat/ge01ma03-2.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xs_genie.dat/ge01ma04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xs_genie.dat/ge01ma04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xs_genie.dat/ge01ma05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xs_genie.dat/ge01ma05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xs_genie.dat/ge01ma06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xs_genie.dat/ge01ma06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xs_genie.dat/ge01ma09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xs_genie.dat/ge01ma09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xs_genie.dat/ge01ma10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xs_genie.dat/ge01ma10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xs_genie.dat/ge01ma11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xs_genie.dat/ge01ma11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xs_genie.dat/ge01ma12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xs_genie.dat/ge01ma12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xs_genie.dat/ge01ma13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xs_genie.dat/ge01ma13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xs_genie.dat/ge01mx14.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xs_genie.dat/ge01mx14.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xs_mushu.dat/mu00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xs_mushu.dat/mu00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xs_mushu.dat/mu00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fifth/remastered/xs_mushu.dat/mu00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1010.mdls/te00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1010.mdls/te00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1010.mdls/te00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1010.mdls/te00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1010.mdls/te00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1010.mdls/te00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1010.mdls/te00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1010.mdls/te00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1010.mdls/te00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1010.mdls/te00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1010.mdls/te00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1010.mdls/te00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1010.mdls/te00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1010.mdls/te00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1010.mdls/te00ex00-1.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1010.mdls/te00ex00-1.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1010.mdls/te00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1010.mdls/te00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1010.mdls/te00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1010.mdls/te00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1010.mdls/te00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1010.mdls/te00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1010.mdls/te00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1010.mdls/te00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1020.mdls/sl00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1020.mdls/sl00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1020.mdls/sl00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1020.mdls/sl00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1020.mdls/sl00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1020.mdls/sl00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1020.mdls/sl00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1020.mdls/sl00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1020.mdls/sl00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1020.mdls/sl00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1020.mdls/sl00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1020.mdls/sl00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1020.mdls/sl00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1020.mdls/sl00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1020.mdls/sl00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1020.mdls/sl00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1020.mdls/sl00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1020.mdls/sl00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1020.mdls/sl00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1020.mdls/sl00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1030.mdls/wa00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1030.mdls/wa00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1030.mdls/wa00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1030.mdls/wa00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1030.mdls/wa00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1030.mdls/wa00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1030.mdls/wa00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1030.mdls/wa00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1030.mdls/wa00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1030.mdls/wa00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1030.mdls/wa00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1030.mdls/wa00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1030.mdls/wa00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1030.mdls/wa00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1030.mdls/wa00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1030.mdls/wa00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1030.mdls/wa00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1030.mdls/wa00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_di_1030.mdls/wa00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_di_1030.mdls/wa00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01at0b.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01at0b.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01at6a.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01at6a.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01at6b.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01at6b.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1010.mdls/rk01ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/xa_ex_1010.mdls/rk01ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_1020.mdls/ia00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_1020.mdls/ia00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_1020.mdls/ia00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_1020.mdls/ia00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_1020.mdls/ia00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_1020.mdls/ia00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_1020.mdls/ia00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_1020.mdls/ia00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_1020.mdls/ia00ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_1020.mdls/ia00ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_1020.mdls/ia00ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_1020.mdls/ia00ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ma00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ma00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ma01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ma01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ma02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ma02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ma03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ma03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ma04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ma04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ma05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ma05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ma06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ma06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ma07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ma07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ma08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ma08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ma09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ma09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ma10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ma10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ma11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ma11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3010.mdls/ja01ma12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3010.mdls/ja01ma12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02da06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02da06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02ex07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02ex07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02ex08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02ex08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02ex09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02ex09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02ma00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02ma00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02ma00_1.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02ma00_1.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02ma01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02ma01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_al_3020.mdls/ja02ma01_1.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_al_3020.mdls/ja02ma01_1.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_aw_1010.mdls/qh00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_aw_1010.mdls/qh00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_aw_1010.mdls/qh00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_aw_1010.mdls/qh00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_aw_1010.mdls/qh00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_aw_1010.mdls/qh00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_aw_1010.mdls/qh00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_aw_1010.mdls/qh00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_aw_1010.mdls/qh00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_aw_1010.mdls/qh00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_aw_1010.mdls/qh00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_aw_1010.mdls/qh00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ew_3020.mdls/lb02at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ew_3020.mdls/lb02at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ew_3020.mdls/lb02at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ew_3020.mdls/lb02at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ew_3020.mdls/lb02at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ew_3020.mdls/lb02at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ew_3020.mdls/lb02at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ew_3020.mdls/lb02at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ew_3020.mdls/lb02at10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ew_3020.mdls/lb02at10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ew_3020.mdls/lb02at12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ew_3020.mdls/lb02at12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ew_3020.mdls/lb02at13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ew_3020.mdls/lb02at13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ew_3020.mdls/lb02da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ew_3020.mdls/lb02da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ew_3020.mdls/lb02da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ew_3020.mdls/lb02da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ew_3020.mdls/lb02da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ew_3020.mdls/lb02da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ew_3020.mdls/lb02da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ew_3020.mdls/lb02da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ew_3020.mdls/lb02da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ew_3020.mdls/lb02da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ew_3020.mdls/lb02da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ew_3020.mdls/lb02da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ew_3020.mdls/lb02da06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ew_3020.mdls/lb02da06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ew_3020.mdls/lb02ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ew_3020.mdls/lb02ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ew_3020.mdls/lb02ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ew_3020.mdls/lb02ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00at08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00at08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00at09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00at09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00at10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00at10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00da02_kp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00da02_kp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1030.mdls/le00da06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1030.mdls/le00da06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00at09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00at09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00at10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00at10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00at11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00at11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00at12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00at12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00at13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00at13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00at14.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00at14.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00at8b.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00at8b.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00da06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00da06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1040.mdls/ry00da07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1040.mdls/ry00da07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1090.mdls/ma00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1090.mdls/ma00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1090.mdls/ma00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1090.mdls/ma00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1090.mdls/ma00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1090.mdls/ma00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1090.mdls/ma00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1090.mdls/ma00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1090.mdls/ma00da0b.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1090.mdls/ma00da0b.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1090.mdls/ma00da1b.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1090.mdls/ma00da1b.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1090.mdls/ma00ma00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1090.mdls/ma00ma00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1090.mdls/ma00ma01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1090.mdls/ma00ma01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1090.mdls/ma00ma02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1090.mdls/ma00ma02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1090.mdls/ma00ma03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1090.mdls/ma00ma03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1090.mdls/ma00ma04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1090.mdls/ma00ma04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1090.mdls/ma00ma05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1090.mdls/ma00ma05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1090.mdls/ma00ma06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1090.mdls/ma00ma06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1090.mdls/ma00ma07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1090.mdls/ma00ma07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1150.mdls/ku00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1150.mdls/ku00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1150.mdls/ku00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1150.mdls/ku00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1150.mdls/ku00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1150.mdls/ku00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1150.mdls/ku00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1150.mdls/ku00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1150.mdls/ku00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1150.mdls/ku00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1150.mdls/ku00at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1150.mdls/ku00at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1150.mdls/ku00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1150.mdls/ku00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1150.mdls/ku00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1150.mdls/ku00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1150.mdls/ku00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1150.mdls/ku00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1150.mdls/ku00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1150.mdls/ku00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1160.mdls/rk03at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1160.mdls/rk03at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1160.mdls/rk03at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1160.mdls/rk03at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1160.mdls/rk03at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1160.mdls/rk03at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1160.mdls/rk03at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1160.mdls/rk03at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1160.mdls/rk03da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1160.mdls/rk03da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1160.mdls/rk03da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1160.mdls/rk03da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1160.mdls/rk03da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1160.mdls/rk03da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1160.mdls/rk03da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1160.mdls/rk03da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1160.mdls/rk03da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1160.mdls/rk03da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1160.mdls/rk03da07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1160.mdls/rk03da07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1160.mdls/rk03da0b.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1160.mdls/rk03da0b.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01at0b.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01at0b.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01at6a.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01at6a.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01at6b.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01at6b.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1560.mdls/rk01ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1560.mdls/rk01ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04at05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04at06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04at07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04at08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04at08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04at09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04at09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04at10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04at10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04at11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04at11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04at12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04at12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04at13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04at13.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04at14.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04at14.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04da04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04da05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04da06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04da06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04da07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04da07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04ex07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04ex07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04ex08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04ex08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04ex09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04ex09.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04ex10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04ex10.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04ex11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04ex11.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1580.mdls/rk04ex12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1580.mdls/rk04ex12.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00at00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00at01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00at02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00at03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00at04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00da00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00da01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00da02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00da03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00ex00.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00ex01.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00ex02.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00ex03.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00ex04.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00ex05.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00ex06.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00ex07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00ex07.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/xa_ex_1630.mdls/an00ex08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/xa_ex_1630.mdls/an00ex08.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/di_sora.vsb/di_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/di_sora.vsb/di_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/tw_sora.vsb/tw_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/tw_sora.vsb/tw_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/ew_donald.vsb/ew_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/ew_donald.vsb/ew_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/ew_goofy.vsb/ew_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/ew_goofy.vsb/ew_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/ew_sora.vsb/ew_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/ew_sora.vsb/ew_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/he_donald.vsb/he_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/he_donald.vsb/he_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/he_goofy.vsb/he_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/he_goofy.vsb/he_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/he_sora.vsb/he_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/he_sora.vsb/he_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/jack.vsb/jack.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/jack.vsb/jack.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/lm_donald.vsb/lm_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/lm_donald.vsb/lm_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/lm_goofy.vsb/lm_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/lm_goofy.vsb/lm_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/lm_sora.vsb/lm_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/lm_sora.vsb/lm_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/nm_donald.vsb/nm_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/nm_donald.vsb/nm_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/nm_goofy.vsb/nm_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/nm_goofy.vsb/nm_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/nm_sora.vsb/nm_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/nm_sora.vsb/nm_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/pc_donald.vsb/pc_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/pc_donald.vsb/pc_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/pc_goofy.vsb/pc_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/pc_goofy.vsb/pc_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/pc_sora.vsb/pc_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/pc_sora.vsb/pc_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/peterpan.vsb/peterpan.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/peterpan.vsb/peterpan.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/pi_donald.vsb/pi_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/pi_donald.vsb/pi_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/pi_goofy.vsb/pi_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/pi_goofy.vsb/pi_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/pi_sora.vsb/pi_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/pi_sora.vsb/pi_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/po_sora.vsb/po_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/po_sora.vsb/po_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/pp_donald.vsb/pp_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/pp_donald.vsb/pp_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/pp_goofy.vsb/pp_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/pp_goofy.vsb/pp_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/pp_sora.vsb/pp_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/pp_sora.vsb/pp_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/tarzan.vsb/tarzan.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/tarzan.vsb/tarzan.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/tw_donald.vsb/tw_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/tw_donald.vsb/tw_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/tw_goofy.vsb/tw_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/tw_goofy.vsb/tw_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/tz_donald.vsb/tz_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/tz_donald.vsb/tz_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/tz_goofy.vsb/tz_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/tz_goofy.vsb/tz_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/tz_sora.vsb/tz_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/tz_sora.vsb/tz_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/aladdin.vsb/aladdin.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/aladdin.vsb/aladdin.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/al_donald.vsb/al_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/al_donald.vsb/al_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/al_goofy.vsb/al_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/al_goofy.vsb/al_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/al_sora.vsb/al_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/al_sora.vsb/al_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/ariel.vsb/ariel.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/ariel.vsb/ariel.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/aw_donald.vsb/aw_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/aw_donald.vsb/aw_donald.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/aw_goofy.vsb/aw_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/aw_goofy.vsb/aw_goofy.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/aw_sora.vsb/aw_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/aw_sora.vsb/aw_sora.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/beast.vsb/beast.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/beast.vsb/beast.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_001.vset/dc0101do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_001.vset/dc0101do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_001.vset/dc0102do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_001.vset/dc0102do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_001.vset/dc0103do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_001.vset/dc0103do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_001.vset/dc0104do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_001.vset/dc0104do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_002.vset/dc0105do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_002.vset/dc0105do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_002.vset/dc0106go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_002.vset/dc0106go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_003.vset/dc0107do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_003.vset/dc0107do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_003.vset/dc0108go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_003.vset/dc0108go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_003.vset/dc0109do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_003.vset/dc0109do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_003.vset/dc0110go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_003.vset/dc0110go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_003.vset/dc0111do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_003.vset/dc0111do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_003.vset/dc0112go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_003.vset/dc0112go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_003.vset/dc0113do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_003.vset/dc0113do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_003.vset/dc0114go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_003.vset/dc0114go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_003.vset/dc0115do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_003.vset/dc0115do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_003.vset/dc0116da.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_003.vset/dc0116da.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_003.vset/dc0117do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_003.vset/dc0117do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_003.vset/dc01a1go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_003.vset/dc01a1go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_003.vset/dc01a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_003.vset/dc01a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_004.vset/dc0201da.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_004.vset/dc0201da.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_004.vset/dc0202mi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_004.vset/dc0202mi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_005.vset/dc0203go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_005.vset/dc0203go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_005.vset/dc0204do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_005.vset/dc0204do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_005.vset/dc0205mi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_005.vset/dc0205mi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_005.vset/dc0206do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_005.vset/dc0206do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_005.vset/dc0207da.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_005.vset/dc0207da.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_005.vset/dc0208mi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_005.vset/dc0208mi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_005.vset/dc0209ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_005.vset/dc0209ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_005.vset/dc0210ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_005.vset/dc0210ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_005.vset/dc0211mi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_005.vset/dc0211mi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_005.vset/dc0212do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_005.vset/dc0212do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_006.vset/dc0301go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_006.vset/dc0301go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_006.vset/dc0302ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_006.vset/dc0302ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_006.vset/dc0303do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_006.vset/dc0303do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_006.vset/dc0304go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_006.vset/dc0304go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_006.vset/dc0305go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_006.vset/dc0305go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_006.vset/dc0306go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_006.vset/dc0306go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_006.vset/dc0307do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_006.vset/dc0307do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_006.vset/dc0308go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_006.vset/dc0308go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_006.vset/dc0309do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_006.vset/dc0309do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_006.vset/dc0310go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_006.vset/dc0310go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_007.vset/dc0311do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_007.vset/dc0311do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_007.vset/dc0312do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_007.vset/dc0312do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_007.vset/dc0313do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_007.vset/dc0313do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_007.vset/dc03a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_007.vset/dc03a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/dc/dc_007.vset/dc03a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/dc/dc_007.vset/dc03a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_001.vset/di0100sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_001.vset/di0100sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_001.vset/di0101sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_001.vset/di0101sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_001.vset/di0102kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_001.vset/di0102kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_001.vset/di0103sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_001.vset/di0103sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_001.vset/di0104kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_001.vset/di0104kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_001.vset/di0105sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_001.vset/di0105sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_001.vset/di0107sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_001.vset/di0107sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_001.vset/di0108kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_001.vset/di0108kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_001.vset/di0109sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_001.vset/di0109sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_001.vset/di0110sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_001.vset/di0110sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_001.vset/di0111sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_001.vset/di0111sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_001.vset/di0112kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_001.vset/di0112kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_002.vset/di0113sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_002.vset/di0113sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_002.vset/di0114kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_002.vset/di0114kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_002.vset/di0115sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_002.vset/di0115sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_002.vset/di0116kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_002.vset/di0116kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_002.vset/di0117sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_002.vset/di0117sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_002.vset/di0118kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_002.vset/di0118kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_002.vset/di0119sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_002.vset/di0119sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_002.vset/di0120kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_002.vset/di0120kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_002.vset/di0121kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_002.vset/di0121kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_002.vset/di0122sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_002.vset/di0122sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_002.vset/di0123sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_002.vset/di0123sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_002.vset/di0124kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_002.vset/di0124kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_002.vset/di0125rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_002.vset/di0125rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_003.vset/di0126rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_003.vset/di0126rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_003.vset/di0127sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_003.vset/di0127sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_003.vset/di0128kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_003.vset/di0128kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_003.vset/di0129rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_003.vset/di0129rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_003.vset/di0130kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_003.vset/di0130kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_003.vset/di0131kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_003.vset/di0131kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_003.vset/di0132sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_003.vset/di0132sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_003.vset/di0133rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_003.vset/di0133rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_003.vset/di0134kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_003.vset/di0134kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_003.vset/di01a1kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_003.vset/di01a1kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_004.vset/di0301sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_004.vset/di0301sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_004.vset/di0302sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_004.vset/di0302sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_004.vset/di0303sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_004.vset/di0303sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_004.vset/di0304sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_004.vset/di0304sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_004.vset/di0305sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_004.vset/di0305sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_004.vset/di0306sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_004.vset/di0306sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_004.vset/di0307sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_004.vset/di0307sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_004.vset/di0308sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_004.vset/di0308sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_004.vset/di0309sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_004.vset/di0309sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_004.vset/di0310sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_004.vset/di0310sl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_005.vset/di0311wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_005.vset/di0311wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_005.vset/di0312wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_005.vset/di0312wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_005.vset/di0313wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_005.vset/di0313wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_005.vset/di0314wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_005.vset/di0314wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_005.vset/di0315wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_005.vset/di0315wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_005.vset/di0316wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_005.vset/di0316wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_005.vset/di0317wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_005.vset/di0317wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_005.vset/di0318wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_005.vset/di0318wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_005.vset/di0319wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_005.vset/di0319wa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_006.vset/di0320te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_006.vset/di0320te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_006.vset/di0321te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_006.vset/di0321te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_006.vset/di0322te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_006.vset/di0322te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_006.vset/di0324te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_006.vset/di0324te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_006.vset/di0326te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_006.vset/di0326te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_006.vset/di0327te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_006.vset/di0327te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_006.vset/di0328te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_006.vset/di0328te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_006.vset/di0329te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_006.vset/di0329te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_006.vset/di0330te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_006.vset/di0330te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_006.vset/di0332te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_006.vset/di0332te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_009.vset/di0501sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_009.vset/di0501sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_009.vset/di0502rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_009.vset/di0502rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_009.vset/di0503sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_009.vset/di0503sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_009.vset/di0504rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_009.vset/di0504rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_009.vset/di0505kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_009.vset/di0505kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_010.vset/di0506rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_010.vset/di0506rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_010.vset/di0507rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_010.vset/di0507rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_010.vset/di0508rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_010.vset/di0508rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_010.vset/di0509rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_010.vset/di0509rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_010.vset/di0510rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_010.vset/di0510rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_011.vset/di0511rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_011.vset/di0511rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_011.vset/di0512sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_011.vset/di0512sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_011.vset/di0513rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_011.vset/di0513rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_011.vset/di0514rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_011.vset/di0514rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_011.vset/di0515rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_011.vset/di0515rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_011.vset/di0516kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_011.vset/di0516kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_011.vset/di0517rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_011.vset/di0517rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_011.vset/di0518rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_011.vset/di0518rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_011.vset/di0519rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_011.vset/di0519rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_011.vset/di0520kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_011.vset/di0520kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_012.vset/di0521rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_012.vset/di0521rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_012.vset/di0522rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_012.vset/di0522rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_012.vset/di0523sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_012.vset/di0523sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_012.vset/di0524rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_012.vset/di0524rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_012.vset/di0525rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_012.vset/di0525rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_012.vset/di0526sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_012.vset/di0526sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_012.vset/di0527rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_012.vset/di0527rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_013.vset/di0601sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_013.vset/di0601sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_013.vset/di0602rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_013.vset/di0602rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_013.vset/di0603sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_013.vset/di0603sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_013.vset/di0604rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_013.vset/di0604rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_013.vset/di0605sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_013.vset/di0605sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_013.vset/di0606kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_013.vset/di0606kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_014.vset/di1001sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_014.vset/di1001sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_014.vset/di1002an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_014.vset/di1002an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_014.vset/di1003sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_014.vset/di1003sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_014.vset/di1004an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_014.vset/di1004an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_014.vset/di1005sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_014.vset/di1005sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_014.vset/di1006an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_014.vset/di1006an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_015.vset/di1007an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_015.vset/di1007an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_015.vset/di1008sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_015.vset/di1008sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_015.vset/di1009sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_015.vset/di1009sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_015.vset/di1010an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_015.vset/di1010an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_015.vset/di1011sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_015.vset/di1011sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_015.vset/di1012an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_015.vset/di1012an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_015.vset/di1013sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_015.vset/di1013sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_015.vset/di1014an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_015.vset/di1014an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_016.vset/di1101kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_016.vset/di1101kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_016.vset/di1102sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_016.vset/di1102sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_016.vset/di1103kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_016.vset/di1103kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_016.vset/di1104sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_016.vset/di1104sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_016.vset/di1105kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_016.vset/di1105kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_016.vset/di1106sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_016.vset/di1106sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_016.vset/di1107kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_016.vset/di1107kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_016.vset/di1108sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_016.vset/di1108sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_016.vset/di1109kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_016.vset/di1109kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_017.vset/di1110kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_017.vset/di1110kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_017.vset/di1111kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_017.vset/di1111kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_017.vset/di1112kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_017.vset/di1112kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_017.vset/di1113sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_017.vset/di1113sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_017.vset/di1114kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_017.vset/di1114kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_017.vset/di1115kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_017.vset/di1115kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_017.vset/di1116sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_017.vset/di1116sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_017.vset/di1117kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_017.vset/di1117kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_018.vset/di1201kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_018.vset/di1201kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_018.vset/di1202sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_018.vset/di1202sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_018.vset/di1203sm.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_018.vset/di1203sm.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_019.vset/di1301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_019.vset/di1301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_019.vset/di1302sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_019.vset/di1302sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_019.vset/di13a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_019.vset/di13a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_020.vset/di1501sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_020.vset/di1501sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_020.vset/di1502rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_020.vset/di1502rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_020.vset/di1503sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_020.vset/di1503sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_020.vset/di1504rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_020.vset/di1504rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_020.vset/di1505sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_020.vset/di1505sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_020.vset/di1506rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_020.vset/di1506rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_020.vset/di1507rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_020.vset/di1507rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_020.vset/di1508rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_020.vset/di1508rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_020.vset/di1509rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_020.vset/di1509rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_020.vset/di1510sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_020.vset/di1510sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_021.vset/di1601sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_021.vset/di1601sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_021.vset/di1603sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_021.vset/di1603sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_021.vset/di1604kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_021.vset/di1604kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_022.vset/di1701sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_022.vset/di1701sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_022.vset/di1702sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_022.vset/di1702sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_022.vset/di1703sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_022.vset/di1703sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_022.vset/di1704sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/di/di_022.vset/di1704sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_001.vset/tw0101go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_001.vset/tw0101go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_001.vset/tw0102do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_001.vset/tw0102do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_001.vset/tw0103do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_001.vset/tw0103do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_001.vset/tw0104do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_001.vset/tw0104do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_001.vset/tw0105go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_001.vset/tw0105go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_001.vset/tw0106go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_001.vset/tw0106go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_001.vset/tw0107do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_001.vset/tw0107do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_001.vset/tw0108go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_001.vset/tw0108go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_001.vset/tw0117do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_001.vset/tw0117do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_001.vset/tw01a1go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_001.vset/tw01a1go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_001.vset/tw01a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_001.vset/tw01a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_002.vset/tw0109sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_002.vset/tw0109sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_002.vset/tw0110sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_002.vset/tw0110sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_002.vset/tw0111sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_002.vset/tw0111sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_002.vset/tw0112sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_002.vset/tw0112sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_002.vset/tw0113sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_002.vset/tw0113sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_002.vset/tw0114sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_002.vset/tw0114sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_002.vset/tw0115sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_002.vset/tw0115sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_002.vset/tw0116sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_first/remastered/voice/event/tw/tw_002.vset/tw0116sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_001.vset/ew0101go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_001.vset/ew0101go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_001.vset/ew0102sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_001.vset/ew0102sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_001.vset/ew0103do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_001.vset/ew0103do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_001.vset/ew0104sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_001.vset/ew0104sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_002.vset/ew0105do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_002.vset/ew0105do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_002.vset/ew0106go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_002.vset/ew0106go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_002.vset/ew0107go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_002.vset/ew0107go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_002.vset/ew0108sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_002.vset/ew0108sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_002.vset/ew0109sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_002.vset/ew0109sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_002.vset/ew01a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_002.vset/ew01a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_002.vset/ew01a2sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_002.vset/ew01a2sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_002.vset/ew01a3do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_002.vset/ew01a3do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_004.vset/ew0201sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_004.vset/ew0201sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_005.vset/ew0203an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_005.vset/ew0203an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_005.vset/ew0204an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_005.vset/ew0204an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_005.vset/ew0205sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_005.vset/ew0205sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_005.vset/ew0206an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_005.vset/ew0206an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_006.vset/ew0207an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_006.vset/ew0207an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_006.vset/ew0208an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_006.vset/ew0208an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_006.vset/ew0209sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_006.vset/ew0209sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_006.vset/ew0210sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_006.vset/ew0210sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_007.vset/ew0211an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_007.vset/ew0211an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_008.vset/ew0301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_008.vset/ew0301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_008.vset/ew0302go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_008.vset/ew0302go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_008.vset/ew0303do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_008.vset/ew0303do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_008.vset/ew0304do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_008.vset/ew0304do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_008.vset/ew0305go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_008.vset/ew0305go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_008.vset/ew0306do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_008.vset/ew0306do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_008.vset/ew0307sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_008.vset/ew0307sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_008.vset/ew0308rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_008.vset/ew0308rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_008.vset/ew0309rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_008.vset/ew0309rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_008.vset/ew0310sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_008.vset/ew0310sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_008.vset/ew03a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_008.vset/ew03a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_009.vset/ew0311do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_009.vset/ew0311do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_009.vset/ew0312do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_009.vset/ew0312do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_009.vset/ew0313go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_009.vset/ew0313go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_009.vset/ew0314mm.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_009.vset/ew0314mm.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_009.vset/ew0315do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_009.vset/ew0315do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_009.vset/ew0316sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_009.vset/ew0316sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_009.vset/ew0317mm.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_009.vset/ew0317mm.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_009.vset/ew0318go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_009.vset/ew0318go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_009.vset/ew0319rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_009.vset/ew0319rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_009.vset/ew0320mm.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_009.vset/ew0320mm.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_009.vset/ew0321rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_009.vset/ew0321rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_009.vset/ew03a2do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_009.vset/ew03a2do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_009.vset/ew03a3go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_009.vset/ew03a3go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_010.vset/ew0212sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_010.vset/ew0212sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_010.vset/ew0213an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_010.vset/ew0213an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_010.vset/ew0214an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_010.vset/ew0214an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_010.vset/ew0215an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_010.vset/ew0215an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_010.vset/ew0216rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_010.vset/ew0216rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_010.vset/ew02a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_010.vset/ew02a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_011.vset/ew0217an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_011.vset/ew0217an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_012.vset/ew0218an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_012.vset/ew0218an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_012.vset/ew0219an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_012.vset/ew0219an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_012.vset/ew0220sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_012.vset/ew0220sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_012.vset/ew0221sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_012.vset/ew0221sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_012.vset/ew0222an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_012.vset/ew0222an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_012.vset/ew0223an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_012.vset/ew0223an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_013.vset/ew0202go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_013.vset/ew0202go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_013.vset/ew0601an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_013.vset/ew0601an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_013.vset/ew0602an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_013.vset/ew0602an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_013.vset/ew0603an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_013.vset/ew0603an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_013.vset/ew0604an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_013.vset/ew0604an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_013.vset/ew0605an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_013.vset/ew0605an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_014.vset/ew02a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_014.vset/ew02a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_014.vset/ew02a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_014.vset/ew02a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_015.vset/ew0216rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_015.vset/ew0216rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_015.vset/ew02a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_015.vset/ew02a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_015.vset/ew02a4sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_015.vset/ew02a4sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_015.vset/ew02a5do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_015.vset/ew02a5do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_015.vset/ew02a6go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_015.vset/ew02a6go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_015.vset/ew02a7do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_015.vset/ew02a7do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_015.vset/ew02a8go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_015.vset/ew02a8go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/ew/ew_015.vset/ew02a9sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/ew/ew_015.vset/ew02a9sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_001.vset/he0201sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_001.vset/he0201sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_001.vset/he0202ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_001.vset/he0202ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_001.vset/he0203ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_001.vset/he0203ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_002.vset/he0301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_002.vset/he0301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_002.vset/he0302ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_002.vset/he0302ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_002.vset/he0303ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_002.vset/he0303ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_002.vset/he0304ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_002.vset/he0304ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_002.vset/he0305ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_002.vset/he0305ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_003.vset/he0307ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_003.vset/he0307ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_003.vset/he0308ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_003.vset/he0308ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_003.vset/he0309do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_003.vset/he0309do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_003.vset/he0310go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_003.vset/he0310go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_003.vset/he0311do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_003.vset/he0311do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_004.vset/he0312ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_004.vset/he0312ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_004.vset/he0313ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_004.vset/he0313ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_004.vset/he0314sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_004.vset/he0314sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_004.vset/he0315ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_004.vset/he0315ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_005.vset/he0316ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_005.vset/he0316ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_005.vset/he0317ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_005.vset/he0317ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_005.vset/he0318ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_005.vset/he0318ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_006.vset/he0501ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_006.vset/he0501ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_006.vset/he0502sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_006.vset/he0502sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_006.vset/he0503ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_006.vset/he0503ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_006.vset/he0504sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_006.vset/he0504sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_006.vset/he0505ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_006.vset/he0505ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_006.vset/he0506ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_006.vset/he0506ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_006.vset/he0507sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_006.vset/he0507sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_007.vset/he0701ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_007.vset/he0701ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_007.vset/he0702do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_007.vset/he0702do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_007.vset/he0703ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_007.vset/he0703ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_007.vset/he0704ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_007.vset/he0704ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_007.vset/he0705sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_007.vset/he0705sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_007.vset/he0706ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_007.vset/he0706ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_015.vset/he1601ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_015.vset/he1601ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_015.vset/he1602ku.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_015.vset/he1602ku.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_015.vset/he1603ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_015.vset/he1603ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_015.vset/he1604ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_015.vset/he1604ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_015.vset/he1605ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_015.vset/he1605ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_015.vset/he1606ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_015.vset/he1606ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_016.vset/he1608ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_016.vset/he1608ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_016.vset/he1609ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_016.vset/he1609ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_018.vset/he1801sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_018.vset/he1801sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_018.vset/he1802ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_018.vset/he1802ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_018.vset/he1803ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_018.vset/he1803ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_018.vset/he1804hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_018.vset/he1804hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_018.vset/he18a2do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_018.vset/he18a2do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_018.vset/he18a3go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_018.vset/he18a3go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_020.vset/he2101ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_020.vset/he2101ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_022.vset/he2201ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_022.vset/he2201ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_022.vset/he2202hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_022.vset/he2202hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_022.vset/he2203do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_022.vset/he2203do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_022.vset/he2204ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_022.vset/he2204ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_023.vset/he2205go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_023.vset/he2205go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_023.vset/he2206hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_023.vset/he2206hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_023.vset/he2207hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_023.vset/he2207hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_023.vset/he2208sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_023.vset/he2208sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_023.vset/he2209ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_023.vset/he2209ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_023.vset/he2210sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_023.vset/he2210sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_024.vset/he2211ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_024.vset/he2211ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_024.vset/he2212hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_024.vset/he2212hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_024.vset/he2213ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_024.vset/he2213ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_030.vset/he2301ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_030.vset/he2301ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_030.vset/he2302ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_030.vset/he2302ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_030.vset/he2303ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_030.vset/he2303ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_030.vset/he2304ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_030.vset/he2304ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_030.vset/he2305ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_030.vset/he2305ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_035.vset/he3001sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_035.vset/he3001sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_035.vset/he3002ku.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_035.vset/he3002ku.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_035.vset/he3003sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_035.vset/he3003sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_035.vset/he3004ku.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_035.vset/he3004ku.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_035.vset/he3005ku.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_035.vset/he3005ku.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_035.vset/he3006ku.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_035.vset/he3006ku.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_036.vset/he3007sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_036.vset/he3007sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_036.vset/he3008sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_036.vset/he3008sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_036.vset/he3009ku.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_036.vset/he3009ku.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_036.vset/he3010ku.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_036.vset/he3010ku.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_036.vset/he3011sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_036.vset/he3011sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_036.vset/he3012ku.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_036.vset/he3012ku.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_040.vset/he2701hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_040.vset/he2701hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_040.vset/he2702hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_040.vset/he2702hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_040.vset/he2703sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_040.vset/he2703sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_040.vset/he2704ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_040.vset/he2704ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_041.vset/he2705sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_041.vset/he2705sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_041.vset/he2706sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_041.vset/he2706sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_041.vset/he2707ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_041.vset/he2707ph.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_041.vset/he2708hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_041.vset/he2708hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_042.vset/he2709hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_042.vset/he2709hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_042.vset/he2710hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_042.vset/he2710hc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_043.vset/he2801ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_043.vset/he2801ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_044.vset/he2901ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_044.vset/he2901ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_044.vset/he2902ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_044.vset/he2902ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_050.vset/he2401sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_050.vset/he2401sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_050.vset/he2402sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_050.vset/he2402sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_050.vset/he2403sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_050.vset/he2403sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_050.vset/he2404sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_050.vset/he2404sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_050.vset/he2405do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_050.vset/he2405do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_050.vset/he2406do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_050.vset/he2406do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_050.vset/he2407do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_050.vset/he2407do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_050.vset/he2408go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_050.vset/he2408go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_050.vset/he2409go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_050.vset/he2409go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_050.vset/he2410go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_050.vset/he2410go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_050.vset/he2411sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_050.vset/he2411sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_050.vset/he2412sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_050.vset/he2412sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_050.vset/he2413do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_050.vset/he2413do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_050.vset/he2414do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_050.vset/he2414do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_050.vset/he2415go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_050.vset/he2415go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_050.vset/he2416go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_050.vset/he2416go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_050.vset/he2417sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_050.vset/he2417sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/he/he_051.vset/he2418sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/he/he_051.vset/he2418sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_001.vset/lm0101ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_001.vset/lm0101ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_001.vset/lm0102sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_001.vset/lm0102sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_001.vset/lm0103sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_001.vset/lm0103sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_001.vset/lm0104ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_001.vset/lm0104ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_001.vset/lm0105ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_001.vset/lm0105ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_001.vset/lm0106fl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_001.vset/lm0106fl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_001.vset/lm0107sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_001.vset/lm0107sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_002.vset/lm0108ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_002.vset/lm0108ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_002.vset/lm0109sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_002.vset/lm0109sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_002.vset/lm0110sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_002.vset/lm0110sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_002.vset/lm0111ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_002.vset/lm0111ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_002.vset/lm0112sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_002.vset/lm0112sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_002.vset/lm0113ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_002.vset/lm0113ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_003.vset/lm0201sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_003.vset/lm0201sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_003.vset/lm0202ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_003.vset/lm0202ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_003.vset/lm0203sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_003.vset/lm0203sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_004.vset/lm0401tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_004.vset/lm0401tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_004.vset/lm0402sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_004.vset/lm0402sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_004.vset/lm0403tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_004.vset/lm0403tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_004.vset/lm0404ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_004.vset/lm0404ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_004.vset/lm0405tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_004.vset/lm0405tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_004.vset/lm0406tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_004.vset/lm0406tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_004.vset/lm0407ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_004.vset/lm0407ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_005.vset/lm0408sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_005.vset/lm0408sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_005.vset/lm0409sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_005.vset/lm0409sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_005.vset/lm0410tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_005.vset/lm0410tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_005.vset/lm0411ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_005.vset/lm0411ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_005.vset/lm0412tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_005.vset/lm0412tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_005.vset/lm0413sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_005.vset/lm0413sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_005.vset/lm0414go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_005.vset/lm0414go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_005.vset/lm0415tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_005.vset/lm0415tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_005.vset/lm0416ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_005.vset/lm0416ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_005.vset/lm0417go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_005.vset/lm0417go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_005.vset/lm0418tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_005.vset/lm0418tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_005.vset/lm0419ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_005.vset/lm0419ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_006.vset/lm0420tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_006.vset/lm0420tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_006.vset/lm0421tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_006.vset/lm0421tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_007.vset/lm0422tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_007.vset/lm0422tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_007.vset/lm0423tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_007.vset/lm0423tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_007.vset/lm0424sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_007.vset/lm0424sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_007.vset/lm0425sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_007.vset/lm0425sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_007.vset/lm0426tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_007.vset/lm0426tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_008.vset/lm0427tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_008.vset/lm0427tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_008.vset/lm0428sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_008.vset/lm0428sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_008.vset/lm0429tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_008.vset/lm0429tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_008.vset/lm0430tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_008.vset/lm0430tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_008.vset/lm0431sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_008.vset/lm0431sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_008.vset/lm0432tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_008.vset/lm0432tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_008.vset/lm0433sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_008.vset/lm0433sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_009.vset/lm0601ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_009.vset/lm0601ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_009.vset/lm0602ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_009.vset/lm0602ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_009.vset/lm0603ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_009.vset/lm0603ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_010.vset/lm1101tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_010.vset/lm1101tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_010.vset/lm1102ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_010.vset/lm1102ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_010.vset/lm1103ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_010.vset/lm1103ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_010.vset/lm1104tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_010.vset/lm1104tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_010.vset/lm1105sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_010.vset/lm1105sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_010.vset/lm1106tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_010.vset/lm1106tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_010.vset/lm1107sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_010.vset/lm1107sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_011.vset/lm1108tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_011.vset/lm1108tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_011.vset/lm1109sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_011.vset/lm1109sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_011.vset/lm1110tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_011.vset/lm1110tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_011.vset/lm1111tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_011.vset/lm1111tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_011.vset/lm1112sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_011.vset/lm1112sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_011.vset/lm1113tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_011.vset/lm1113tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_011.vset/lm1114go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_011.vset/lm1114go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_011.vset/lm1115tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_011.vset/lm1115tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_012.vset/lm1116jt.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_012.vset/lm1116jt.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_012.vset/lm1117fs.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_012.vset/lm1117fs.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_012.vset/lm1118jt.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_012.vset/lm1118jt.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_012.vset/lm1119fs.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_012.vset/lm1119fs.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_012.vset/lm1120ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_012.vset/lm1120ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_012.vset/lm1121jt.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_012.vset/lm1121jt.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_012.vset/lm1122fs.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_012.vset/lm1122fs.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_012.vset/lm1123jt.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_012.vset/lm1123jt.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_012.vset/lm1124fs.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_012.vset/lm1124fs.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_013.vset/lm1125ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_013.vset/lm1125ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_013.vset/lm1126ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_013.vset/lm1126ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_013.vset/lm1127ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_013.vset/lm1127ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_013.vset/lm1128ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_013.vset/lm1128ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_013.vset/lm1129ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_013.vset/lm1129ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_013.vset/lm1130ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_013.vset/lm1130ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_013.vset/lm1131ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_013.vset/lm1131ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_013.vset/lm1132ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_013.vset/lm1132ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_014.vset/lm1133ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_014.vset/lm1133ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_014.vset/lm1134ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_014.vset/lm1134ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_014.vset/lm1135ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_014.vset/lm1135ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_015.vset/lm1201ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_015.vset/lm1201ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_015.vset/lm1202ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_015.vset/lm1202ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_015.vset/lm1203ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_015.vset/lm1203ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_016.vset/lm1301ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_016.vset/lm1301ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_016.vset/lm1302ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_016.vset/lm1302ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_016.vset/lm1303ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_016.vset/lm1303ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_016.vset/lm1304ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_016.vset/lm1304ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_017.vset/lm1305ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_017.vset/lm1305ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_017.vset/lm1306jt.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_017.vset/lm1306jt.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_017.vset/lm1307fs.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_017.vset/lm1307fs.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_017.vset/lm1308ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_017.vset/lm1308ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_017.vset/lm1309ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_017.vset/lm1309ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_017.vset/lm1310ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_017.vset/lm1310ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_018.vset/lm1501do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_018.vset/lm1501do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_018.vset/lm1502sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_018.vset/lm1502sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_018.vset/lm15a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_018.vset/lm15a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_018.vset/lm15a2sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_018.vset/lm15a2sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_019.vset/lm1701ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_019.vset/lm1701ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_019.vset/lm17a1ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_019.vset/lm17a1ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_020.vset/lm1801ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_020.vset/lm1801ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_020.vset/lm1802ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_020.vset/lm1802ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_020.vset/lm18a1ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_020.vset/lm18a1ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_021.vset/lm2001ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_021.vset/lm2001ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_021.vset/lm2002sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_021.vset/lm2002sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_021.vset/lm2003ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_021.vset/lm2003ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_021.vset/lm2004ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_021.vset/lm2004ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_021.vset/lm2005ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_021.vset/lm2005ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_021.vset/lm2006ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_021.vset/lm2006ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_021.vset/lm2007sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_021.vset/lm2007sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_022.vset/lm1311ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_022.vset/lm1311ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_022.vset/lm1312tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_022.vset/lm1312tr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_022.vset/lm1313sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_022.vset/lm1313sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_022.vset/lm1314ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_022.vset/lm1314ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_022.vset/lm1315ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_022.vset/lm1315ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_022.vset/lm1316ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_022.vset/lm1316ar.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_022.vset/lm1317sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_022.vset/lm1317sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/lm/lm_022.vset/lm1318sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/lm/lm_022.vset/lm1318sb.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_001.vset/nm0501jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_001.vset/nm0501jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_001.vset/nm0502fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_001.vset/nm0502fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_001.vset/nm0503jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_001.vset/nm0503jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_001.vset/nm0504jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_001.vset/nm0504jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_001.vset/nm0505fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_001.vset/nm0505fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_001.vset/nm0506jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_001.vset/nm0506jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_001.vset/nm0507fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_001.vset/nm0507fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_002.vset/nm0601jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_002.vset/nm0601jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_002.vset/nm0602sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_002.vset/nm0602sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_002.vset/nm0603jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_002.vset/nm0603jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_002.vset/nm0604sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_002.vset/nm0604sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_002.vset/nm0605jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_002.vset/nm0605jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_002.vset/nm0606jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_002.vset/nm0606jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_002.vset/nm0607jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_002.vset/nm0607jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_003.vset/nm0701my.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_003.vset/nm0701my.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_003.vset/nm0702my.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_003.vset/nm0702my.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_003.vset/nm0703jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_003.vset/nm0703jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_004.vset/nm1101bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_004.vset/nm1101bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_004.vset/nm1102bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_004.vset/nm1102bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_005.vset/nm0501jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_005.vset/nm0501jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_005.vset/nm0502fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_005.vset/nm0502fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_005.vset/nm0503jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_005.vset/nm0503jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_005.vset/nm0504jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_005.vset/nm0504jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_005.vset/nm0505fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_005.vset/nm0505fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_005.vset/nm0506jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_005.vset/nm0506jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_005.vset/nm0507fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_005.vset/nm0507fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_006.vset/nm1801jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_006.vset/nm1801jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_007.vset/nm0701my.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_007.vset/nm0701my.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_007.vset/nm0702my.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_007.vset/nm0702my.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_007.vset/nm0703jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_007.vset/nm0703jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_008.vset/nm2202bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_008.vset/nm2202bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_008.vset/nm2203bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_008.vset/nm2203bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_008.vset/nm2204bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_008.vset/nm2204bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_008.vset/nm22a1bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_008.vset/nm22a1bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_009.vset/nm2301bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_009.vset/nm2301bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_010.vset/nm0608jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_010.vset/nm0608jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_010.vset/nm0609jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_010.vset/nm0609jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_010.vset/nm0610fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_010.vset/nm0610fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_010.vset/nm0611jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_010.vset/nm0611jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_010.vset/nm0612jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_010.vset/nm0612jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_010.vset/nm0613jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_010.vset/nm0613jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_010.vset/nm0614jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_010.vset/nm0614jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_011.vset/nm1101bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_011.vset/nm1101bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_011.vset/nm1102bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_011.vset/nm1102bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_014.vset/nm1401fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_014.vset/nm1401fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_014.vset/nm1402ba.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_014.vset/nm1402ba.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_014.vset/nm1404ro.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_014.vset/nm1404ro.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_014.vset/nm14a1fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_014.vset/nm14a1fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_014.vset/nm14a2fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_014.vset/nm14a2fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_018.vset/nm1801jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_018.vset/nm1801jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_019.vset/nm1901ba.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_019.vset/nm1901ba.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_022.vset/nm2202bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_022.vset/nm2202bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_022.vset/nm2203bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_022.vset/nm2203bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_022.vset/nm2204bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_022.vset/nm2204bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_023.vset/nm2301bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_023.vset/nm2301bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_024.vset/nm25a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_024.vset/nm25a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_024.vset/nm25a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_024.vset/nm25a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_025.vset/nm2505jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_025.vset/nm2505jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_027.vset/nm2501jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_027.vset/nm2501jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_027.vset/nm2502sa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_027.vset/nm2502sa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_027.vset/nm2503sa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_027.vset/nm2503sa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_061.vset/nm0601jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_061.vset/nm0601jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_061.vset/nm0602sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_061.vset/nm0602sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_061.vset/nm0603jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_061.vset/nm0603jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_061.vset/nm0604sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_061.vset/nm0604sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_061.vset/nm0605jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_061.vset/nm0605jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_062.vset/nm0606jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_062.vset/nm0606jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_062.vset/nm0607jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_062.vset/nm0607jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_062.vset/nm0608jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_062.vset/nm0608jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_062.vset/nm0609jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_062.vset/nm0609jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_062.vset/nm0610fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_062.vset/nm0610fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_062.vset/nm0611jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_062.vset/nm0611jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_062.vset/nm0612jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_062.vset/nm0612jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_062.vset/nm0613jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_062.vset/nm0613jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_062.vset/nm0614jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_062.vset/nm0614jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_063.vset/nm0615fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_063.vset/nm0615fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_063.vset/nm0616fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_063.vset/nm0616fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_063.vset/nm0617fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_063.vset/nm0617fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_063.vset/nm0618fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_063.vset/nm0618fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_063.vset/nm0619fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_063.vset/nm0619fi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_063.vset/nm0620jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_063.vset/nm0620jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_063.vset/nm0621sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_063.vset/nm0621sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_100.vset/nm0301my.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_100.vset/nm0301my.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_100.vset/nm0302my.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_100.vset/nm0302my.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_100.vset/nm0303jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_100.vset/nm0303jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_100.vset/nm0304jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_100.vset/nm0304jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_100.vset/nm0305jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_100.vset/nm0305jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_100.vset/nm0306my.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_100.vset/nm0306my.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_101.vset/nm0801jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_101.vset/nm0801jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_101.vset/nm0802sa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_101.vset/nm0802sa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_101.vset/nm0803sa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_101.vset/nm0803sa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_101.vset/nm0804jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_101.vset/nm0804jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_101.vset/nm0805jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_101.vset/nm0805jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_101.vset/nm0806sa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_101.vset/nm0806sa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_102.vset/nm0807sa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_102.vset/nm0807sa.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_102.vset/nm0808jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_102.vset/nm0808jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_102.vset/nm0809jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_102.vset/nm0809jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_102.vset/nm0810jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_102.vset/nm0810jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_103.vset/nm0901ro.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_103.vset/nm0901ro.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_103.vset/nm0902so.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_103.vset/nm0902so.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_103.vset/nm0903ba.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_103.vset/nm0903ba.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_103.vset/nm0904ro.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_103.vset/nm0904ro.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_103.vset/nm0905so.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_103.vset/nm0905so.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_103.vset/nm0906ba.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_103.vset/nm0906ba.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_103.vset/nm0907ba.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_103.vset/nm0907ba.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_103.vset/nm0908ro.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_103.vset/nm0908ro.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_103.vset/nm0909so.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_103.vset/nm0909so.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_103.vset/nm0910ba.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_103.vset/nm0910ba.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_103.vset/nm0911ro.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_103.vset/nm0911ro.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_103.vset/nm0912so.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_103.vset/nm0912so.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_103.vset/nm0913ba.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_103.vset/nm0913ba.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_104.vset/nm1501sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_104.vset/nm1501sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/nm/nm_104.vset/nm1503jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/nm/nm_104.vset/nm1503jc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_011.vset/pc0101rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_011.vset/pc0101rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_011.vset/pc0102ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_011.vset/pc0102ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_011.vset/pc0104ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_011.vset/pc0104ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_012.vset/pc0105ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_012.vset/pc0105ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_012.vset/pc0106ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_012.vset/pc0106ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_012.vset/pc0107rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_012.vset/pc0107rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_012.vset/pc0108ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_012.vset/pc0108ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_071.vset/pc0401rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_071.vset/pc0401rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_071.vset/pc0402be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_071.vset/pc0402be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_071.vset/pc0403be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_071.vset/pc0403be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_071.vset/pc0404be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_071.vset/pc0404be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_071.vset/pc0405rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_071.vset/pc0405rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_072.vset/pc0407sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_072.vset/pc0407sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_072.vset/pc0408rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_072.vset/pc0408rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_072.vset/pc0409rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_072.vset/pc0409rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_072.vset/pc0410sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_072.vset/pc0410sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_072.vset/pc0411rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_072.vset/pc0411rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_072.vset/pc04a2be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_072.vset/pc04a2be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_073.vset/pc0412sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_073.vset/pc0412sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_073.vset/pc0413rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_073.vset/pc0413rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_073.vset/pc0415rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_073.vset/pc0415rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_073.vset/pc0416sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_073.vset/pc0416sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_073.vset/pc0417do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_073.vset/pc0417do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_073.vset/pc0418go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_073.vset/pc0418go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_073.vset/pc0419rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_073.vset/pc0419rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_073.vset/pc0420rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_073.vset/pc0420rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_073.vset/pc04a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_073.vset/pc04a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_073.vset/pc04a4sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_073.vset/pc04a4sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_074.vset/pc0421sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_074.vset/pc0421sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_074.vset/pc0422rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_074.vset/pc0422rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_074.vset/pc0423rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_074.vset/pc0423rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_075.vset/pc0424do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_075.vset/pc0424do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_075.vset/pc0425do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_075.vset/pc0425do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_075.vset/pc0426go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_075.vset/pc0426go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_075.vset/pc0427go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_075.vset/pc0427go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_075.vset/pc0428do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_075.vset/pc0428do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_075.vset/pc04a1go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_075.vset/pc04a1go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_076.vset/pc0429be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_076.vset/pc0429be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_077.vset/pc0430sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_077.vset/pc0430sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_077.vset/pc0431be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_077.vset/pc0431be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_077.vset/pc0432be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_077.vset/pc0432be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_077.vset/pc0433be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_077.vset/pc0433be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_077.vset/pc0434sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_077.vset/pc0434sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_091.vset/pc0501ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_091.vset/pc0501ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_101.vset/pc0601be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_101.vset/pc0601be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_101.vset/pc0602be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_101.vset/pc0602be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_101.vset/pc06a1be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_101.vset/pc06a1be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_102.vset/pc0603rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_102.vset/pc0603rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_102.vset/pc0604sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_102.vset/pc0604sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_102.vset/pc0605rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_102.vset/pc0605rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_102.vset/pc0606sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_102.vset/pc0606sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_102.vset/pc0607rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_102.vset/pc0607rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_102.vset/pc0608sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_102.vset/pc0608sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_102.vset/pc0609rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_102.vset/pc0609rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_103.vset/pc0610go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_103.vset/pc0610go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_103.vset/pc0611rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_103.vset/pc0611rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_103.vset/pc0612go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_103.vset/pc0612go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_103.vset/pc0613go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_103.vset/pc0613go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_103.vset/pc0614do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_103.vset/pc0614do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_103.vset/pc0615do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_103.vset/pc0615do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_103.vset/pc0616do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_103.vset/pc0616do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_103.vset/pc0617go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_103.vset/pc0617go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_103.vset/pc0618sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_103.vset/pc0618sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_104.vset/pc0619rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_104.vset/pc0619rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_104.vset/pc0620sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_104.vset/pc0620sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_104.vset/pc0621sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_104.vset/pc0621sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_104.vset/pc0622rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_104.vset/pc0622rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_104.vset/pc0623sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_104.vset/pc0623sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_104.vset/pc0624sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_104.vset/pc0624sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_104.vset/pc0625rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_104.vset/pc0625rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_104.vset/pc0626sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_104.vset/pc0626sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_111.vset/pc0701be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_111.vset/pc0701be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_131.vset/pc0801rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_131.vset/pc0801rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_131.vset/pc0802an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_131.vset/pc0802an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_131.vset/pc0803rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_131.vset/pc0803rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_131.vset/pc0804an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_131.vset/pc0804an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_132.vset/pc0805an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_132.vset/pc0805an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_132.vset/pc0806an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_132.vset/pc0806an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_132.vset/pc0807rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_132.vset/pc0807rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_132.vset/pc0808an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_132.vset/pc0808an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_141.vset/pc0901rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_141.vset/pc0901rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_141.vset/pc0902ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_141.vset/pc0902ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_141.vset/pc0903rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_141.vset/pc0903rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_141.vset/pc0904ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_141.vset/pc0904ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_141.vset/pc0905rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_141.vset/pc0905rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_142.vset/pc0906ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_142.vset/pc0906ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_142.vset/pc0907ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_142.vset/pc0907ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_142.vset/pc0908ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_142.vset/pc0908ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_142.vset/pc0909rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_142.vset/pc0909rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_142.vset/pc0910ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_142.vset/pc0910ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_142.vset/pc0911ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_142.vset/pc0911ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_142.vset/pc09a1ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_142.vset/pc09a1ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_151.vset/pc1001ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_151.vset/pc1001ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_151.vset/pc1002sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_151.vset/pc1002sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_151.vset/pc1003ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_151.vset/pc1003ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_171.vset/pc1101rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_171.vset/pc1101rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_171.vset/pc1102sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_171.vset/pc1102sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_171.vset/pc11a1ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_171.vset/pc11a1ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_172.vset/pc1103do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_172.vset/pc1103do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_172.vset/pc1104rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_172.vset/pc1104rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_172.vset/pc1105rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_172.vset/pc1105rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_172.vset/pc1106rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_172.vset/pc1106rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_172.vset/pc1107ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_172.vset/pc1107ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_172.vset/pc1108rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_172.vset/pc1108rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_172.vset/pc1109ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_172.vset/pc1109ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_181.vset/pc1201rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_181.vset/pc1201rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_181.vset/pc1202do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_181.vset/pc1202do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_181.vset/pc1203rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_181.vset/pc1203rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_191.vset/pc1301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_191.vset/pc1301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_191.vset/pc1302sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_191.vset/pc1302sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_191.vset/pc1303rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_191.vset/pc1303rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_191.vset/pc1304rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_191.vset/pc1304rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_191.vset/pc1305sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_191.vset/pc1305sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_191.vset/pc1306rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_191.vset/pc1306rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_191.vset/pc1307sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_191.vset/pc1307sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_192.vset/pc1308rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_192.vset/pc1308rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_192.vset/pc1309sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_192.vset/pc1309sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_192.vset/pc1310rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_192.vset/pc1310rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_192.vset/pc1311do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_192.vset/pc1311do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_192.vset/pc1312sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_192.vset/pc1312sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_192.vset/pc1313sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_192.vset/pc1313sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_192.vset/pc1314rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_192.vset/pc1314rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_192.vset/pc1315sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_192.vset/pc1315sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_193.vset/pc1316rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_193.vset/pc1316rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_193.vset/pc1317sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_193.vset/pc1317sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_193.vset/pc1318rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_193.vset/pc1318rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_193.vset/pc1319do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_193.vset/pc1319do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_193.vset/pc1320rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_193.vset/pc1320rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_193.vset/pc1321kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_193.vset/pc1321kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_193.vset/pc1322sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_193.vset/pc1322sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_193.vset/pc13a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_193.vset/pc13a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_201.vset/pc1401sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_201.vset/pc1401sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_201.vset/pc1402do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_201.vset/pc1402do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_201.vset/pc1403go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_201.vset/pc1403go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_201.vset/pc1404go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_201.vset/pc1404go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_201.vset/pc1405sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_201.vset/pc1405sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_201.vset/pc1406go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_201.vset/pc1406go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_201.vset/pc1407sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_201.vset/pc1407sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_201.vset/pc1408sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_201.vset/pc1408sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_201.vset/pc1409sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_201.vset/pc1409sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_202.vset/pc1410sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_202.vset/pc1410sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_202.vset/pc1411go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_202.vset/pc1411go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_202.vset/pc1412go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_202.vset/pc1412go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_202.vset/pc1413do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_202.vset/pc1413do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_202.vset/pc1414do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_202.vset/pc1414do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_202.vset/pc1415kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_202.vset/pc1415kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_202.vset/pc1416kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_202.vset/pc1416kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_202.vset/pc1417do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_202.vset/pc1417do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_202.vset/pc14a1go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_202.vset/pc14a1go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_202.vset/pc14a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_202.vset/pc14a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_203.vset/pc1418sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_203.vset/pc1418sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_203.vset/pc1419sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_203.vset/pc1419sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_203.vset/pc1420kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_203.vset/pc1420kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_203.vset/pc1421kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_203.vset/pc1421kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_204.vset/pc1422an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_204.vset/pc1422an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_204.vset/pc1423do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_204.vset/pc1423do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_204.vset/pc1424go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_204.vset/pc1424go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_204.vset/pc1425do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_204.vset/pc1425do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_204.vset/pc1426an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_204.vset/pc1426an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_204.vset/pc1427rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_204.vset/pc1427rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_204.vset/pc1428kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_204.vset/pc1428kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_204.vset/pc1429rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_204.vset/pc1429rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_204.vset/pc1430do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_204.vset/pc1430do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_204.vset/pc14a3an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_204.vset/pc14a3an.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_211.vset/pc1501go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_211.vset/pc1501go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_211.vset/pc1502do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_211.vset/pc1502do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_241.vset/pc1601do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_241.vset/pc1601do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_241.vset/pc1602kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_241.vset/pc1602kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_241.vset/pc1603kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_241.vset/pc1603kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_241.vset/pc1604go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_241.vset/pc1604go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_241.vset/pc1801kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_241.vset/pc1801kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_241.vset/pc1802kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_241.vset/pc1802kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_241.vset/pc1803do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_241.vset/pc1803do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_241.vset/pc1804go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_241.vset/pc1804go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_241.vset/pc1805sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_241.vset/pc1805sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_241.vset/pc1806kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_241.vset/pc1806kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_241.vset/pc1807do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_241.vset/pc1807do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_241.vset/pc1808go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_241.vset/pc1808go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_241.vset/pc18a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_241.vset/pc18a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_241.vset/pc18a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_241.vset/pc18a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_242.vset/pc1810be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_242.vset/pc1810be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_242.vset/pc1811sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_242.vset/pc1811sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_242.vset/pc1812be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_242.vset/pc1812be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_242.vset/pc1813sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_242.vset/pc1813sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_311.vset/pc2101be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_311.vset/pc2101be.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_321.vset/pc2201go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_321.vset/pc2201go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_321.vset/pc2202le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_321.vset/pc2202le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_331.vset/pc2201go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_331.vset/pc2201go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_331.vset/pc2202le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_331.vset/pc2202le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_341.vset/pc2203le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_341.vset/pc2203le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_341.vset/pc2204ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_341.vset/pc2204ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_341.vset/pc2205ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_341.vset/pc2205ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_341.vset/pc2206sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_341.vset/pc2206sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_341.vset/pc2207do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_341.vset/pc2207do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_341.vset/pc2208go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_341.vset/pc2208go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_341.vset/pc2209le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_341.vset/pc2209le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_371.vset/pc2301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_371.vset/pc2301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_371.vset/pc2302go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_371.vset/pc2302go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_371.vset/pc2303sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_371.vset/pc2303sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_371.vset/pc23a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_371.vset/pc23a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_371.vset/pc23a2sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_371.vset/pc23a2sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_371.vset/pc23a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_371.vset/pc23a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_381.vset/pc2304sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_381.vset/pc2304sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_381.vset/pc2305sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_381.vset/pc2305sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pc/pc_381.vset/pc23a5sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pc/pc_381.vset/pc23a5sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_001.vset/pi0201ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_001.vset/pi0201ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_001.vset/pi0202pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_001.vset/pi0202pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_001.vset/pi0203ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_001.vset/pi0203ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_001.vset/pi0204pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_001.vset/pi0204pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_001.vset/pi0205ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_001.vset/pi0205ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_002.vset/pi0701do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_002.vset/pi0701do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_002.vset/pi0702go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_002.vset/pi0702go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_002.vset/pi0703sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_002.vset/pi0703sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_002.vset/pi0704go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_002.vset/pi0704go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_002.vset/pi0705go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_002.vset/pi0705go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_002.vset/pi07a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_002.vset/pi07a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_003.vset/pi0706go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_003.vset/pi0706go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_003.vset/pi0707do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_003.vset/pi0707do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_003.vset/pi0708do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_003.vset/pi0708do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_003.vset/pi0709pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_003.vset/pi0709pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_003.vset/pi0710do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_003.vset/pi0710do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_003.vset/pi0711ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_003.vset/pi0711ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_003.vset/pi0712ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_003.vset/pi0712ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_003.vset/pi0713ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_003.vset/pi0713ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_004.vset/pi0801gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_004.vset/pi0801gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_004.vset/pi0802pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_004.vset/pi0802pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_004.vset/pi0803gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_004.vset/pi0803gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_004.vset/pi0804sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_004.vset/pi0804sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_004.vset/pi0805sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_004.vset/pi0805sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_004.vset/pi0806gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_004.vset/pi0806gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_004.vset/pi0807sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_004.vset/pi0807sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_005.vset/pi0808gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_005.vset/pi0808gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_005.vset/pi0809gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_005.vset/pi0809gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_005.vset/pi0810gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_005.vset/pi0810gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_005.vset/pi0811gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_005.vset/pi0811gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_006.vset/pi1001sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_006.vset/pi1001sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_006.vset/pi1002go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_006.vset/pi1002go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_006.vset/pi1003sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_006.vset/pi1003sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_007.vset/pi1004rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_007.vset/pi1004rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_007.vset/pi1005rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_007.vset/pi1005rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_007.vset/pi1006sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_007.vset/pi1006sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_007.vset/pi1008rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_007.vset/pi1008rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_007.vset/pi1009sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_007.vset/pi1009sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_007.vset/pi1010rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_007.vset/pi1010rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_007.vset/pi1011sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_007.vset/pi1011sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_008.vset/pi1001sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_008.vset/pi1001sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_008.vset/pi1002go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_008.vset/pi1002go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_008.vset/pi1003sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_008.vset/pi1003sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_008.vset/pi1004rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_008.vset/pi1004rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_008.vset/pi1005rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_008.vset/pi1005rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_008.vset/pi1007sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_008.vset/pi1007sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_009.vset/pi1201ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_009.vset/pi1201ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_009.vset/pi1202ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_009.vset/pi1202ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_009.vset/pi1203rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_009.vset/pi1203rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_009.vset/pi1204ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_009.vset/pi1204ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_009.vset/pi1205ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_009.vset/pi1205ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_009.vset/pi1206rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_009.vset/pi1206rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_010.vset/pi1301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_010.vset/pi1301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_010.vset/pi1302sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_010.vset/pi1302sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_010.vset/pi1303rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_010.vset/pi1303rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_010.vset/pi1304rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_010.vset/pi1304rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_010.vset/pi1305rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_010.vset/pi1305rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_010.vset/pi1306sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_010.vset/pi1306sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_010.vset/pi1307pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_010.vset/pi1307pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_011.vset/pi1401rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_011.vset/pi1401rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_011.vset/pi1402sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_011.vset/pi1402sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_011.vset/pi1403rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_011.vset/pi1403rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_012.vset/pi1601gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_012.vset/pi1601gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_012.vset/pi1602gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_012.vset/pi1602gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_012.vset/pi1603rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_012.vset/pi1603rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_012.vset/pi1604gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_012.vset/pi1604gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_013.vset/pi1605rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_013.vset/pi1605rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_013.vset/pi1606rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_013.vset/pi1606rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_013.vset/pi1607sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_013.vset/pi1607sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_013.vset/pi1608rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_013.vset/pi1608rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_014.vset/pi1601gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_014.vset/pi1601gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_014.vset/pi1602gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_014.vset/pi1602gp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_015.vset/pi1701sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_015.vset/pi1701sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_015.vset/pi1702rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_015.vset/pi1702rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_015.vset/pi1703rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_015.vset/pi1703rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_015.vset/pi1705rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_015.vset/pi1705rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_016.vset/pi1706sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_016.vset/pi1706sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_016.vset/pi1707rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_016.vset/pi1707rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_016.vset/pi1708sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_016.vset/pi1708sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_016.vset/pi1709sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_016.vset/pi1709sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_016.vset/pi1710rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_016.vset/pi1710rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_017.vset/pi1711ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_017.vset/pi1711ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_017.vset/pi1713pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_017.vset/pi1713pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_017.vset/pi1714pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_017.vset/pi1714pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_017.vset/pi1715rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_017.vset/pi1715rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_017.vset/pi17a1ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_017.vset/pi17a1ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_017.vset/pi1801do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_017.vset/pi1801do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_017.vset/pi1802sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_017.vset/pi1802sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_018.vset/pi1716sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_018.vset/pi1716sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_018.vset/pi1717rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_018.vset/pi1717rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_018.vset/pi1718sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_018.vset/pi1718sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_019.vset/pi17a1ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_019.vset/pi17a1ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_019.vset/pi1711ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_019.vset/pi1711ji.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_019.vset/pi1712pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_019.vset/pi1712pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_019.vset/pi1713pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_019.vset/pi1713pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_019.vset/pi1714pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_019.vset/pi1714pc.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_019.vset/pi1801do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_019.vset/pi1801do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_020.vset/pp0001rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_020.vset/pp0001rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_020.vset/pp0002ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_020.vset/pp0002ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_020.vset/pp0003rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_020.vset/pp0003rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_020.vset/pp0004ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_020.vset/pp0004ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_020.vset/pp0005rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_020.vset/pp0005rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_020.vset/pp0006ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_020.vset/pp0006ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_020.vset/pp0007ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_020.vset/pp0007ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_020.vset/pp0008ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_020.vset/pp0008ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_021.vset/pp0009ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_021.vset/pp0009ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_021.vset/pp0010ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_021.vset/pp0010ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_021.vset/pp0011ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_021.vset/pp0011ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pi/pi_021.vset/pp0012rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pi/pi_021.vset/pp0012rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_001.vset/po0101po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_001.vset/po0101po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_001.vset/po0201sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_001.vset/po0201sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_001.vset/po0202po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_001.vset/po0202po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_001.vset/po0203sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_001.vset/po0203sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_001.vset/po0204po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_001.vset/po0204po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_001.vset/po0205sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_001.vset/po0205sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_001.vset/po0206po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_001.vset/po0206po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_001.vset/po0207sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_001.vset/po0207sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_001.vset/po0208po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_001.vset/po0208po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_002.vset/po0209sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_002.vset/po0209sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_002.vset/po0210po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_002.vset/po0210po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_002.vset/po0211sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_002.vset/po0211sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_002.vset/po0212po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_002.vset/po0212po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_002.vset/po0213sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_002.vset/po0213sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_002.vset/po0214po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_002.vset/po0214po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_002.vset/po0215po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_002.vset/po0215po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_003.vset/po0216po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_003.vset/po0216po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_003.vset/po0217po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_003.vset/po0217po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_003.vset/po0218po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_003.vset/po0218po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_003.vset/po0219po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_003.vset/po0219po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_003.vset/po0220po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_003.vset/po0220po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_003.vset/po0221po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_003.vset/po0221po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_003.vset/po0222po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_003.vset/po0222po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_004.vset/po0301po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_004.vset/po0301po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_004.vset/po0302po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_004.vset/po0302po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_005.vset/po0401pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_005.vset/po0401pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_005.vset/po0402pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_005.vset/po0402pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_005.vset/po0403pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_005.vset/po0403pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_005.vset/po0404pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_005.vset/po0404pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_006.vset/po0501pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_006.vset/po0501pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_006.vset/po0502sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_006.vset/po0502sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_006.vset/po0503pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_006.vset/po0503pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_006.vset/po0504pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_006.vset/po0504pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_006.vset/po0505po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_006.vset/po0505po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_006.vset/po0506pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_006.vset/po0506pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_007.vset/po0507po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_007.vset/po0507po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_007.vset/po0508pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_007.vset/po0508pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_007.vset/po0509pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_007.vset/po0509pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_007.vset/po0510po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_007.vset/po0510po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_007.vset/po0511pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_007.vset/po0511pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_007.vset/po0512po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_007.vset/po0512po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_007.vset/po0513pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_007.vset/po0513pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_007.vset/po0514po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_007.vset/po0514po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_008.vset/po0601po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_008.vset/po0601po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_008.vset/po0602po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_008.vset/po0602po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_008.vset/po0603po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_008.vset/po0603po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_009.vset/po0701ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_009.vset/po0701ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_009.vset/po0702ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_009.vset/po0702ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_009.vset/po0703po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_009.vset/po0703po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_009.vset/po0704ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_009.vset/po0704ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_009.vset/po0705ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_009.vset/po0705ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_010.vset/po0706sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_010.vset/po0706sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_010.vset/po0707ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_010.vset/po0707ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_010.vset/po0708ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_010.vset/po0708ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_010.vset/po0709ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_010.vset/po0709ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_011.vset/po0801ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_011.vset/po0801ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_011.vset/po0802ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_011.vset/po0802ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_011.vset/po0803ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_011.vset/po0803ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_012.vset/po0901po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_012.vset/po0901po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_012.vset/po0902po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_012.vset/po0902po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_013.vset/po1001pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_013.vset/po1001pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_013.vset/po1002pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_013.vset/po1002pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_013.vset/po1003ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_013.vset/po1003ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_013.vset/po1004pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_013.vset/po1004pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_013.vset/po1005ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_013.vset/po1005ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_013.vset/po1006ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_013.vset/po1006ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_014.vset/po1007po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_014.vset/po1007po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_014.vset/po1008sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_014.vset/po1008sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_014.vset/po1009po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_014.vset/po1009po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_014.vset/po1010sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_014.vset/po1010sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_014.vset/po1011pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_014.vset/po1011pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_014.vset/po1012sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_014.vset/po1012sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_014.vset/po1013ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_014.vset/po1013ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_014.vset/po1014pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_014.vset/po1014pi.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_014.vset/po1015po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_014.vset/po1015po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_015.vset/po1102ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_015.vset/po1102ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_016.vset/po1101po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_016.vset/po1101po.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_016.vset/po1102ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_016.vset/po1102ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_016.vset/po1103ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_016.vset/po1103ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_016.vset/po1104ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_016.vset/po1104ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_016.vset/po1105ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_016.vset/po1105ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/po/po_016.vset/po1106ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/po/po_016.vset/po1106ti.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_000.vset/pp0008ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_000.vset/pp0008ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_000.vset/pp0009ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_000.vset/pp0009ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_000.vset/pp0010ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_000.vset/pp0010ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_000.vset/pp0011ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_000.vset/pp0011ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_000.vset/pp0012rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_000.vset/pp0012rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_001.vset/pp0001rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_001.vset/pp0001rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_001.vset/pp0002ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_001.vset/pp0002ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_001.vset/pp0003rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_001.vset/pp0003rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_001.vset/pp0004ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_001.vset/pp0004ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_001.vset/pp0005rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_001.vset/pp0005rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_001.vset/pp0006ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_001.vset/pp0006ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_001.vset/pp0007ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_001.vset/pp0007ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_099.vset/pp2001we.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_099.vset/pp2001we.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_099.vset/pp2002pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_099.vset/pp2002pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_099.vset/pp2003do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_099.vset/pp2003do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_099.vset/pp2004pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_099.vset/pp2004pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_099.vset/pp2005pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_099.vset/pp2005pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_099.vset/pp2006sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_099.vset/pp2006sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_103.vset/pp0301do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_103.vset/pp0301do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_103.vset/pp0302rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_103.vset/pp0302rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_103.vset/pp0303sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_103.vset/pp0303sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_103.vset/pp0304rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_103.vset/pp0304rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_103.vset/pp0305sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_103.vset/pp0305sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_103.vset/pp0306rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_103.vset/pp0306rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_103.vset/pp0307rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_103.vset/pp0307rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_103.vset/pp03a1go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_103.vset/pp03a1go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_104.vset/pp0308sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_104.vset/pp0308sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_104.vset/pp0309rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_104.vset/pp0309rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_104.vset/pp0310ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_104.vset/pp0310ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_104.vset/pp0311sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_104.vset/pp0311sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_104.vset/pp0312rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_104.vset/pp0312rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_104.vset/pp0313sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_104.vset/pp0313sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_104.vset/pp0314rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_104.vset/pp0314rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_104.vset/pp0326sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_104.vset/pp0326sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_105.vset/pp0315rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_105.vset/pp0315rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_105.vset/pp0316sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_105.vset/pp0316sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_105.vset/pp0317rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_105.vset/pp0317rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_105.vset/pp0318rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_105.vset/pp0318rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_105.vset/pp03a2sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_105.vset/pp03a2sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_106.vset/pp0319ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_106.vset/pp0319ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_106.vset/pp0320se.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_106.vset/pp0320se.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_106.vset/pp0321ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_106.vset/pp0321ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_106.vset/pp0322se.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_106.vset/pp0322se.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_106.vset/pp0323ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_106.vset/pp0323ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_106.vset/pp0324se.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_106.vset/pp0324se.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_106.vset/pp0325ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_106.vset/pp0325ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_107.vset/pp0401go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_107.vset/pp0401go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_107.vset/pp0402sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_107.vset/pp0402sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_107.vset/pp0403go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_107.vset/pp0403go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_107.vset/pp0404sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_107.vset/pp0404sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_107.vset/pp0405do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_107.vset/pp0405do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_107.vset/pp0406sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_107.vset/pp0406sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_108.vset/pp0501pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_108.vset/pp0501pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_108.vset/pp0502pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_108.vset/pp0502pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_108.vset/pp0503go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_108.vset/pp0503go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_108.vset/pp0504pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_108.vset/pp0504pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_108.vset/pp0505do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_108.vset/pp0505do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_108.vset/pp0506pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_108.vset/pp0506pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_108.vset/pp0507sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_108.vset/pp0507sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_108.vset/pp0508pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_108.vset/pp0508pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_108.vset/pp0509sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_108.vset/pp0509sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_108.vset/pp0510pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_108.vset/pp0510pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_109.vset/pp0511pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_109.vset/pp0511pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_109.vset/pp0512pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_109.vset/pp0512pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_109.vset/pp0513pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_109.vset/pp0513pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_109.vset/pp0514do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_109.vset/pp0514do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_109.vset/pp0515pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_109.vset/pp0515pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_109.vset/pp0516sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_109.vset/pp0516sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_109.vset/pp0517pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_109.vset/pp0517pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_109.vset/pp0518sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_109.vset/pp0518sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_109.vset/pp0519pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_109.vset/pp0519pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_109.vset/pp05a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_109.vset/pp05a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_110.vset/pp0601go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_110.vset/pp0601go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_110.vset/pp0602pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_110.vset/pp0602pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_110.vset/pp0603pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_110.vset/pp0603pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_110.vset/pp0604pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_110.vset/pp0604pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_110.vset/pp0605pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_110.vset/pp0605pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_110.vset/pp06a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_110.vset/pp06a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_111.vset/pp0701ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_111.vset/pp0701ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_111.vset/pp0702rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_111.vset/pp0702rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_111.vset/pp0703rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_111.vset/pp0703rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_111.vset/pp0704ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_111.vset/pp0704ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_111.vset/pp0705ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_111.vset/pp0705ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_111.vset/pp0706rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_111.vset/pp0706rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_112.vset/pp0707rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_112.vset/pp0707rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_112.vset/pp0708ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_112.vset/pp0708ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_112.vset/pp0709ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_112.vset/pp0709ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_112.vset/pp0710rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_112.vset/pp0710rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_112.vset/pp0711se.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_112.vset/pp0711se.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_112.vset/pp0712ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_112.vset/pp0712ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_112.vset/pp0713se.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_112.vset/pp0713se.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_112.vset/pp0714ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_112.vset/pp0714ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_112.vset/pp0715ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_112.vset/pp0715ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_113.vset/pp0801pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_113.vset/pp0801pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_113.vset/pp0802we.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_113.vset/pp0802we.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_113.vset/pp0803pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_113.vset/pp0803pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_113.vset/pp0804we.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_113.vset/pp0804we.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_113.vset/pp0805pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_113.vset/pp0805pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_114.vset/pp0806sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_114.vset/pp0806sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_114.vset/pp0807we.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_114.vset/pp0807we.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_114.vset/pp0808sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_114.vset/pp0808sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_114.vset/pp0809we.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_114.vset/pp0809we.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_114.vset/pp0810sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_114.vset/pp0810sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_114.vset/pp0811we.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_114.vset/pp0811we.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_114.vset/pp0812pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_114.vset/pp0812pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_114.vset/pp08a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_114.vset/pp08a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_114.vset/pp08a2sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_114.vset/pp08a2sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_114.vset/pp08a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_114.vset/pp08a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_115.vset/pp0901pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_115.vset/pp0901pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_116.vset/pp1001sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_116.vset/pp1001sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_117.vset/pp1301pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_117.vset/pp1301pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_117.vset/pp1302pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_117.vset/pp1302pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_117.vset/pp1303pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_117.vset/pp1303pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_118.vset/pp1401ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_118.vset/pp1401ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_118.vset/pp1402sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_118.vset/pp1402sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_118.vset/pp1403ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_118.vset/pp1403ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_118.vset/pp1404ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_118.vset/pp1404ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_118.vset/pp1405ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_118.vset/pp1405ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_118.vset/pp1406sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_118.vset/pp1406sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_118.vset/pp14a4sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_118.vset/pp14a4sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_119.vset/pp1407ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_119.vset/pp1407ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_119.vset/pp1408ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_119.vset/pp1408ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_119.vset/pp1409ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_119.vset/pp1409ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_119.vset/pp1410ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_119.vset/pp1410ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_119.vset/pp1411ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_119.vset/pp1411ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_120.vset/pp1412pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_120.vset/pp1412pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_120.vset/pp1413sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_120.vset/pp1413sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_120.vset/pp1414pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_120.vset/pp1414pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_120.vset/pp14a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_120.vset/pp14a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_120.vset/pp14a2do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_120.vset/pp14a2do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_120.vset/pp14a3go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_120.vset/pp14a3go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_121.vset/pp1601ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_121.vset/pp1601ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_121.vset/pp1602pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_121.vset/pp1602pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_121.vset/pp1603ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_121.vset/pp1603ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_121.vset/pp1604pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_121.vset/pp1604pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_121.vset/pp16a1ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_121.vset/pp16a1ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_122.vset/pp1701go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_122.vset/pp1701go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_122.vset/pp1702do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_122.vset/pp1702do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_122.vset/pp1703go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_122.vset/pp1703go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_122.vset/pp1704pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_122.vset/pp1704pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_122.vset/pp1705sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_122.vset/pp1705sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_122.vset/pp1706sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_122.vset/pp1706sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_123.vset/pp1707pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_123.vset/pp1707pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_123.vset/pp1708sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_123.vset/pp1708sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_123.vset/pp1709sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_123.vset/pp1709sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/pp/pp_123.vset/pp1710pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/pp/pp_123.vset/pp1710pp.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_006.vset/tw0602le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_006.vset/tw0602le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_006.vset/tw0603sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_006.vset/tw0603sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_006.vset/tw0604le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_006.vset/tw0604le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_006.vset/tw0605le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_006.vset/tw0605le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_006.vset/tw0606sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_006.vset/tw0606sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_006.vset/tw0607le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_006.vset/tw0607le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_006.vset/tw0608sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_006.vset/tw0608sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_006.vset/tw0609le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_006.vset/tw0609le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_007.vset/tw0701sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_007.vset/tw0701sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_007.vset/tw0702ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_007.vset/tw0702ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_007.vset/tw0703le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_007.vset/tw0703le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_007.vset/tw0704le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_007.vset/tw0704le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_007.vset/tw0705ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_007.vset/tw0705ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_007.vset/tw0706le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_007.vset/tw0706le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_007.vset/tw0707le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_007.vset/tw0707le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_007.vset/tw07a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_007.vset/tw07a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_008.vset/tw0801go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_008.vset/tw0801go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_008.vset/tw0802do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_008.vset/tw0802do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_008.vset/tw0803do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_008.vset/tw0803do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_008.vset/tw0804ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_008.vset/tw0804ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_009.vset/tw0901kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_009.vset/tw0901kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_009.vset/tw0902kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_009.vset/tw0902kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_009.vset/tw0903sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_009.vset/tw0903sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_009.vset/tw0904kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_009.vset/tw0904kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_009.vset/tw0905kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_009.vset/tw0905kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_009.vset/tw0906sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_009.vset/tw0906sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_009.vset/tw0907kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_009.vset/tw0907kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_009.vset/tw0908sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_009.vset/tw0908sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_009.vset/tw09a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_009.vset/tw09a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_010.vset/tw0909ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_010.vset/tw0909ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_010.vset/tw0910le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_010.vset/tw0910le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_010.vset/tw0911sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_010.vset/tw0911sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_010.vset/tw0912ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_010.vset/tw0912ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_010.vset/tw0913le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_010.vset/tw0913le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_010.vset/tw0914le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_010.vset/tw0914le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_010.vset/tw0915le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_010.vset/tw0915le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_010.vset/tw0916sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_010.vset/tw0916sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_010.vset/tw09a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_010.vset/tw09a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_011.vset/tw0917ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_011.vset/tw0917ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_011.vset/tw0918do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_011.vset/tw0918do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_011.vset/tw0919go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_011.vset/tw0919go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_011.vset/tw0920ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_011.vset/tw0920ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_011.vset/tw0921ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_011.vset/tw0921ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_012.vset/tw0922sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_012.vset/tw0922sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_012.vset/tw0923ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_012.vset/tw0923ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_012.vset/tw0924le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_012.vset/tw0924le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_012.vset/tw0925ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_012.vset/tw0925ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_012.vset/tw0926le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_012.vset/tw0926le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_012.vset/tw0927ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_012.vset/tw0927ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_013.vset/tw0928go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_013.vset/tw0928go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_013.vset/tw0929ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_013.vset/tw0929ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_013.vset/tw0930ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_013.vset/tw0930ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_013.vset/tw0931go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_013.vset/tw0931go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_013.vset/tw0932ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_013.vset/tw0932ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_013.vset/tw0933do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_013.vset/tw0933do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_013.vset/tw0934ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_013.vset/tw0934ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_013.vset/tw0935go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_013.vset/tw0935go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_013.vset/tw0936ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_013.vset/tw0936ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_013.vset/tw0937go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_013.vset/tw0937go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_013.vset/tw0938do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_013.vset/tw0938do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_013.vset/tw0939do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_013.vset/tw0939do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_013.vset/tw0940ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_013.vset/tw0940ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_014.vset/tw0941sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_014.vset/tw0941sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_014.vset/tw0942ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_014.vset/tw0942ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_014.vset/tw0943le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_014.vset/tw0943le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_014.vset/tw0944le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_014.vset/tw0944le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_014.vset/tw0945sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_014.vset/tw0945sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_014.vset/tw0946ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_014.vset/tw0946ry.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_014.vset/tw0947le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_014.vset/tw0947le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_014.vset/tw0948sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_014.vset/tw0948sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_014.vset/tw0949sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_014.vset/tw0949sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_014.vset/tw0950sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_014.vset/tw0950sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_014.vset/tw0951le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_014.vset/tw0951le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_014.vset/tw09a2sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_014.vset/tw09a2sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_015.vset/tw1001le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_015.vset/tw1001le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_015.vset/tw1002ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_015.vset/tw1002ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_015.vset/tw1003le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_015.vset/tw1003le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_015.vset/tw10a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_015.vset/tw10a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_016.vset/tw1201go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_016.vset/tw1201go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_016.vset/tw1202do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_016.vset/tw1202do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_016.vset/tw1203do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_016.vset/tw1203do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_016.vset/tw1204go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_016.vset/tw1204go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_016.vset/tw12a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_016.vset/tw12a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_016.vset/tw12a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_016.vset/tw12a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_016.vset/tw12a3do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_016.vset/tw12a3do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_016.vset/tw12a6go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_016.vset/tw12a6go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_016.vset/tw12a7go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_016.vset/tw12a7go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_016.vset/tw12b1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_016.vset/tw12b1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_016.vset/tw12b4go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_016.vset/tw12b4go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_017.vset/tw12a0do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_017.vset/tw12a0do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_017.vset/tw12a9go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_017.vset/tw12a9go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_018.vset/tw1301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_018.vset/tw1301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_018.vset/tw1302le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_018.vset/tw1302le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_018.vset/tw1303go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_018.vset/tw1303go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_018.vset/tw1304sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_018.vset/tw1304sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_018.vset/tw1305do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_018.vset/tw1305do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_018.vset/tw1306go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_018.vset/tw1306go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_018.vset/tw1307do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_018.vset/tw1307do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_018.vset/tw1309le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_018.vset/tw1309le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_018.vset/tw1310sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_018.vset/tw1310sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_018.vset/tw13a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_018.vset/tw13a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_018.vset/tw13a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_018.vset/tw13a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_019.vset/tw1311do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_019.vset/tw1311do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_019.vset/tw1312go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_019.vset/tw1312go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_019.vset/tw1313do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_019.vset/tw1313do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_019.vset/tw1314go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_019.vset/tw1314go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_019.vset/tw1315do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_019.vset/tw1315do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_019.vset/tw1316sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_019.vset/tw1316sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_020.vset/tw1317sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_020.vset/tw1317sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_020.vset/tw1318go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_020.vset/tw1318go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_020.vset/tw1319sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_020.vset/tw1319sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_020.vset/tw1320do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_020.vset/tw1320do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_020.vset/tw1321go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_020.vset/tw1321go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_020.vset/tw1322sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_020.vset/tw1322sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_020.vset/tw1323go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_020.vset/tw1323go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_020.vset/tw13a3do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_020.vset/tw13a3do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_020.vset/tw13a4do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_020.vset/tw13a4do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_020.vset/tw13b3do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_020.vset/tw13b3do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_030.vset/t20101kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_030.vset/t20101kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_030.vset/t20102kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_030.vset/t20102kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_030.vset/t20103kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_030.vset/t20103kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_030.vset/t20104sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_030.vset/t20104sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_030.vset/t20105go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_030.vset/t20105go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_031.vset/t20201rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_031.vset/t20201rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_031.vset/t20202sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_031.vset/t20202sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_031.vset/t20203rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_031.vset/t20203rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_031.vset/t20204sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_031.vset/t20204sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_031.vset/t20205rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_031.vset/t20205rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_031.vset/t20206sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_031.vset/t20206sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_031.vset/t20207sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_031.vset/t20207sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_031.vset/t20208rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_031.vset/t20208rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_032.vset/t20209rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_032.vset/t20209rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_032.vset/t20211rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_032.vset/t20211rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_032.vset/t20212rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_032.vset/t20212rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_032.vset/t20213rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_032.vset/t20213rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_032.vset/t20214sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_032.vset/t20214sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_032.vset/t20215rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_032.vset/t20215rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_032.vset/t20216sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_032.vset/t20216sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_032.vset/t20217rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_032.vset/t20217rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_033.vset/t20218do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_033.vset/t20218do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_033.vset/t20219sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_033.vset/t20219sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_033.vset/t20220rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_033.vset/t20220rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_033.vset/t20221go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_033.vset/t20221go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_033.vset/t20222do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_033.vset/t20222do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_033.vset/t20223sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_033.vset/t20223sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_034.vset/t20224rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_034.vset/t20224rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_034.vset/t20225sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_034.vset/t20225sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_034.vset/t20226rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_034.vset/t20226rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_034.vset/t20227sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_034.vset/t20227sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_034.vset/t20228sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_034.vset/t20228sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_034.vset/t20229do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_034.vset/t20229do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_034.vset/t20230sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_034.vset/t20230sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_034.vset/t20231do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_034.vset/t20231do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_034.vset/t20232sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_034.vset/t20232sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_034.vset/t202a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_034.vset/t202a1do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_035.vset/t20233go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_035.vset/t20233go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_035.vset/t20234sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_035.vset/t20234sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_035.vset/t20235sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_035.vset/t20235sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_035.vset/t20236sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_035.vset/t20236sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_040.vset/t20301ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_040.vset/t20301ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_040.vset/t20302ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_040.vset/t20302ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_040.vset/t20303ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_040.vset/t20303ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_040.vset/t20304ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_040.vset/t20304ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_040.vset/t20305ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_040.vset/t20305ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_050.vset/pc1901le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_050.vset/pc1901le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_050.vset/pc1902le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_050.vset/pc1902le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_050.vset/pc1903ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_050.vset/pc1903ea.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_050.vset/pc1904sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_050.vset/pc1904sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_050.vset/pc1905le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_050.vset/pc1905le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_050.vset/pc1906sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_050.vset/pc1906sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_051.vset/pc2001kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_051.vset/pc2001kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_051.vset/pc2002sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_051.vset/pc2002sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_051.vset/pc2003kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_051.vset/pc2003kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_051.vset/pc2004sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_051.vset/pc2004sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_051.vset/pc2005sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_051.vset/pc2005sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_051.vset/pc2006sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_051.vset/pc2006sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_051.vset/pc2007sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_051.vset/pc2007sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_052.vset/pc2008kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_052.vset/pc2008kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_052.vset/pc2009sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_052.vset/pc2009sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_052.vset/pc2010sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_052.vset/pc2010sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_052.vset/pc2011sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_052.vset/pc2011sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_052.vset/pc2012kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_052.vset/pc2012kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_052.vset/pc2013sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_052.vset/pc2013sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_053.vset/pc2014sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_053.vset/pc2014sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_053.vset/pc2015sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_053.vset/pc2015sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_053.vset/pc2016sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_053.vset/pc2016sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_053.vset/pc2017kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_053.vset/pc2017kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_053.vset/pc2018sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_053.vset/pc2018sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_053.vset/pc2019kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_053.vset/pc2019kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_053.vset/pc2020sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_053.vset/pc2020sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_054.vset/pc2021kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_054.vset/pc2021kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_054.vset/pc2022sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_054.vset/pc2022sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_054.vset/pc2023kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_054.vset/pc2023kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_054.vset/pc2024sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_054.vset/pc2024sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_054.vset/pc2025kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_054.vset/pc2025kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_054.vset/pc2026kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_054.vset/pc2026kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_055.vset/pc2027kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_055.vset/pc2027kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_055.vset/pc2028kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_055.vset/pc2028kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_055.vset/pc2029sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_055.vset/pc2029sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_055.vset/pc2030kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_055.vset/pc2030kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_055.vset/pc2031sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_055.vset/pc2031sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_055.vset/pc2032kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_055.vset/pc2032kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_060.vset/pc0201do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_060.vset/pc0201do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_060.vset/pc0202go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_060.vset/pc0202go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_060.vset/pc0203sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_060.vset/pc0203sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_060.vset/pc0204do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_060.vset/pc0204do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_060.vset/pc0205go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_060.vset/pc0205go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_060.vset/pc0206sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_060.vset/pc0206sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_060.vset/pc0207kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_060.vset/pc0207kr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_061.vset/pc0301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_061.vset/pc0301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_061.vset/pc0302go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_061.vset/pc0302go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_061.vset/pc0303sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_061.vset/pc0303sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_061.vset/pc0304sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_061.vset/pc0304sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_071.vset/pc1907le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_071.vset/pc1907le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_071.vset/pc1908le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_071.vset/pc1908le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_071.vset/pc1909le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_071.vset/pc1909le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_071.vset/pc1910le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_071.vset/pc1910le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_071.vset/pc1911le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_071.vset/pc1911le.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_090.vset/tw1401ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_090.vset/tw1401ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_090.vset/tw1402ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_090.vset/tw1402ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_090.vset/tw1403ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_090.vset/tw1403ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_090.vset/tw1404ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_090.vset/tw1404ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_090.vset/tw1405bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_090.vset/tw1405bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_090.vset/tw1406ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_090.vset/tw1406ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_090.vset/tw1407ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_090.vset/tw1407ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_091.vset/tw1408ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_091.vset/tw1408ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_091.vset/tw1409ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_091.vset/tw1409ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tw/tw_091.vset/tw1410ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tw/tw_091.vset/tw1410ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_001.vset/tz1101tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_001.vset/tz1101tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_001.vset/tz1102tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_001.vset/tz1102tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_001.vset/tz1103tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_001.vset/tz1103tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_001.vset/tz1104go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_001.vset/tz1104go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_001.vset/tz1105do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_001.vset/tz1105do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_001.vset/tz1106tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_001.vset/tz1106tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_001.vset/tz1107tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_001.vset/tz1107tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_002.vset/tz0401go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_002.vset/tz0401go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_002.vset/tz0402go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_002.vset/tz0402go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_002.vset/tz0403do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_002.vset/tz0403do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_002.vset/tz0404do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_002.vset/tz0404do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_002.vset/tz04a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_002.vset/tz04a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_002.vset/tz04a3do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_002.vset/tz04a3do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_003.vset/tz1201do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_003.vset/tz1201do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_003.vset/tz1202do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_003.vset/tz1202do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_003.vset/tz1203tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_003.vset/tz1203tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_003.vset/tz1204cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_003.vset/tz1204cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_003.vset/tz1205cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_003.vset/tz1205cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_004.vset/tz1301je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_004.vset/tz1301je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_004.vset/tz1302cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_004.vset/tz1302cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_004.vset/tz1303je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_004.vset/tz1303je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_004.vset/tz1304cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_004.vset/tz1304cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_004.vset/tz13a1cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_004.vset/tz13a1cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_004.vset/tz13a2cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_004.vset/tz13a2cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_005.vset/tz1305cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_005.vset/tz1305cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_005.vset/tz1306cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_005.vset/tz1306cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_005.vset/tz1307cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_005.vset/tz1307cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_005.vset/tz13a3cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_005.vset/tz13a3cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_005.vset/tz13a4cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_005.vset/tz13a4cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_006.vset/tz0101sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_006.vset/tz0101sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_006.vset/tz0102sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_006.vset/tz0102sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_006.vset/tz01a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_006.vset/tz01a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_006.vset/tz01a2sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_006.vset/tz01a2sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_006.vset/tz01a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_006.vset/tz01a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_007.vset/tz0301tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_007.vset/tz0301tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_007.vset/tz0302sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_007.vset/tz0302sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_007.vset/tz0303tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_007.vset/tz0303tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_007.vset/tz0304sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_007.vset/tz0304sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_007.vset/tz0305tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_007.vset/tz0305tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_007.vset/tz0306sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_007.vset/tz0306sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_008.vset/tz0307sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_008.vset/tz0307sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_008.vset/tz0308tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_008.vset/tz0308tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_008.vset/tz0309sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_008.vset/tz0309sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_008.vset/tz0310tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_008.vset/tz0310tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_008.vset/tz0311sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_008.vset/tz0311sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_009.vset/tz0312tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_009.vset/tz0312tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_009.vset/tz0313sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_009.vset/tz0313sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_009.vset/tz0314sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_009.vset/tz0314sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_009.vset/tz0315tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_009.vset/tz0315tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_009.vset/tz0316sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_009.vset/tz0316sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_010.vset/tz0317tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_010.vset/tz0317tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_010.vset/tz0318sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_010.vset/tz0318sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_010.vset/tz0319sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_010.vset/tz0319sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_010.vset/tz0320tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_010.vset/tz0320tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_010.vset/tz0321sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_010.vset/tz0321sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_010.vset/tz0322tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_010.vset/tz0322tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_010.vset/tz0323sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_010.vset/tz0323sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_010.vset/tz0324tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_010.vset/tz0324tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_011.vset/tz0325sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_011.vset/tz0325sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_011.vset/tz0326tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_011.vset/tz0326tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_011.vset/tz0327tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_011.vset/tz0327tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_011.vset/tz0328sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_011.vset/tz0328sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_011.vset/tz0329sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_011.vset/tz0329sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_012.vset/tz0501tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_012.vset/tz0501tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_012.vset/tz0502je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_012.vset/tz0502je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_012.vset/tz0503sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_012.vset/tz0503sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_012.vset/tz0504je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_012.vset/tz0504je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_012.vset/tz0505je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_012.vset/tz0505je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_012.vset/tz0506cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_012.vset/tz0506cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_012.vset/tz0507go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_012.vset/tz0507go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_012.vset/tz0508sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_012.vset/tz0508sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_012.vset/tz05a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_012.vset/tz05a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_012.vset/tz05a2do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_012.vset/tz05a2do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_013.vset/tz0509cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_013.vset/tz0509cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_013.vset/tz0510je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_013.vset/tz0510je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_013.vset/tz0511je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_013.vset/tz0511je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_014.vset/tz0512sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_014.vset/tz0512sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_014.vset/tz0513sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_014.vset/tz0513sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_014.vset/tz0514do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_014.vset/tz0514do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_014.vset/tz0515sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_014.vset/tz0515sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_014.vset/tz0516go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_014.vset/tz0516go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_015.vset/tz1001je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_015.vset/tz1001je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_015.vset/tz1003sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_015.vset/tz1003sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_015.vset/tz1005sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_015.vset/tz1005sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_015.vset/tz1006cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_015.vset/tz1006cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_015.vset/tz1007cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_015.vset/tz1007cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_015.vset/tz1008cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_015.vset/tz1008cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_015.vset/tz1009cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_015.vset/tz1009cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_015.vset/tz1010je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_015.vset/tz1010je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_015.vset/tz1011cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_015.vset/tz1011cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_016.vset/tz1012je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_016.vset/tz1012je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_016.vset/tz1013tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_016.vset/tz1013tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_016.vset/tz1014je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_016.vset/tz1014je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_016.vset/tz1015cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_016.vset/tz1015cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_016.vset/tz1016cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_016.vset/tz1016cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_017.vset/tz1401sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_017.vset/tz1401sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_018.vset/tz17a1je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_018.vset/tz17a1je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_018.vset/tz17a2je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_018.vset/tz17a2je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_019.vset/tz1801je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_019.vset/tz1801je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_020.vset/tz1901sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_020.vset/tz1901sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_020.vset/tz1902sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_020.vset/tz1902sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_020.vset/tz1903tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_020.vset/tz1903tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_021.vset/tz20a1cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_021.vset/tz20a1cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_021.vset/tz20a2cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_021.vset/tz20a2cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_021.vset/tz20a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_021.vset/tz20a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_022.vset/tz2101cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_022.vset/tz2101cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_022.vset/tz21a1cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_022.vset/tz21a1cl.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_023.vset/tz2102tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_023.vset/tz2102tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_023.vset/tz21a2sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_023.vset/tz21a2sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_023.vset/tz21a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_023.vset/tz21a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_023.vset/tz21a4sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_023.vset/tz21a4sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_023.vset/tz21a5do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_023.vset/tz21a5do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_023.vset/tz21a6go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_023.vset/tz21a6go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_024.vset/tz2301tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_024.vset/tz2301tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_024.vset/tz2302sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_024.vset/tz2302sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_024.vset/tz2303go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_024.vset/tz2303go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_024.vset/tz2304je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_024.vset/tz2304je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_024.vset/tz2305tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_024.vset/tz2305tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_024.vset/tz2306je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_024.vset/tz2306je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_024.vset/tz2307tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_024.vset/tz2307tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_024.vset/tz2308sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_024.vset/tz2308sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_024.vset/tz23a1go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_024.vset/tz23a1go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_024.vset/tz23a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_024.vset/tz23a3sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_025.vset/tz2309tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_025.vset/tz2309tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_025.vset/tz2310tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_025.vset/tz2310tz.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_025.vset/tz2311sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_025.vset/tz2311sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_025.vset/tz2312do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_025.vset/tz2312do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_025.vset/tz2313go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_025.vset/tz2313go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_026.vset/tz2314do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_026.vset/tz2314do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_026.vset/tz2315go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_026.vset/tz2315go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_026.vset/tz2316je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_026.vset/tz2316je.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_026.vset/tz2317do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_026.vset/tz2317do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_026.vset/tz2319do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_026.vset/tz2319do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_026.vset/tz23a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_026.vset/tz23a2go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_026.vset/tz23a4sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_026.vset/tz23a4sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_090.vset/tz2401ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_090.vset/tz2401ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_090.vset/tz2402ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_090.vset/tz2402ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_090.vset/tz2403bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_090.vset/tz2403bo.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_090.vset/tz2404ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_090.vset/tz2404ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_090.vset/tz2405ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_090.vset/tz2405ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_091.vset/tz2406ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_091.vset/tz2406ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_091.vset/tz2407ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_091.vset/tz2407ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_091.vset/tz2408ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_091.vset/tz2408ur.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_091.vset/tz2409ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_091.vset/tz2409ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/tz/tz_091.vset/tz2410ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_fourth/remastered/voice/event/tz/tz_091.vset/tz2410ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_001.vset/al0101do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_001.vset/al0101do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_001.vset/al0103go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_001.vset/al0103go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_001.vset/al0104go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_001.vset/al0104go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_001.vset/al0105do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_001.vset/al0105do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_002.vset/al0202ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_002.vset/al0202ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_002.vset/al0203ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_002.vset/al0203ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_002.vset/al0204ia.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_002.vset/al0204ia.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_002.vset/al0205ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_002.vset/al0205ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_002.vset/al0207ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_002.vset/al0207ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_002.vset/al0208ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_002.vset/al0208ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_010.vset/al0201ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_010.vset/al0201ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_010.vset/al0202ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_010.vset/al0202ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_010.vset/al0203ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_010.vset/al0203ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_010.vset/al0204ia.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_010.vset/al0204ia.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_010.vset/al0205ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_010.vset/al0205ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_010.vset/al0206ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_010.vset/al0206ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_010.vset/al0207ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_010.vset/al0207ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_010.vset/al02a1ia.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_010.vset/al02a1ia.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_011.vset/al0208ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_011.vset/al0208ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_011.vset/al0209ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_011.vset/al0209ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_011.vset/al0210ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_011.vset/al0210ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_011.vset/al0211ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_011.vset/al0211ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_011.vset/al0212ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_011.vset/al0212ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_012.vset/al0213ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_012.vset/al0213ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_012.vset/al0214ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_012.vset/al0214ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_013.vset/al0805ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_013.vset/al0805ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_013.vset/al0806sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_013.vset/al0806sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_013.vset/al0807ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_013.vset/al0807ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_013.vset/al0808ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_013.vset/al0808ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_013.vset/al0809ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_013.vset/al0809ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_013.vset/al0810ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_013.vset/al0810ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_013.vset/al0811ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_013.vset/al0811ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_014.vset/al0812do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_014.vset/al0812do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_014.vset/al081age.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_014.vset/al081age.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_014.vset/al081bge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_014.vset/al081bge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_014.vset/al081cge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_014.vset/al081cge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_014.vset/al081dge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_014.vset/al081dge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_015.vset/al0814ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_015.vset/al0814ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_015.vset/al0816ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_015.vset/al0816ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_015.vset/al0817ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_015.vset/al0817ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_015.vset/al081ege.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_015.vset/al081ege.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_015.vset/al081fge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_015.vset/al081fge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_015.vset/al081gge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_015.vset/al081gge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_015.vset/al081hge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_015.vset/al081hge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_016.vset/al0818ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_016.vset/al0818ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_016.vset/al0819go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_016.vset/al0819go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_016.vset/al0820ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_016.vset/al0820ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_016.vset/al0821ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_016.vset/al0821ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_016.vset/al0822do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_016.vset/al0822do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_016.vset/al0823go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_016.vset/al0823go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_016.vset/al0824sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_016.vset/al0824sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_016.vset/al0825ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_016.vset/al0825ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_016.vset/al0826ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_016.vset/al0826ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_017.vset/al8b01ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_017.vset/al8b01ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_017.vset/al8b02sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_017.vset/al8b02sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_017.vset/al8b03ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_017.vset/al8b03ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_017.vset/al8b04ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_017.vset/al8b04ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_017.vset/al8b05ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_017.vset/al8b05ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_017.vset/al8b06ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_017.vset/al8b06ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_017.vset/al8b07ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_017.vset/al8b07ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_017.vset/al8b08ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_017.vset/al8b08ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_090.vset/al2001ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_090.vset/al2001ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_090.vset/al2002rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_090.vset/al2002rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_090.vset/al2003ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_090.vset/al2003ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_090.vset/al2004ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_090.vset/al2004ha.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_090.vset/al2005rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_090.vset/al2005rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_090.vset/al2006ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_090.vset/al2006ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_091.vset/al2007rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_091.vset/al2007rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_091.vset/al2008ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_091.vset/al2008ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_091.vset/al2009ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_091.vset/al2009ho.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_091.vset/al2010rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_091.vset/al2010rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_091.vset/al2011ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_091.vset/al2011ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_091.vset/al2012rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_091.vset/al2012rk.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_091.vset/al2013ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_091.vset/al2013ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_100.vset/al0301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_100.vset/al0301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_100.vset/al0302js.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_100.vset/al0302js.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_100.vset/al0303ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_100.vset/al0303ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_100.vset/al0304ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_100.vset/al0304ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_100.vset/al0305ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_100.vset/al0305ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_100.vset/al0306sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_100.vset/al0306sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_100.vset/al0309ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_100.vset/al0309ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_101.vset/al1001ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_101.vset/al1001ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_101.vset/al1002ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_101.vset/al1002ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_101.vset/al1003ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_101.vset/al1003ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_101.vset/al1004js.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_101.vset/al1004js.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_102.vset/al1006ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_102.vset/al1006ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_102.vset/al1012ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_102.vset/al1012ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_102.vset/al1013ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_102.vset/al1013ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_102.vset/al1014ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_102.vset/al1014ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_102.vset/al1015js.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_102.vset/al1015js.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_102.vset/al1016ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_102.vset/al1016ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_102.vset/al1017ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_102.vset/al1017ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_103.vset/al1101ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_103.vset/al1101ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_103.vset/al1102ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_103.vset/al1102ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_103.vset/al1103ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_103.vset/al1103ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_104.vset/al1904ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_104.vset/al1904ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_104.vset/al1905ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_104.vset/al1905ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_104.vset/al1906ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_104.vset/al1906ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_104.vset/al1907ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_104.vset/al1907ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_104.vset/al1908ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_104.vset/al1908ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_104.vset/al1909ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_104.vset/al1909ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_104.vset/al1910ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_104.vset/al1910ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_104.vset/al1911ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_104.vset/al1911ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_104.vset/al19a2ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_104.vset/al19a2ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_105.vset/al1912ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_105.vset/al1912ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_105.vset/al1913ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_105.vset/al1913ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_105.vset/al1914ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_105.vset/al1914ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_105.vset/al1915ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_105.vset/al1915ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_105.vset/al1916ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_105.vset/al1916ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_105.vset/al19a1ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_105.vset/al19a1ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_106.vset/al0801go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_106.vset/al0801go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_106.vset/al0802ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_106.vset/al0802ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_106.vset/al0803ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_106.vset/al0803ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_106.vset/al0804ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_106.vset/al0804ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_106.vset/al08a2ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_106.vset/al08a2ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_106.vset/al11a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_106.vset/al11a1sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_106.vset/al11a2ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_106.vset/al11a2ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_201.vset/al1304ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_201.vset/al1304ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_201.vset/al1305ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_201.vset/al1305ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_202.vset/al1401ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_202.vset/al1401ma.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_202.vset/al1402ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_202.vset/al1402ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_202.vset/al1403ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_202.vset/al1403ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_202.vset/al1404ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_202.vset/al1404ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_202.vset/al1405sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_202.vset/al1405sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_203.vset/al1409ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_203.vset/al1409ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_203.vset/al1410ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_203.vset/al1410ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_203.vset/al1411ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_203.vset/al1411ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_203.vset/al1412go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_203.vset/al1412go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_203.vset/al1413do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_203.vset/al1413do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_203.vset/al1414ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_203.vset/al1414ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_204.vset/al1415ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_204.vset/al1415ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_204.vset/al1416ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_204.vset/al1416ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_204.vset/al1417ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_204.vset/al1417ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_204.vset/al1418ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_204.vset/al1418ge.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_205.vset/al1501ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_205.vset/al1501ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_206.vset/al1610ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_206.vset/al1610ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_206.vset/al1611ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_206.vset/al1611ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_207.vset/al1701sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_207.vset/al1701sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_207.vset/al1702ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_207.vset/al1702ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_208.vset/al18a1js.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_208.vset/al18a1js.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_208.vset/al1901ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_208.vset/al1901ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_208.vset/al1902go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_208.vset/al1902go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_208.vset/al1903ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_208.vset/al1903ad.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/al/al_209.vset/al16a5ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/al/al_209.vset/al16a5ja.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_001.vset/aw0101wr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_001.vset/aw0101wr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_001.vset/aw0102wr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_001.vset/aw0102wr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_003.vset/aw0301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_003.vset/aw0301sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_003.vset/aw0302dn.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_003.vset/aw0302dn.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_003.vset/aw0303do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_003.vset/aw0303do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_003.vset/aw0304dn.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_003.vset/aw0304dn.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_003.vset/aw0305go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_003.vset/aw0305go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_003.vset/aw0306dn.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_003.vset/aw0306dn.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_003.vset/aw0307sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_003.vset/aw0307sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_003.vset/aw0308dn.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_003.vset/aw0308dn.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_005.vset/aw0501dn.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_005.vset/aw0501dn.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_006.vset/aw0601wr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_006.vset/aw0601wr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_006.vset/aw0602al.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_006.vset/aw0602al.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_006.vset/aw0603wr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_006.vset/aw0603wr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_006.vset/aw0604qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_006.vset/aw0604qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_006.vset/aw0605qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_006.vset/aw0605qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_006.vset/aw0606al.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_006.vset/aw0606al.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_006.vset/aw0607qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_006.vset/aw0607qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_007.vset/aw0608al.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_007.vset/aw0608al.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_007.vset/aw0609al.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_007.vset/aw0609al.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_007.vset/aw0610qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_007.vset/aw0610qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_008.vset/aw0611sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_008.vset/aw0611sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_008.vset/aw0612do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_008.vset/aw0612do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_008.vset/aw0613go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_008.vset/aw0613go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_008.vset/aw0614do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_008.vset/aw0614do.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_008.vset/aw0615go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_008.vset/aw0615go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_009.vset/aw0618qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_009.vset/aw0618qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_009.vset/aw0619qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_009.vset/aw0619qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_009.vset/aw0620sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_009.vset/aw0620sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_009.vset/aw0621qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_009.vset/aw0621qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_009.vset/aw0622al.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_009.vset/aw0622al.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_009.vset/aw0623sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_009.vset/aw0623sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_009.vset/aw0624qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_009.vset/aw0624qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_010.vset/aw0625sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_010.vset/aw0625sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_010.vset/aw0626go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_010.vset/aw0626go.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_010.vset/aw0627sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_010.vset/aw0627sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_010.vset/aw0628qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_010.vset/aw0628qh.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_010.vset/aw0629sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_010.vset/aw0629sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_011.vset/aw1101dn.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_011.vset/aw1101dn.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_011.vset/aw11a1dn.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_011.vset/aw11a1dn.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/aw/aw_011.vset/aw11a2sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/aw/aw_011.vset/aw11a2sr.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_007.vset/di0321te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/di/di_007.vset/di0321te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_007.vset/di0323te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/di/di_007.vset/di0323te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_007.vset/di0325te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/di/di_007.vset/di0325te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_007.vset/di0329te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/di/di_007.vset/di0329te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_007.vset/di0331te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/di/di_007.vset/di0331te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo - name: remastered/voice/event/di/di_007.vset/di0333te.win32.scd>>MyGithubUsername\MyPatch\mod.yml
	echo   method: copy>>MyGithubUsername\MyPatch\mod.yml
	echo   source:>>MyGithubUsername\MyPatch\mod.yml
	echo   - name: kh1_third/remastered/voice/event/di/di_007.vset/di0333te.win32.scd
	
	echo The mod.yml file is completed! You can now add an icon.png file (128x128) and a README.md if you want.
	echo If you want to add a file or just modify the mod.yml you can just open it with a notepad.
)
if %patcher%==2 (
	KHPCPatchManager.exe MyPatch
	rmdir /Q /S MyPatch
	echo The patch is named MyPatch.kh1pcpatch but you can rename it as you want and you can also open it like a .zip file.
)
if %patcher%==3 (
	echo The files are in MyPatch.
)