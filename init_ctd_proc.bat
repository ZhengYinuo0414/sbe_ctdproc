@echo off
SETLOCAL
SET _EXITSTATUS=0
SET _ARGNUM=0
SET BASE_DIR=c:\users\Public\Documents

FOR %%i IN (%*) DO SET /A _ARGNUM+=1

IF %_ARGNUM% LSS 1 (
    
    SET _EXITSTATUS=1    
    GOTO:_SHOWUSAGE

)

IF %_ARGNUM% GTR 2 (

  call :_SHOWUSAGE %0%
  set _EXITSTATUS=1
  GOTO:_EOF
)

IF %_ARGNUM% EQU 2 (
    SET BASE_DIR=%2
)




REM ########################################################################
REM # The cruise name. This value is used to construct the file names      #
REM # that be read and written to.                                         #
REM #
SET CRUISE_ID=%1
REM #                                                                      #
REM ########################################################################
REM # Path to the Sea Bird executables that will run with wine.            #
REM #                                                                      #
SET SBE_DIR="c:\Program Files (x86)\Sea-Bird\SBEDataProcessing-Win32"
REM #                                                                      #
REM ########################################################################
REM # Base directory that holds the CTD processing files                   #
REM # All directories assosciated with CTD processing will fall under this #
REM # directory.                                                           #
REM #                                                                      #
SET CTD_DIR=%BASE_DIR%\ctd_proc
REM #                                                                      #
REM ########################################################################
REM # Directory where the raw data files are placed.                       #
REM # This corresponds to %1 in the sbe_batch.dat script.                  #
REM #                                                                      #
SET RAW_DIR=%CTD_DIR%\raw_data
REM #                                                                      # 
REM ########################################################################
REM # Directory where the 1db processed data will be placed.               #
REM # This corresponds to %3 in the sbe_batch.dat script.                  #
REM #                                                                      #
SET PROCDATA_1DB_DIR=%CTD_DIR%\1db\proc_data
REM #                                                                      #
REM ########################################################################
REM # Directory where the 1hz processed data will be placed.               #
REM #                                                                      #
REM # This corresponds to %4 in the sbe_batch.dat script.                  #
SET PROCDATA_1HZ_DIR=%CTD_DIR%\1hz\proc_data
REM #                                                                      #
REM ########################################################################
REM # Directory that holds the 1db PSA files.                              #
REM # This corresponds to %5 in the sbe_batch.dat script.                  #
REM #                                                                      #
SET PSA_1DB=%CTD_DIR%\1db\psa
REM #                                                                      #
REM ########################################################################
REM # Directory that holds the 1hz PSA files.                              #
REM # This corresponds to %6 in the sbe_batch.dat script.                  #
REM #                                                                      #
SET PSA_1HZ=%CTD_DIR%\1hz\psa
REM #                                                                      #
REM ########################################################################
REM # Directory where the bottle files will be placed.                     #
REM # This corresponds to %7 in the sbe_batch.dat script.                  #
REM #                                                                      #
SET BOTTLE_DIR=%CTD_DIR%\bottle
REM #                                                                      #
REM ########################################################################
REM # Directory that holds the processing scripts.                         # 
REM #                                                                      #
SET SBEBATCH_DIR=%CTD_DIR%\batch_files
REM #                                                                      #
REM ########################################################################
REM #                                                                      #
SET BATCH_FILE=%SBEBATCH_DIR%\sbe_batch.dat
REM #                                                                      #
REM ########################################################################


REM # Builds the directory structure. Once built, the PSA files need to be 
REM # manually placed into the appropriate locations. 


IF NOT EXIST %RAW_DIR% (
    mkdir %RAW_DIR%
)

IF NOT EXIST %PROCDATA_1DB_DIR% (
    mkdir %PROCDATA_1DB_DIR%
)

IF NOT EXIST %PROCDATA_1HZ_DIR% (
    mkdir %PROCDATA_1HZ_DIR%
)


IF NOT EXIST %PSA_1DB% (
    mkdir %PSA_1DB%
)

IF NOT EXIST %PSA_1HZ% (
    mkdir %PSA_1HZ%
)

IF NOT EXIST %BOTTLE_DIR% (
    mkdir %BOTTLE_DIR%
)

IF NOT EXIST %SBEBATCH_DIR% (
    mkdir %SBEBATCH_DIR%
)



REM # Generate 1db files
REM #### COPY BELOW THIS LINE ####


REM #### START DatCnv.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1DB%\DatCnv.psa
echo ^<Data_Conversion ^> >>%PSA_1DB%\DatCnv.psa
echo ^<Version value="7.23.1" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<ServerName value="Data Conversion" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<InstrumentPath value="J:\ab1602\sbe_ctd\raw_data\ab1602_001.xmlcon" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<InstrumentMatch value="0" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<InputDir value="J:\ab1602\sbe_ctd\raw_data" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<ArrayItem index="0" value="ab1602_001.hex" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</InputFileArray^> >>%PSA_1DB%\DatCnv.psa
echo ^<OutputDir value="J:\ab1602\sbe_ctd\1db\proc_data" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<NameAppend value="" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<OutputFile value="ab1602_001" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<ProcessScansToEnd value="1" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<ScansToSkip value="0" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<ScansToProcess value="1" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<MergeHeaderFile value="0" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<OutputFormat value="0" high="1" low="0" initialValue="0" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<FromCast value="0" high="1" low="0" initialValue="0" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<CreateFile value="2" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<ScanRangeSource value="3" high="3" low="0" initialValue="3" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<ScanRangeOffset value="0.000000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<ScanRangeDuration value="5.500000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<StartTimeOption value="1" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<PromptForNoteAndOrStartTime value="0" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<CalcArray Size="15" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<CalcArrayItem index="0" CalcID="72" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<Calc UnitID="-1" Ordinal="0" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<FullName value="Scan Count" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</Calc^> >>%PSA_1DB%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\DatCnv.psa
echo ^<CalcArrayItem index="1" CalcID="84" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<Calc UnitID="52" Ordinal="0" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<FullName value="Time, Elapsed [seconds]" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</Calc^> >>%PSA_1DB%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\DatCnv.psa
echo ^<CalcArrayItem index="2" CalcID="17" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<Calc UnitID="31" Ordinal="0" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<FullName value="Depth [salt water, m]" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<Latitude value="26.500000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</Calc^> >>%PSA_1DB%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\DatCnv.psa
echo ^<CalcArrayItem index="3" CalcID="65" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<Calc UnitID="3" Ordinal="0" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<FullName value="Pressure, Digiquartz [db]" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</Calc^> >>%PSA_1DB%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\DatCnv.psa
echo ^<CalcArrayItem index="4" CalcID="81" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<Calc UnitID="6" Ordinal="0" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<FullName value="Temperature [ITS-90, deg C]" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</Calc^> >>%PSA_1DB%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\DatCnv.psa
echo ^<CalcArrayItem index="5" CalcID="81" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<Calc UnitID="6" Ordinal="1" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<FullName value="Temperature, 2 [ITS-90, deg C]" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</Calc^> >>%PSA_1DB%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\DatCnv.psa
echo ^<CalcArrayItem index="6" CalcID="12" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<Calc UnitID="58" Ordinal="0" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<FullName value="Conductivity [S/m]" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</Calc^> >>%PSA_1DB%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\DatCnv.psa
echo ^<CalcArrayItem index="7" CalcID="12" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<Calc UnitID="58" Ordinal="1" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<FullName value="Conductivity, 2 [S/m]" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</Calc^> >>%PSA_1DB%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\DatCnv.psa
echo ^<CalcArrayItem index="8" CalcID="57" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<Calc UnitID="63" Ordinal="0" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<FullName value="Oxygen raw, SBE 43 [V]" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<ApplyHysteresisCorrection value="0" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</Calc^> >>%PSA_1DB%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\DatCnv.psa
echo ^<CalcArrayItem index="9" CalcID="57" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<Calc UnitID="63" Ordinal="1" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<FullName value="Oxygen raw, SBE 43, 2 [V]" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<ApplyHysteresisCorrection value="0" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</Calc^> >>%PSA_1DB%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\DatCnv.psa
echo ^<CalcArrayItem index="10" CalcID="1" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<Calc UnitID="29" Ordinal="0" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<FullName value="Altimeter [m]" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</Calc^> >>%PSA_1DB%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\DatCnv.psa
echo ^<CalcArrayItem index="11" CalcID="39" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<FullName value="Latitude [deg]" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</Calc^> >>%PSA_1DB%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\DatCnv.psa
echo ^<CalcArrayItem index="12" CalcID="40" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<FullName value="Longitude [deg]" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</Calc^> >>%PSA_1DB%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\DatCnv.psa
echo ^<CalcArrayItem index="13" CalcID="55" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<Calc UnitID="68" Ordinal="0" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<FullName value="Oxygen, SBE 43 [dov/dt]" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<WindowSize value="5.000000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<ApplyHysteresisCorrection value="0" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</Calc^> >>%PSA_1DB%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\DatCnv.psa
echo ^<CalcArrayItem index="14" CalcID="55" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<Calc UnitID="68" Ordinal="1" ^> >>%PSA_1DB%\DatCnv.psa
echo ^<FullName value="Oxygen, SBE 43, 2 [dov/dt]" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<WindowSize value="5.000000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<ApplyHysteresisCorrection value="0" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</Calc^> >>%PSA_1DB%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\DatCnv.psa
echo ^</CalcArray^> >>%PSA_1DB%\DatCnv.psa
echo ^<MiscellaneousDataForCalculations ^> >>%PSA_1DB%\DatCnv.psa
echo ^<Latitude value="26.500000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<Longitude value="0.000000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<DescentRateAndAcceleration ^> >>%PSA_1DB%\DatCnv.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</DescentRateAndAcceleration^> >>%PSA_1DB%\DatCnv.psa
echo ^<Oxygen ^> >>%PSA_1DB%\DatCnv.psa
echo ^<WindowSize value="5.000000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<ApplyHysteresisCorrection value="0" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</Oxygen^> >>%PSA_1DB%\DatCnv.psa
echo ^<AverageSoundVelocity ^> >>%PSA_1DB%\DatCnv.psa
echo ^<MinimumPressure value="20.000000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<MinimumSalinity value="20.000000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<PressureWindowSize value="20.000000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<TimeWindowSize value="60.000000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</AverageSoundVelocity^> >>%PSA_1DB%\DatCnv.psa
echo ^<PlumeAnomaly ^> >>%PSA_1DB%\DatCnv.psa
echo ^<ThetaB value="0.000000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<SalinityB value="0.000000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<ThetaZSalinityZRatio value="0.000000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<ReferencePressure value="0.000000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</PlumeAnomaly^> >>%PSA_1DB%\DatCnv.psa
echo ^<PotentialTempAnomaly ^> >>%PSA_1DB%\DatCnv.psa
echo ^<A0 value="0.000000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<A1 value="0.000000" /^> >>%PSA_1DB%\DatCnv.psa
echo ^<A1Multiplier value="0" /^> >>%PSA_1DB%\DatCnv.psa
echo ^</PotentialTempAnomaly^> >>%PSA_1DB%\DatCnv.psa
echo ^</MiscellaneousDataForCalculations^> >>%PSA_1DB%\DatCnv.psa
echo ^</Data_Conversion^> >>%PSA_1DB%\DatCnv.psa
REM #### END DatCnv.psa ####



REM ###########################config.bat###################################
echo @echo off > %SBEBATCH_DIR%\config.bat
echo SET BASE_DIR=%BASE_DIR%>> %SBEBATCH_DIR%\config.bat

echo REM ########################################################################>> %SBEBATCH_DIR%\config.bat
echo REM # The cruise name. This value is used to construct the file names      #>> %SBEBATCH_DIR%\config.bat
echo REM # that be read and written to.                                         #>> %SBEBATCH_DIR%\config.bat
echo REM #>> %SBEBATCH_DIR%\config.bat
SET TMP=SET CRUISE_ID=%CRUISE_ID%
echo %TMP%>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo REM ########################################################################>> %SBEBATCH_DIR%\config.bat
echo REM # Path to the Sea Bird executables that will run with wine.            #>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
SET TMP=SET SBE_DIR=%SBE_DIR%
echo %TMP%>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo REM ########################################################################>> %SBEBATCH_DIR%\config.bat
echo REM # Base directory that holds the CTD processing files                   #>> %SBEBATCH_DIR%\config.bat
echo REM # All directories assosciated with CTD processing will fall under this #>> %SBEBATCH_DIR%\config.bat
echo REM # directory.                                                           #>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo SET CTD_DIR=%%BASE_DIR%%\ctd_proc>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo REM ########################################################################>> %SBEBATCH_DIR%\config.bat
echo REM # Directory where the raw data files are placed.                       #>> %SBEBATCH_DIR%\config.bat
echo REM # This corresponds to %%1 in the sbe_batch.dat script.                  #>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo SET RAW_DIR=%%CTD_DIR%%\raw_data>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo REM ########################################################################>> %SBEBATCH_DIR%\config.bat
echo REM # Directory where the 1db processed data will be placed.               #>> %SBEBATCH_DIR%\config.bat
echo REM # This corresponds to %%3 in the sbe_batch.dat script.                  #>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo SET PROCDATA_1DB_DIR=%%CTD_DIR%%\1db\proc_data>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo REM ########################################################################>> %SBEBATCH_DIR%\config.bat
echo REM # Directory where the 1hz processed data will be placed.               #>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo REM # This corresponds to %%4 in the sbe_batch.dat script.                  #>> %SBEBATCH_DIR%\config.bat
echo SET PROCDATA_1HZ_DIR=%%CTD_DIR%%\1hz\proc_data>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo REM ########################################################################>> %SBEBATCH_DIR%\config.bat
echo REM # Directory that holds the 1db PSA files.                              #>> %SBEBATCH_DIR%\config.bat
echo REM # This corresponds to %%5 in the sbe_batch.dat script.                  #>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo SET PSA_1DB=%%CTD_DIR%%\1db\psa>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo REM ########################################################################>> %SBEBATCH_DIR%\config.bat
echo REM # Directory that holds the 1hz PSA files.                              #>> %SBEBATCH_DIR%\config.bat
echo REM # This corresponds to %%6 in the sbe_batch.dat script.                  #>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo SET PSA_1HZ=%%CTD_DIR%%\1hz\psa>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo REM ########################################################################>> %SBEBATCH_DIR%\config.bat
echo REM # Directory where the bottle files will be placed.                     #>> %SBEBATCH_DIR%\config.bat
echo REM # This corresponds to %%7 in the sbe_batch.dat script.                  #>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo SET BOTTLE_DIR=%%CTD_DIR%%\bottle>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo REM ########################################################################>> %SBEBATCH_DIR%\config.bat
echo REM # Directory that holds the processing scripts.                         #>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo SET SBEBATCH_DIR=%%CTD_DIR%%\batch_files>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo REM ########################################################################>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo SET BATCH_FILE=%%SBEBATCH_DIR%%\sbe_batch.dat>> %SBEBATCH_DIR%\config.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\config.bat
echo REM ########################################################################>> %SBEBATCH_DIR%\config.bat

REM #######################process_ctd.bat#####################################

echo @echo off> %SBEBATCH_DIR%\process_ctd.bat
echo SETLOCAL>> %SBEBATCH_DIR%\process_ctd.bat
echo SET _EXITSTATUS=0>> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo REM # Edit this file to setup ctd processing.>> %SBEBATCH_DIR%\process_ctd.bat
echo REM # This line brings in the variable values>> %SBEBATCH_DIR%\process_ctd.bat
echo SET SBEBATCH_DIR=%SBEBATCH_DIR%>> %SBEBATCH_DIR%\process_ctd.bat
echo CALL %%SBEBATCH_DIR%%\config.bat>> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo SET TEMP=Checking for SBEBatch.exe in %%SBE_DIR%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo %%TEMP%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo IF NOT EXIST %%SBE_DIR%%\SBEBatch.exe (>> %SBEBATCH_DIR%\process_ctd.bat
echo echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo     echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo     echo SBEBatch.exe not found!>> %SBEBATCH_DIR%\process_ctd.bat
echo     SET SBE_DIR="c:\Program Files\Sea-Bird\SBEDataProcessing-Win32">> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat  
echo ) ELSE (>> %SBEBATCH_DIR%\process_ctd.bat
echo     echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo     echo Found SBEBatch.exe!>> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo )>> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo SET TEMP=Checking for SBEBatch.exe in %%SBE_DIR%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo %%TEMP%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo IF NOT EXIST %%SBE_DIR%%\SBEBatch.exe (>> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat  
echo     echo The SeaBird processing software doesn't seem to be installed.>> %SBEBATCH_DIR%\process_ctd.bat
echo     echo please install it in the default location and try again.>> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat     
echo     SET _EXITSTATUS=1>> %SBEBATCH_DIR%\process_ctd.bat
echo     GOTO:_EOF>> %SBEBATCH_DIR%\process_ctd.bat
echo ) ELSE (>> %SBEBATCH_DIR%\process_ctd.bat
echo     echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo     echo Found SBEBatch.exe!>> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo )>> %SBEBATCH_DIR%\process_ctd.bat
echo.
echo.
echo REM ########################################################################>> %SBEBATCH_DIR%\process_ctd.bat
echo REM # The basename that will be used to assemble the filenames needed.     #>> %SBEBATCH_DIR%\process_ctd.bat
echo REM # This corresponds to ^%%^%%^2 in the sbe_batch.dat script.                  #>> %SBEBATCH_DIR%\process_ctd.bat
echo REM #                                                                      #>> %SBEBATCH_DIR%\process_ctd.bat
echo SET BASENAME=%%CRUISE_ID%%_%%1>> %SBEBATCH_DIR%\process_ctd.bat
echo REM #>> %SBEBATCH_DIR%\process_ctd.bat
echo REM ########################################################################>> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo echo @ ^%%^%%^1 Path to the raw data files.^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo @ ^%%^%%^2 Basename used to create the filenames. ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo @ ^%%^%%^3 Path where the processed 1db files will be placed. ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo @ ^%%^%%^4 Path where the processed 1hz files will be placed. ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo @ ^%%^%%^5 Path to the 1db psa files. ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo @ ^%%^%%^6 Path to the 1hz psa files. ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo @ ^%%^%%^7 Path where the bottle files will be placed. ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo. ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo. ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo echo @DatCNVW AlignCTDW WildEditW FilterW CellTMW LoopEditW RosSumW DeriveW BinAvgW StripW TransW SplitW ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo. ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo @@@@@@@@@@@@@@@@@@ ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo @ 1DB PROCESSING @ ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo @@@@@@@@@@@@@@@@@@ ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat

echo echo. ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo datcnv      /i^%%^%%^1/^%%^%%^2.hex   /p^%%^%%^5/DatCnv.psa      /f^%%^%%^2.cnv /o^%%^%%^3    /c^%%^%%^1\^%%^%%^2.xmlcon ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo @markscan   /i^%%^%%^1/^%%^%%^2.mrk   /p^%%^%%^5/MarkScan.psa    /f^%%^%%^2.cnv /o^%%^%%^3 ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo alignctd    /i^%%^%%^3/^%%^%%^2.cnv   /p^%%^%%^5/AlignCTD.psa    /f^%%^%%^2.cnv /o^%%^%%^3 ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo wildedit    /i^%%^%%^3/^%%^%%^2.cnv   /p^%%^%%^5/WildEdit.psa    /f^%%^%%^2.cnv /o^%%^%%^3 ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo filter      /i^%%^%%^3/^%%^%%^2.cnv   /p^%%^%%^5/Filter.psa      /f^%%^%%^2.cnv /o^%%^%%^3 ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo loopedit    /i^%%^%%^3/^%%^%%^2.cnv   /p^%%^%%^5/LoopEdit.psa    /f^%%^%%^2.cnv /o^%%^%%^3 ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo celltm      /i^%%^%%^3/^%%^%%^2.cnv   /p^%%^%%^5/CellTM.psa      /f^%%^%%^2.cnv /o^%%^%%^3 ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo rossum      /i^%%^%%^3/^%%^%%^2.ros   /p^%%^%%^5/BottleSum.psa   /f^%%^%%^2.btl /o^%%^%%^7    /c^%%^%%^1\^%%^%%^2.xmlcon ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo derive      /i^%%^%%^3/^%%^%%^2.cnv   /p^%%^%%^5/Derive.psa      /f^%%^%%^2.cnv /o^%%^%%^3    /c^%%^%%^1\^%%^%%^2.xmlcon ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo binavg      /i^%%^%%^3/^%%^%%^2.cnv   /p^%%^%%^5/BinAvg.psa      /f^%%^%%^2.cnv /o^%%^%%^3 ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo trans       /i^%%^%%^3/^%%^%%^2.cnv   /p^%%^%%^5/Trans.psa       /f^%%^%%^2.cnv /o^%%^%%^3 ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo split       /i^%%^%%^3/^%%^%%^2.cnv   /p^%%^%%^5/Split.psa       /f^%%^%%^2.cnv /o^%%^%%^3 ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo.  ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat

echo echo @@@@@@@@@@@@@@@@@@ ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo @ 1HZ PROCESSING @ ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo @@@@@@@@@@@@@@@@@@ ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo.  ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo @DatCNVW AlignCTDW WildEditW FilterW CellTMW BinAvgW StripW TransW ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo. ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo datcnv      /i^%%^%%^1/^%%^%%^2.hex   /p^%%^%%^6/DatCnv.psa      /f^%%^%%^2.cnv /o^%%^%%^4    /c^%%^%%^1\^%%^%%^2.xmlcon ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo alignctd    /i^%%^%%^4/^%%^%%^2.cnv   /p^%%^%%^6/AlignCTD.psa    /f^%%^%%^2.cnv /o^%%^%%^4 ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo wildedit    /i^%%^%%^4/^%%^%%^2.cnv   /p^%%^%%^6/WildEdit.psa    /f^%%^%%^2.cnv /o^%%^%%^4 ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo filter      /i^%%^%%^4/^%%^%%^2.cnv   /p^%%^%%^6/Filter.psa      /f^%%^%%^2.cnv /o^%%^%%^4 ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo celltm      /i^%%^%%^4/^%%^%%^2.cnv   /p^%%^%%^6/CellTM.psa      /f^%%^%%^2.cnv /o^%%^%%^4 ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo binavg      /i^%%^%%^4/^%%^%%^2.cnv   /p^%%^%%^6/BinAvg.psa      /f^%%^%%^2.cnv /o^%%^%%^4 ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat
echo echo trans       /i^%%^%%^4/^%%^%%^2.cnv   /p^%%^%%^6/Trans.psa       /f^%%^%%^2.cnv /o^%%^%%^4 ^>^> %%BATCH_FILE%%>> %SBEBATCH_DIR%\process_ctd.bat


echo REM wine is used to run the SBEBatch.exe program that will do the>> %SBEBATCH_DIR%\process_ctd.bat
echo REM processing. Seven arguments are passed to the sbe_batch.dat script.>> %SBEBATCH_DIR%\process_ctd.bat
echo REM this order is important. If the order is changed, make sure to make>> %SBEBATCH_DIR%\process_ctd.bat
echo REM the changes in the sbe_batch file.>> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo %%SBE_DIR%%\SBEBatch.exe %%BATCH_FILE%% %%RAW_DIR%% %%BASENAME%% %%PROCDATA_1DB_DIR%% %%PROCDATA_1HZ_DIR%% %%PSA_1DB%% %%PSA_1HZ%% %%BOTTLE_DIR%%>> %SBEBATCH_DIR%\process_ctd.bat
echo ENDLOCAL>> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo @echo off>> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo :_EOF>> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat
echo CMD /C EXIT %_EXITSTATUS%>> %SBEBATCH_DIR%\process_ctd.bat
echo.>> %SBEBATCH_DIR%\process_ctd.bat

SET DN0=%~dp0
SET DN=%DN0:~0,-1%

copy %DN%\init_ctd_proc.bat %SBEBATCH_DIR%
copy %DN%\psa_1db_2nix %SBEBATCH_DIR%
copy %DN%\psa_1hz_2nix %SBEBATCH_DIR%

cls
echo.
echo.
echo.
echo This is now configured for basic CTD processing for cruise %CRUISE_ID%.
echo Make sure the SeaBird processing software is installed and running.
echo This script assumes that SBEBatch.exe is installed in either 
echo C:\Program Files (x86)\Sea-Bird\SBEDataProcessing-Win32
echo or C:\Program Files\Sea-Bird\SBEDataProcessing-Win32.
echo.
echo Place the raw CTD files in %RAW_DIR%
echo To process navigate to %SBEBATCH_DIR% and type process_ctd nnn
echo where nnn is the station number to process.
echo.


ENDLOCAL

@echo off
GOTO:_EOF

:_SHOWUSAGE

    echo ERROR
    echo This script takes up to two parameters, CRUISE ID and an optional Install path.
    echo eg. init_ctd_proc AB1705 C:\users\Public\Documents.
    echo If the path is omitted then everything will be placed in %BASE_DIR%\ctd_proc

    GOTO:EOF

:_EOF
 @echo off
CMD /C EXIT %_EXITSTATUS%
