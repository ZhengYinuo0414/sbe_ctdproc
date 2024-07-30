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

REM #### START AlignCTD.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1DB%\AlignCTD.psa
echo ^<Align_CTD ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<Version value="7.23.2" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ServerName value="Align CTD" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<InputDir value="C:\Users\scs.user.rb\CTD\ab1802\proc_data\1db" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ArrayItem index="0" value="ab1802_000.cnv" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^</InputFileArray^> >>%PSA_1DB%\AlignCTD.psa
echo ^<OutputDir value="C:\Users\scs.user.rb\CTD\ab1802\proc_data\1db" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<NameAppend value="" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<OutputFile value="ab1802_000.cnv" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<CalcArray Size="11" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<CalcArrayItem index="0" CalcID="81" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<Calc UnitID="6" Ordinal="0" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<FullName value="Temperature [ITS-90, deg C]" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1DB%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\AlignCTD.psa
echo ^<CalcArrayItem index="1" CalcID="81" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<Calc UnitID="6" Ordinal="1" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<FullName value="Temperature, 2 [ITS-90, deg C]" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1DB%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\AlignCTD.psa
echo ^<CalcArrayItem index="2" CalcID="12" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<Calc UnitID="58" Ordinal="0" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<FullName value="Conductivity [S/m]" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1DB%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\AlignCTD.psa
echo ^<CalcArrayItem index="3" CalcID="12" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<Calc UnitID="58" Ordinal="1" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<FullName value="Conductivity, 2 [S/m]" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1DB%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\AlignCTD.psa
echo ^<CalcArrayItem index="4" CalcID="57" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<Calc UnitID="63" Ordinal="0" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<FullName value="Oxygen raw, SBE 43 [V]" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1DB%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\AlignCTD.psa
echo ^<CalcArrayItem index="5" CalcID="57" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<Calc UnitID="63" Ordinal="1" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<FullName value="Oxygen raw, SBE 43, 2 [V]" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1DB%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\AlignCTD.psa
echo ^<CalcArrayItem index="6" CalcID="1" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<Calc UnitID="29" Ordinal="0" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<FullName value="Altimeter [m]" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1DB%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\AlignCTD.psa
echo ^<CalcArrayItem index="7" CalcID="39" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<FullName value="Latitude [deg]" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1DB%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\AlignCTD.psa
echo ^<CalcArrayItem index="8" CalcID="40" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<FullName value="Longitude [deg]" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1DB%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\AlignCTD.psa
echo ^<CalcArrayItem index="9" CalcID="55" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<Calc UnitID="68" Ordinal="0" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<FullName value="Oxygen, SBE 43 [dov/dt]" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1DB%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\AlignCTD.psa
echo ^<CalcArrayItem index="10" CalcID="55" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<Calc UnitID="68" Ordinal="1" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<FullName value="Oxygen, SBE 43, 2 [dov/dt]" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1DB%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\AlignCTD.psa
echo ^</CalcArray^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ValArray size="11" ^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ValArrayItem index="0" value="0.000000" variable_name="Temperature" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ValArrayItem index="1" value="0.000000" variable_name="Temperature" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ValArrayItem index="2" value="0.000000" variable_name="Conductivity" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ValArrayItem index="3" value="0.000000" variable_name="Conductivity" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ValArrayItem index="4" value="1.073000" variable_name="Oxygen raw, SBE 43" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ValArrayItem index="5" value="1.073000" variable_name="Oxygen raw, SBE 43" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ValArrayItem index="6" value="0.000000" variable_name="Altimeter" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ValArrayItem index="7" value="0.000000" variable_name="Latitude" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ValArrayItem index="8" value="0.000000" variable_name="Longitude" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ValArrayItem index="9" value="1.073000" variable_name="Oxygen, SBE 43" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^<ValArrayItem index="10" value="1.073000" variable_name="Oxygen, SBE 43" /^> >>%PSA_1DB%\AlignCTD.psa
echo ^</ValArray^> >>%PSA_1DB%\AlignCTD.psa
echo ^</Align_CTD^> >>%PSA_1DB%\AlignCTD.psa
REM #### END AlignCTD.psa ####
REM #### START BinAvg.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1DB%\BinAvg.psa
echo ^<Bin_Average ^> >>%PSA_1DB%\BinAvg.psa
echo ^<Version value="7.26.7.114" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<ServerName value="Bin Average" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<InputDir value="C:\Users\scs.user.rb\CTD\ab1802\proc_data\1db" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1DB%\BinAvg.psa
echo ^<ArrayItem index="0" value="ab1802_012.cnv" /^> >>%PSA_1DB%\BinAvg.psa
echo ^</InputFileArray^> >>%PSA_1DB%\BinAvg.psa
echo ^<OutputDir value="C:\Users\scs.user.rb\CTD\ab1802\proc_data\1db" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<NameAppend value="" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<OutputFile value="ab1802_012.cnv" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<BinType value="0" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<BinSize value="1.000000" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<IncludeNumberScans value="1" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<ExcludeMarkedBad value="1" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<ScansToSkip value="0" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<ScansToOmit value="0" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<MinScansPerBin value="30" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<MaxScansPerBin value="90" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<CastToProcess value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<IncludeSurfaceBin value="0" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<SurfaceBinMinVal value="0.000000" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<SurfaceBinMaxVal value="0.000000" /^> >>%PSA_1DB%\BinAvg.psa
echo ^<SurfaceBinVal value="0.000000" /^> >>%PSA_1DB%\BinAvg.psa
echo ^</Bin_Average^> >>%PSA_1DB%\BinAvg.psa
REM #### END BinAvg.psa ####

REM #### START CellTM.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1DB%\CellTM.psa
echo ^<Cell_Thermal_Mass ^> >>%PSA_1DB%\CellTM.psa
echo ^<Version value="7.21h" /^> >>%PSA_1DB%\CellTM.psa
echo ^<ServerName value="Cell Thermal Mass" /^> >>%PSA_1DB%\CellTM.psa
echo ^<InputDir value="Z:\Users\jhooper\Documents\Work_data\WBTS\ab1302\sbe_ctd\1db\proc_data" /^> >>%PSA_1DB%\CellTM.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1DB%\CellTM.psa
echo ^<ArrayItem index="0" value="ab1302_001.cnv" /^> >>%PSA_1DB%\CellTM.psa
echo ^</InputFileArray^> >>%PSA_1DB%\CellTM.psa
echo ^<OutputDir value="Z:\Users\jhooper\Documents\Work_data\WBTS\ab1302\sbe_ctd\1db\proc_data" /^> >>%PSA_1DB%\CellTM.psa
echo ^<NameAppend value="" /^> >>%PSA_1DB%\CellTM.psa
echo ^<OutputFile value="ab1302_001.cnv" /^> >>%PSA_1DB%\CellTM.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1DB%\CellTM.psa
echo ^<Primary ^> >>%PSA_1DB%\CellTM.psa
echo ^<Correct value="1" /^> >>%PSA_1DB%\CellTM.psa
echo ^<TempSensor value="0" /^> >>%PSA_1DB%\CellTM.psa
echo ^<TA_Amplitude value="0.030000" /^> >>%PSA_1DB%\CellTM.psa
echo ^<TA_TimeConstant value="7.000000" /^> >>%PSA_1DB%\CellTM.psa
echo ^</Primary^> >>%PSA_1DB%\CellTM.psa
echo ^<Secondary ^> >>%PSA_1DB%\CellTM.psa
echo ^<Correct value="1" /^> >>%PSA_1DB%\CellTM.psa
echo ^<TempSensor value="1" /^> >>%PSA_1DB%\CellTM.psa
echo ^<TA_Amplitude value="0.030000" /^> >>%PSA_1DB%\CellTM.psa
echo ^<TA_TimeConstant value="7.000000" /^> >>%PSA_1DB%\CellTM.psa
echo ^</Secondary^> >>%PSA_1DB%\CellTM.psa
echo ^</Cell_Thermal_Mass^> >>%PSA_1DB%\CellTM.psa
REM #### END CellTM.psa ####
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
REM #### START Derive.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1DB%\Derive.psa
echo ^<Derive ^> >>%PSA_1DB%\Derive.psa
echo ^<Version value="7.25.0.319" /^> >>%PSA_1DB%\Derive.psa
echo ^<ServerName value="Derive" /^> >>%PSA_1DB%\Derive.psa
echo ^<InstrumentPath value="Z:\Users\jhooper\Documents\Work_data\WBTS\ab1602\sbe_ctd\raw_data\ab1602_003.xmlcon" /^> >>%PSA_1DB%\Derive.psa
echo ^<InstrumentMatch value="0" /^> >>%PSA_1DB%\Derive.psa
echo ^<InputDir value="Z:\Users\jhooper\Documents\Work_data\WBTS\ab1602\sbe_ctd\1db\proc_data" /^> >>%PSA_1DB%\Derive.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1DB%\Derive.psa
echo ^<ArrayItem index="0" value="ab1602_003.cnv" /^> >>%PSA_1DB%\Derive.psa
echo ^</InputFileArray^> >>%PSA_1DB%\Derive.psa
echo ^<OutputDir value="Z:\Users\jhooper\Documents\Work_data\WBTS\ab1602\sbe_ctd\1db\proc_data" /^> >>%PSA_1DB%\Derive.psa
echo ^<NameAppend value="" /^> >>%PSA_1DB%\Derive.psa
echo ^<OutputFile value="ab1602_003.cnv" /^> >>%PSA_1DB%\Derive.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1DB%\Derive.psa
echo ^<CalcArray Size="11" ^> >>%PSA_1DB%\Derive.psa
echo ^<CalcArrayItem index="0" CalcID="55" ^> >>%PSA_1DB%\Derive.psa
echo ^<Calc UnitID="40" Ordinal="0" ^> >>%PSA_1DB%\Derive.psa
echo ^<FullName value="Oxygen, SBE 43 [ml/l]" /^> >>%PSA_1DB%\Derive.psa
echo ^<WindowSize value="5.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\Derive.psa
echo ^<ApplyTauCorrection value="0" /^> >>%PSA_1DB%\Derive.psa
echo ^</Calc^> >>%PSA_1DB%\Derive.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Derive.psa
echo ^<CalcArrayItem index="1" CalcID="55" ^> >>%PSA_1DB%\Derive.psa
echo ^<Calc UnitID="40" Ordinal="1" ^> >>%PSA_1DB%\Derive.psa
echo ^<FullName value="Oxygen, SBE 43, 2 [ml/l]" /^> >>%PSA_1DB%\Derive.psa
echo ^<WindowSize value="5.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\Derive.psa
echo ^<ApplyTauCorrection value="0" /^> >>%PSA_1DB%\Derive.psa
echo ^</Calc^> >>%PSA_1DB%\Derive.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Derive.psa
echo ^<CalcArrayItem index="2" CalcID="62" ^> >>%PSA_1DB%\Derive.psa
echo ^<Calc UnitID="6" Ordinal="0" ^> >>%PSA_1DB%\Derive.psa
echo ^<FullName value="Potential Temperature [ITS-90, deg C]" /^> >>%PSA_1DB%\Derive.psa
echo ^</Calc^> >>%PSA_1DB%\Derive.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Derive.psa
echo ^<CalcArrayItem index="3" CalcID="62" ^> >>%PSA_1DB%\Derive.psa
echo ^<Calc UnitID="6" Ordinal="1" ^> >>%PSA_1DB%\Derive.psa
echo ^<FullName value="Potential Temperature, 2 [ITS-90, deg C]" /^> >>%PSA_1DB%\Derive.psa
echo ^</Calc^> >>%PSA_1DB%\Derive.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Derive.psa
echo ^<CalcArrayItem index="4" CalcID="70" ^> >>%PSA_1DB%\Derive.psa
echo ^<Calc UnitID="49" Ordinal="0" ^> >>%PSA_1DB%\Derive.psa
echo ^<FullName value="Salinity, Practical [PSU]" /^> >>%PSA_1DB%\Derive.psa
echo ^</Calc^> >>%PSA_1DB%\Derive.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Derive.psa
echo ^<CalcArrayItem index="5" CalcID="70" ^> >>%PSA_1DB%\Derive.psa
echo ^<Calc UnitID="49" Ordinal="1" ^> >>%PSA_1DB%\Derive.psa
echo ^<FullName value="Salinity, Practical, 2 [PSU]" /^> >>%PSA_1DB%\Derive.psa
echo ^</Calc^> >>%PSA_1DB%\Derive.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Derive.psa
echo ^<CalcArrayItem index="6" CalcID="15" ^> >>%PSA_1DB%\Derive.psa
echo ^<Calc UnitID="53" Ordinal="0" ^> >>%PSA_1DB%\Derive.psa
echo ^<FullName value="Density [sigma-theta, kg/m^3]" /^> >>%PSA_1DB%\Derive.psa
echo ^</Calc^> >>%PSA_1DB%\Derive.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Derive.psa
echo ^<CalcArrayItem index="7" CalcID="15" ^> >>%PSA_1DB%\Derive.psa
echo ^<Calc UnitID="53" Ordinal="1" ^> >>%PSA_1DB%\Derive.psa
echo ^<FullName value="Density, 2 [sigma-theta, kg/m^3]" /^> >>%PSA_1DB%\Derive.psa
echo ^</Calc^> >>%PSA_1DB%\Derive.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Derive.psa
echo ^<CalcArrayItem index="8" CalcID="2" ^> >>%PSA_1DB%\Derive.psa
echo ^<Calc UnitID="33" Ordinal="0" ^> >>%PSA_1DB%\Derive.psa
echo ^<FullName value="Average Sound Velocity [Chen-Millero, m/s]" /^> >>%PSA_1DB%\Derive.psa
echo ^<Latitude value="26.500000" /^> >>%PSA_1DB%\Derive.psa
echo ^<MinPressure value="20.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^<MinSalinity value="20.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^<PressureWindowSize value="20.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^<TimeWindowSize value="60.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^</Calc^> >>%PSA_1DB%\Derive.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Derive.psa
echo ^<CalcArrayItem index="9" CalcID="55" ^> >>%PSA_1DB%\Derive.psa
echo ^<Calc UnitID="61" Ordinal="0" ^> >>%PSA_1DB%\Derive.psa
echo ^<FullName value="Oxygen, SBE 43 [umol/kg]" /^> >>%PSA_1DB%\Derive.psa
echo ^<WindowSize value="5.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\Derive.psa
echo ^<ApplyTauCorrection value="0" /^> >>%PSA_1DB%\Derive.psa
echo ^</Calc^> >>%PSA_1DB%\Derive.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Derive.psa
echo ^<CalcArrayItem index="10" CalcID="55" ^> >>%PSA_1DB%\Derive.psa
echo ^<Calc UnitID="61" Ordinal="1" ^> >>%PSA_1DB%\Derive.psa
echo ^<FullName value="Oxygen, SBE 43, 2 [umol/kg]" /^> >>%PSA_1DB%\Derive.psa
echo ^<WindowSize value="5.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\Derive.psa
echo ^<ApplyTauCorrection value="0" /^> >>%PSA_1DB%\Derive.psa
echo ^</Calc^> >>%PSA_1DB%\Derive.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Derive.psa
echo ^</CalcArray^> >>%PSA_1DB%\Derive.psa
echo ^<MiscellaneousDataForCalculations ^> >>%PSA_1DB%\Derive.psa
echo ^<Latitude value="26.500000" /^> >>%PSA_1DB%\Derive.psa
echo ^<Longitude value="0.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^<DescentRateAndAcceleration ^> >>%PSA_1DB%\Derive.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^</DescentRateAndAcceleration^> >>%PSA_1DB%\Derive.psa
echo ^<Oxygen ^> >>%PSA_1DB%\Derive.psa
echo ^<WindowSize value="5.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\Derive.psa
echo ^<ApplyTauCorrection value="0" /^> >>%PSA_1DB%\Derive.psa
echo ^</Oxygen^> >>%PSA_1DB%\Derive.psa
echo ^<AverageSoundVelocity ^> >>%PSA_1DB%\Derive.psa
echo ^<MinimumPressure value="20.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^<MinimumSalinity value="20.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^<PressureWindowSize value="20.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^<TimeWindowSize value="60.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^</AverageSoundVelocity^> >>%PSA_1DB%\Derive.psa
echo ^<PlumeAnomaly ^> >>%PSA_1DB%\Derive.psa
echo ^<ThetaB value="0.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^<SalinityB value="0.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^<ThetaZSalinityZRatio value="0.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^<ReferencePressure value="0.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^</PlumeAnomaly^> >>%PSA_1DB%\Derive.psa
echo ^<PotentialTempAnomaly ^> >>%PSA_1DB%\Derive.psa
echo ^<A0 value="0.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^<A1 value="0.000000" /^> >>%PSA_1DB%\Derive.psa
echo ^<A1Multiplier value="0" /^> >>%PSA_1DB%\Derive.psa
echo ^</PotentialTempAnomaly^> >>%PSA_1DB%\Derive.psa
echo ^</MiscellaneousDataForCalculations^> >>%PSA_1DB%\Derive.psa
echo ^</Derive^> >>%PSA_1DB%\Derive.psa
REM #### END Derive.psa ####
REM #### START Filter.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1DB%\Filter.psa
echo ^<Filter ^> >>%PSA_1DB%\Filter.psa
echo ^<Version value="7.21h" /^> >>%PSA_1DB%\Filter.psa
echo ^<ServerName value="Filter" /^> >>%PSA_1DB%\Filter.psa
echo ^<InputDir value="Z:\Users\jhooper\Documents\Work_Data\WBTS\ab1403\sbe_ctd\1db\proc_data" /^> >>%PSA_1DB%\Filter.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1DB%\Filter.psa
echo ^<ArrayItem index="0" value="ab1403_002.cnv" /^> >>%PSA_1DB%\Filter.psa
echo ^</InputFileArray^> >>%PSA_1DB%\Filter.psa
echo ^<OutputDir value="Z:\Users\jhooper\Documents\Work_Data\WBTS\ab1403\sbe_ctd\1db\proc_data" /^> >>%PSA_1DB%\Filter.psa
echo ^<NameAppend value="" /^> >>%PSA_1DB%\Filter.psa
echo ^<OutputFile value="ab1403_002.cnv" /^> >>%PSA_1DB%\Filter.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1DB%\Filter.psa
echo ^<TimeConstFilterA value="0.030000" /^> >>%PSA_1DB%\Filter.psa
echo ^<TimeConstFilterB value="0.150000" /^> >>%PSA_1DB%\Filter.psa
echo ^<CalcArray Size="13" ^> >>%PSA_1DB%\Filter.psa
echo ^<CalcArrayItem index="0" CalcID="17" ^> >>%PSA_1DB%\Filter.psa
echo ^<Calc UnitID="31" Ordinal="0" ^> >>%PSA_1DB%\Filter.psa
echo ^<FullName value="Depth [salt water, m]" /^> >>%PSA_1DB%\Filter.psa
echo ^<Latitude value="0.000000" /^> >>%PSA_1DB%\Filter.psa
echo ^</Calc^> >>%PSA_1DB%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Filter.psa
echo ^<CalcArrayItem index="1" CalcID="65" ^> >>%PSA_1DB%\Filter.psa
echo ^<Calc UnitID="3" Ordinal="0" ^> >>%PSA_1DB%\Filter.psa
echo ^<FullName value="Pressure, Digiquartz [db]" /^> >>%PSA_1DB%\Filter.psa
echo ^</Calc^> >>%PSA_1DB%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Filter.psa
echo ^<CalcArrayItem index="2" CalcID="81" ^> >>%PSA_1DB%\Filter.psa
echo ^<Calc UnitID="6" Ordinal="0" ^> >>%PSA_1DB%\Filter.psa
echo ^<FullName value="Temperature [ITS-90, deg C]" /^> >>%PSA_1DB%\Filter.psa
echo ^</Calc^> >>%PSA_1DB%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Filter.psa
echo ^<CalcArrayItem index="3" CalcID="81" ^> >>%PSA_1DB%\Filter.psa
echo ^<Calc UnitID="6" Ordinal="1" ^> >>%PSA_1DB%\Filter.psa
echo ^<FullName value="Temperature, 2 [ITS-90, deg C]" /^> >>%PSA_1DB%\Filter.psa
echo ^</Calc^> >>%PSA_1DB%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Filter.psa
echo ^<CalcArrayItem index="4" CalcID="12" ^> >>%PSA_1DB%\Filter.psa
echo ^<Calc UnitID="58" Ordinal="0" ^> >>%PSA_1DB%\Filter.psa
echo ^<FullName value="Conductivity [S/m]" /^> >>%PSA_1DB%\Filter.psa
echo ^</Calc^> >>%PSA_1DB%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Filter.psa
echo ^<CalcArrayItem index="5" CalcID="12" ^> >>%PSA_1DB%\Filter.psa
echo ^<Calc UnitID="58" Ordinal="1" ^> >>%PSA_1DB%\Filter.psa
echo ^<FullName value="Conductivity, 2 [S/m]" /^> >>%PSA_1DB%\Filter.psa
echo ^</Calc^> >>%PSA_1DB%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Filter.psa
echo ^<CalcArrayItem index="6" CalcID="57" ^> >>%PSA_1DB%\Filter.psa
echo ^<Calc UnitID="63" Ordinal="0" ^> >>%PSA_1DB%\Filter.psa
echo ^<FullName value="Oxygen raw, SBE 43 [V]" /^> >>%PSA_1DB%\Filter.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\Filter.psa
echo ^</Calc^> >>%PSA_1DB%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Filter.psa
echo ^<CalcArrayItem index="7" CalcID="57" ^> >>%PSA_1DB%\Filter.psa
echo ^<Calc UnitID="63" Ordinal="1" ^> >>%PSA_1DB%\Filter.psa
echo ^<FullName value="Oxygen raw, SBE 43, 2 [V]" /^> >>%PSA_1DB%\Filter.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\Filter.psa
echo ^</Calc^> >>%PSA_1DB%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Filter.psa
echo ^<CalcArrayItem index="8" CalcID="1" ^> >>%PSA_1DB%\Filter.psa
echo ^<Calc UnitID="29" Ordinal="0" ^> >>%PSA_1DB%\Filter.psa
echo ^<FullName value="Altimeter [m]" /^> >>%PSA_1DB%\Filter.psa
echo ^</Calc^> >>%PSA_1DB%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Filter.psa
echo ^<CalcArrayItem index="9" CalcID="39" ^> >>%PSA_1DB%\Filter.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1DB%\Filter.psa
echo ^<FullName value="Latitude [deg]" /^> >>%PSA_1DB%\Filter.psa
echo ^</Calc^> >>%PSA_1DB%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Filter.psa
echo ^<CalcArrayItem index="10" CalcID="40" ^> >>%PSA_1DB%\Filter.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1DB%\Filter.psa
echo ^<FullName value="Longitude [deg]" /^> >>%PSA_1DB%\Filter.psa
echo ^</Calc^> >>%PSA_1DB%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Filter.psa
echo ^<CalcArrayItem index="11" CalcID="55" ^> >>%PSA_1DB%\Filter.psa
echo ^<Calc UnitID="68" Ordinal="0" ^> >>%PSA_1DB%\Filter.psa
echo ^<FullName value="Oxygen, SBE 43 [dov/dt]" /^> >>%PSA_1DB%\Filter.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1DB%\Filter.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\Filter.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1DB%\Filter.psa
echo ^</Calc^> >>%PSA_1DB%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Filter.psa
echo ^<CalcArrayItem index="12" CalcID="55" ^> >>%PSA_1DB%\Filter.psa
echo ^<Calc UnitID="68" Ordinal="1" ^> >>%PSA_1DB%\Filter.psa
echo ^<FullName value="Oxygen, SBE 43, 2 [dov/dt]" /^> >>%PSA_1DB%\Filter.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1DB%\Filter.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\Filter.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1DB%\Filter.psa
echo ^</Calc^> >>%PSA_1DB%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Filter.psa
echo ^</CalcArray^> >>%PSA_1DB%\Filter.psa
echo ^<FilterTypeArray ^> >>%PSA_1DB%\Filter.psa
echo ^<ArrayItem index="0" value="2" /^> >>%PSA_1DB%\Filter.psa
echo ^<ArrayItem index="1" value="2" /^> >>%PSA_1DB%\Filter.psa
echo ^<ArrayItem index="2" value="0" /^> >>%PSA_1DB%\Filter.psa
echo ^<ArrayItem index="3" value="0" /^> >>%PSA_1DB%\Filter.psa
echo ^<ArrayItem index="4" value="0" /^> >>%PSA_1DB%\Filter.psa
echo ^<ArrayItem index="5" value="0" /^> >>%PSA_1DB%\Filter.psa
echo ^<ArrayItem index="6" value="0" /^> >>%PSA_1DB%\Filter.psa
echo ^<ArrayItem index="7" value="0" /^> >>%PSA_1DB%\Filter.psa
echo ^<ArrayItem index="8" value="0" /^> >>%PSA_1DB%\Filter.psa
echo ^<ArrayItem index="9" value="1" /^> >>%PSA_1DB%\Filter.psa
echo ^<ArrayItem index="10" value="1" /^> >>%PSA_1DB%\Filter.psa
echo ^<ArrayItem index="11" value="1" /^> >>%PSA_1DB%\Filter.psa
echo ^<ArrayItem index="12" value="1" /^> >>%PSA_1DB%\Filter.psa
echo ^</FilterTypeArray^> >>%PSA_1DB%\Filter.psa
echo ^</Filter^> >>%PSA_1DB%\Filter.psa
REM #### END Filter.psa ####
REM #### START LoopEdit.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1DB%\LoopEdit.psa
echo ^<Loop_Edit ^> >>%PSA_1DB%\LoopEdit.psa
echo ^<Version value="7.21h" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^<ServerName value="Loop Edit" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^<InputDir value="C:\Data\Cruises\ctd\gomecc2\1db\proc_data" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1DB%\LoopEdit.psa
echo ^<ArrayItem index="0" value="rv1203_001.cnv" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^</InputFileArray^> >>%PSA_1DB%\LoopEdit.psa
echo ^<OutputDir value="C:\Data\Cruises\ctd\gomecc2\1db\proc_data" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^<NameAppend value="" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^<OutputFile value="rv1203_001.cnv" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^<MinVelocityType value="0" high="1" low="0" initialValue="0" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^<MinCTD_Velocity value="0.250000" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^<TimeWindowSize value="300.000000" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^<PercentMeanSpeed value="20.000000" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^<ExcludeMarkedBad value="1" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^<RemoveSurfaceSoak value="1" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^<UseDeckPressure value="1" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^<SurfaceSoakDepth value="10.000000" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^<SurfaceSoakDepthMin value="5.000000" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^<SurfaceSoakDepthMax value="20.000000" /^> >>%PSA_1DB%\LoopEdit.psa
echo ^</Loop_Edit^> >>%PSA_1DB%\LoopEdit.psa
REM #### END LoopEdit.psa ####
REM #### START MarkScan.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1DB%\MarkScan.psa
echo ^<Mark_Scan ^> >>%PSA_1DB%\MarkScan.psa
echo ^<Version value="7.23.1" /^> >>%PSA_1DB%\MarkScan.psa
echo ^<ServerName value="Mark Scan" /^> >>%PSA_1DB%\MarkScan.psa
echo ^<InputDir value="Z:\Users\james.hooper" /^> >>%PSA_1DB%\MarkScan.psa
echo ^<InputFileArray size="0" GrowBy="-1" /^> >>%PSA_1DB%\MarkScan.psa
echo ^<OutputDir value="Z:\Users\james.hooper" /^> >>%PSA_1DB%\MarkScan.psa
echo ^<NameAppend value="" /^> >>%PSA_1DB%\MarkScan.psa
echo ^<OutputFile value="" /^> >>%PSA_1DB%\MarkScan.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1DB%\MarkScan.psa
echo ^<Offset value="-5" /^> >>%PSA_1DB%\MarkScan.psa
echo ^<Duration value="10" /^> >>%PSA_1DB%\MarkScan.psa
echo ^</Mark_Scan^> >>%PSA_1DB%\MarkScan.psa
REM #### END MarkScan.psa ####
REM #### START SeaPlot.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1DB%\SeaPlot.psa
echo ^<Sea_Plot ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Version value="7.21h" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ServerName value="Sea Plot" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<InputDir value="C:\Data\Cruises\ctd\gomecc2\1db\proc_data" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ArrayItem index="0" value="drv1203_001.cnv" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</InputFileArray^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputType value="0" high="3" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputDir value="C:\Data\Cruises\ctd\gomecc2\1db\proc_data" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<NameAppend value="" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputFile value="drv1203_001" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<PrintSetup ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Orientation value="1" high="2" low="0" initialValue="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<PrintFullPage value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputUnits value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputWidth value="201.500000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputHeight value="115.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</PrintSetup^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MetafileSetup ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputUnits value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputWidth value="201.500000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputHeight value="115.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</MetafileSetup^> >>%PSA_1DB%\SeaPlot.psa
echo ^<JpegSetup ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputWidth value="720" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputHeight value="411" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</JpegSetup^> >>%PSA_1DB%\SeaPlot.psa
echo ^<BitmapSetup ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputWidth value="720" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputHeight value="411" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</BitmapSetup^> >>%PSA_1DB%\SeaPlot.psa
echo ^<PlotType value="2" high="5" low="0" initialValue="2" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Title value="" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AddFileName value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<TitleColor value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FontType value="Arial" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FontSize value="2" high="2" low="0" initialValue="2" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<GridLine value="3" high="3" low="0" initialValue="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<GridStyle value="0" high="3" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<GridInFront value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<InsideBackColor value="16777215" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutsideBackColor value="16777215" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<SymbolSize value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<SymbolFrequency value="6" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MonchromePlot value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<PlotSymbolsOnly value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ShowLineLegends value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MarkDataPoints value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ShowPlotShadow value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<BlackTextAxes value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoRangePadding value="5" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ProcessScansToEnd value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ScansToProcess value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<SkipAtStart value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<SkipBetweenPoints value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<PlotBadScans value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LiftPenOverBadData value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<PrintSizeFrom value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Axis index="0" ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<IncludeAxis value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<CalcID value="65" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Calc UnitID="3" Ordinal="0" ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FullName value="Pressure, Digiquartz [db]" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</Calc^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Derived value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ShowDateTime value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ConvertSystemTimeToLocalTime value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoLabel value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<CustomLabel value="" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineType value="0" high="11" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineColor value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineSymbol value="3" high="13" low="0" initialValue="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LinearScale value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoRange value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FixedMinimum value="0.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FixedMaximum value="10.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoDivisions value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MajorDivisions value="4" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MinorDivisions value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ReverseScale value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<DupCnt value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</Axis^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Axis index="1" ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<IncludeAxis value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<CalcID value="12" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Calc UnitID="58" Ordinal="0" ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FullName value="Conductivity [S/m]" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</Calc^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Derived value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ShowDateTime value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ConvertSystemTimeToLocalTime value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoLabel value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<CustomLabel value="" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineType value="0" high="11" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineColor value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineSymbol value="3" high="13" low="0" initialValue="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LinearScale value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoRange value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FixedMinimum value="0.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FixedMaximum value="10.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoDivisions value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MajorDivisions value="4" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MinorDivisions value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ReverseScale value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<DupCnt value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</Axis^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Axis index="2" ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<IncludeAxis value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<CalcID value="12" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Calc UnitID="58" Ordinal="1" ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FullName value="Conductivity, 2 [S/m]" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</Calc^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Derived value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ShowDateTime value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ConvertSystemTimeToLocalTime value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoLabel value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<CustomLabel value="" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineType value="0" high="11" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineColor value="8388608" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineSymbol value="9" high="13" low="0" initialValue="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LinearScale value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoRange value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FixedMinimum value="0.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FixedMaximum value="10.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoDivisions value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MajorDivisions value="4" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MinorDivisions value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ReverseScale value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<DupCnt value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</Axis^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Axis index="3" ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<IncludeAxis value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<CalcID value="55" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Calc UnitID="61" Ordinal="0" ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FullName value="Oxygen, SBE 43 [umol/Kg]" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</Calc^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Derived value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ShowDateTime value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ConvertSystemTimeToLocalTime value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoLabel value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<CustomLabel value="" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineType value="0" high="11" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineColor value="128" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineSymbol value="5" high="13" low="0" initialValue="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LinearScale value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoRange value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FixedMinimum value="0.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FixedMaximum value="10.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoDivisions value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MajorDivisions value="4" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MinorDivisions value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ReverseScale value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<DupCnt value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</Axis^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Axis index="4" ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<IncludeAxis value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<CalcID value="55" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Calc UnitID="61" Ordinal="1" ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FullName value="Oxygen, SBE 43, 2 [umol/Kg]" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</Calc^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Derived value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ShowDateTime value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ConvertSystemTimeToLocalTime value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoLabel value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<CustomLabel value="" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineType value="0" high="11" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineColor value="8388736" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineSymbol value="11" high="13" low="0" initialValue="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LinearScale value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoRange value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FixedMinimum value="0.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FixedMaximum value="10.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoDivisions value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MajorDivisions value="4" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MinorDivisions value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ReverseScale value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<DupCnt value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</Axis^> >>%PSA_1DB%\SeaPlot.psa
echo ^<PrintOptionsView ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Orientation value="1" high="2" low="0" initialValue="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<PrintFullPage value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputUnits value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputWidth value="201.500000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputHeight value="115.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</PrintOptionsView^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FileOptionsView ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<DataFormat value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MetafileSizeFrom value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<JpegSizeFrom value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<bitmapSizeFrom value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MetafileView ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputUnits value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputWidth value="201.500000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputHeight value="115.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</MetafileView^> >>%PSA_1DB%\SeaPlot.psa
echo ^<JpegView ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputWidth value="720" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputHeight value="411" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</JpegView^> >>%PSA_1DB%\SeaPlot.psa
echo ^<BitmapView ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputWidth value="720" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputHeight value="411" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</BitmapView^> >>%PSA_1DB%\SeaPlot.psa
echo ^</FileOptionsView^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ClipOptionsView ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<DataFormat value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MetafileSizeFrom value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<JpegSizeFrom value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<bitmapSizeFrom value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MetafileView ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputUnits value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputWidth value="201.500000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputHeight value="115.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</MetafileView^> >>%PSA_1DB%\SeaPlot.psa
echo ^<JpegView ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputWidth value="720" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputHeight value="411" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</JpegView^> >>%PSA_1DB%\SeaPlot.psa
echo ^<BitmapView ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputWidth value="720" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OutputHeight value="411" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</BitmapView^> >>%PSA_1DB%\SeaPlot.psa
echo ^</ClipOptionsView^> >>%PSA_1DB%\SeaPlot.psa
echo ^<OverlaySetup ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Offset ColumnIndex="0" Offset="0.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Offset ColumnIndex="1" Offset="0.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Offset ColumnIndex="2" Offset="0.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Offset ColumnIndex="3" Offset="0.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorArray ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="0" Row="0" Col="0" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="1" Row="0" Col="1" Value="8388608" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="2" Row="0" Col="2" Value="128" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="3" Row="0" Col="3" Value="8388736" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="4" Row="0" Col="4" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="5" Row="1" Col="0" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="6" Row="1" Col="1" Value="8388608" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="7" Row="1" Col="2" Value="128" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="8" Row="1" Col="3" Value="8388736" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="9" Row="1" Col="4" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="10" Row="2" Col="0" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="11" Row="2" Col="1" Value="8388608" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="12" Row="2" Col="2" Value="128" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="13" Row="2" Col="3" Value="8388736" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="14" Row="2" Col="4" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="15" Row="3" Col="0" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="16" Row="3" Col="1" Value="8388608" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="17" Row="3" Col="2" Value="128" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="18" Row="3" Col="3" Value="8388736" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="19" Row="3" Col="4" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="20" Row="4" Col="0" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="21" Row="4" Col="1" Value="8388608" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="22" Row="4" Col="2" Value="128" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="23" Row="4" Col="3" Value="8388736" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="24" Row="4" Col="4" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="25" Row="5" Col="0" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="26" Row="5" Col="1" Value="8388608" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="27" Row="5" Col="2" Value="128" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="28" Row="5" Col="3" Value="8388736" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="29" Row="5" Col="4" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="30" Row="6" Col="0" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="31" Row="6" Col="1" Value="8388608" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="32" Row="6" Col="2" Value="128" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="33" Row="6" Col="3" Value="8388736" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="34" Row="6" Col="4" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="35" Row="7" Col="0" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="36" Row="7" Col="1" Value="8388608" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="37" Row="7" Col="2" Value="128" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="38" Row="7" Col="3" Value="8388736" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="39" Row="7" Col="4" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="40" Row="8" Col="0" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="41" Row="8" Col="1" Value="8388608" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="42" Row="8" Col="2" Value="128" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="43" Row="8" Col="3" Value="8388736" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="44" Row="8" Col="4" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="45" Row="9" Col="0" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="46" Row="9" Col="1" Value="8388608" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="47" Row="9" Col="2" Value="128" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="48" Row="9" Col="3" Value="8388736" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color index="49" Row="9" Col="4" Value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</ColorArray^> >>%PSA_1DB%\SeaPlot.psa
echo ^<SymbolArray ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="0" Row="0" Col="0" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="1" Row="0" Col="1" Value="9" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="2" Row="0" Col="2" Value="5" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="3" Row="0" Col="3" Value="11" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="4" Row="0" Col="4" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="5" Row="1" Col="0" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="6" Row="1" Col="1" Value="9" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="7" Row="1" Col="2" Value="5" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="8" Row="1" Col="3" Value="11" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="9" Row="1" Col="4" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="10" Row="2" Col="0" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="11" Row="2" Col="1" Value="9" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="12" Row="2" Col="2" Value="5" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="13" Row="2" Col="3" Value="11" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="14" Row="2" Col="4" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="15" Row="3" Col="0" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="16" Row="3" Col="1" Value="9" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="17" Row="3" Col="2" Value="5" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="18" Row="3" Col="3" Value="11" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="19" Row="3" Col="4" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="20" Row="4" Col="0" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="21" Row="4" Col="1" Value="9" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="22" Row="4" Col="2" Value="5" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="23" Row="4" Col="3" Value="11" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="24" Row="4" Col="4" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="25" Row="5" Col="0" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="26" Row="5" Col="1" Value="9" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="27" Row="5" Col="2" Value="5" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="28" Row="5" Col="3" Value="11" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="29" Row="5" Col="4" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="30" Row="6" Col="0" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="31" Row="6" Col="1" Value="9" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="32" Row="6" Col="2" Value="5" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="33" Row="6" Col="3" Value="11" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="34" Row="6" Col="4" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="35" Row="7" Col="0" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="36" Row="7" Col="1" Value="9" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="37" Row="7" Col="2" Value="5" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="38" Row="7" Col="3" Value="11" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="39" Row="7" Col="4" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="40" Row="8" Col="0" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="41" Row="8" Col="1" Value="9" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="42" Row="8" Col="2" Value="5" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="43" Row="8" Col="3" Value="11" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="44" Row="8" Col="4" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="45" Row="9" Col="0" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="46" Row="9" Col="1" Value="9" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="47" Row="9" Col="2" Value="5" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="48" Row="9" Col="3" Value="11" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Symbol index="49" Row="9" Col="4" Value="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</SymbolArray^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineArray ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="0" Row="0" Col="0" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="1" Row="0" Col="1" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="2" Row="0" Col="2" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="3" Row="0" Col="3" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="4" Row="0" Col="4" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="5" Row="1" Col="0" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="6" Row="1" Col="1" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="7" Row="1" Col="2" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="8" Row="1" Col="3" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="9" Row="1" Col="4" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="10" Row="2" Col="0" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="11" Row="2" Col="1" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="12" Row="2" Col="2" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="13" Row="2" Col="3" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="14" Row="2" Col="4" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="15" Row="3" Col="0" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="16" Row="3" Col="1" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="17" Row="3" Col="2" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="18" Row="3" Col="3" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="19" Row="3" Col="4" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="20" Row="4" Col="0" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="21" Row="4" Col="1" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="22" Row="4" Col="2" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="23" Row="4" Col="3" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="24" Row="4" Col="4" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="25" Row="5" Col="0" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="26" Row="5" Col="1" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="27" Row="5" Col="2" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="28" Row="5" Col="3" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="29" Row="5" Col="4" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="30" Row="6" Col="0" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="31" Row="6" Col="1" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="32" Row="6" Col="2" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="33" Row="6" Col="3" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="34" Row="6" Col="4" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="35" Row="7" Col="0" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="36" Row="7" Col="1" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="37" Row="7" Col="2" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="38" Row="7" Col="3" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="39" Row="7" Col="4" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="40" Row="8" Col="0" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="41" Row="8" Col="1" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="42" Row="8" Col="2" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="43" Row="8" Col="3" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="44" Row="8" Col="4" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="45" Row="9" Col="0" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="46" Row="9" Col="1" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="47" Row="9" Col="2" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="48" Row="9" Col="3" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Line index="49" Row="9" Col="4" Value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</LineArray^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorWheelSetupColumnArray ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorWheelSetup index="0" StartRadian="0.000000" EndRadian="1.570796" Brightness="11" Clockwise="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorWheelSetup index="1" StartRadian="0.000000" EndRadian="1.570796" Brightness="11" Clockwise="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorWheelSetup index="2" StartRadian="0.000000" EndRadian="1.570796" Brightness="11" Clockwise="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorWheelSetup index="3" StartRadian="0.000000" EndRadian="1.570796" Brightness="11" Clockwise="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorWheelSetup index="4" StartRadian="0.000000" EndRadian="1.570796" Brightness="11" Clockwise="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</ColorWheelSetupColumnArray^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorWheelSetupRowArray ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorWheelSetup index="0" StartRadian="0.000000" EndRadian="1.570796" Brightness="11" Clockwise="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorWheelSetup index="1" StartRadian="0.000000" EndRadian="1.570796" Brightness="11" Clockwise="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorWheelSetup index="2" StartRadian="0.000000" EndRadian="1.570796" Brightness="11" Clockwise="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorWheelSetup index="3" StartRadian="0.000000" EndRadian="1.570796" Brightness="11" Clockwise="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorWheelSetup index="4" StartRadian="0.000000" EndRadian="1.570796" Brightness="11" Clockwise="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorWheelSetup index="5" StartRadian="0.000000" EndRadian="1.570796" Brightness="11" Clockwise="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorWheelSetup index="6" StartRadian="0.000000" EndRadian="1.570796" Brightness="11" Clockwise="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorWheelSetup index="7" StartRadian="0.000000" EndRadian="1.570796" Brightness="11" Clockwise="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorWheelSetup index="8" StartRadian="0.000000" EndRadian="1.570796" Brightness="11" Clockwise="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ColorWheelSetup index="9" StartRadian="0.000000" EndRadian="1.570796" Brightness="11" Clockwise="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</ColorWheelSetupRowArray^> >>%PSA_1DB%\SeaPlot.psa
echo ^<HighlightColor value="65535" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<HighlightSymbol value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</OverlaySetup^> >>%PSA_1DB%\SeaPlot.psa
echo ^<TS_PlotSetup ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Variable value="0" high="1" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Start value="0.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Interval value="1.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<SigDigits value="2" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<PointsPerLine value="40" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LabelPositionPct value="5.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LabelSize value="8" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineType value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Color value="8388608" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Axis index="0" ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<IncludeAxis value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<CalcID value="81" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Calc UnitID="6" Ordinal="0" ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FullName value="Temperature [ITS-90, deg C]" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</Calc^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Derived value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ShowDateTime value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ConvertSystemTimeToLocalTime value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoLabel value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<CustomLabel value="" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineType value="0" high="11" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineColor value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineSymbol value="3" high="13" low="0" initialValue="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LinearScale value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoRange value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FixedMinimum value="0.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FixedMaximum value="10.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoDivisions value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MajorDivisions value="4" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MinorDivisions value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ReverseScale value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<DupCnt value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</Axis^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Axis index="1" ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<IncludeAxis value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<CalcID value="70" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Calc UnitID="49" Ordinal="0" ^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FullName value="Salinity, Practical [PSU]" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</Calc^> >>%PSA_1DB%\SeaPlot.psa
echo ^<Derived value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ShowDateTime value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ConvertSystemTimeToLocalTime value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoLabel value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<CustomLabel value="" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineType value="0" high="11" low="0" initialValue="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineColor value="32768" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LineSymbol value="3" high="13" low="0" initialValue="3" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<LinearScale value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoRange value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FixedMinimum value="0.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<FixedMaximum value="10.000000" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<AutoDivisions value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MajorDivisions value="4" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<MinorDivisions value="1" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<ReverseScale value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^<DupCnt value="0" /^> >>%PSA_1DB%\SeaPlot.psa
echo ^</Axis^> >>%PSA_1DB%\SeaPlot.psa
echo ^</TS_PlotSetup^> >>%PSA_1DB%\SeaPlot.psa
echo ^</Sea_Plot^> >>%PSA_1DB%\SeaPlot.psa
REM #### END SeaPlot.psa ####
REM #### START Split.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1DB%\Split.psa
echo ^<Split ^> >>%PSA_1DB%\Split.psa
echo ^<Version value="7.21h" /^> >>%PSA_1DB%\Split.psa
echo ^<ServerName value="Split" /^> >>%PSA_1DB%\Split.psa
echo ^<InputDir value="C:\Data\Cruises\ctd\gomecc2\1db\proc_data" /^> >>%PSA_1DB%\Split.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1DB%\Split.psa
echo ^<ArrayItem index="0" value="rv1203_001.cnv" /^> >>%PSA_1DB%\Split.psa
echo ^</InputFileArray^> >>%PSA_1DB%\Split.psa
echo ^<OutputDir value="C:\Data\Cruises\ctd\gomecc2\1db\proc_data" /^> >>%PSA_1DB%\Split.psa
echo ^<NameAppend value="" /^> >>%PSA_1DB%\Split.psa
echo ^<OutputFile value="rv1203_001.cnv" /^> >>%PSA_1DB%\Split.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1DB%\Split.psa
echo ^<OutputFiles value="0" high="1" low="0" initialValue="0" /^> >>%PSA_1DB%\Split.psa
echo ^<ExcludeMarkedBad value="1" /^> >>%PSA_1DB%\Split.psa
echo ^</Split^> >>%PSA_1DB%\Split.psa
REM #### END Split.psa ####
REM #### START Strip.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1DB%\Strip.psa
echo ^<Strip ^> >>%PSA_1DB%\Strip.psa
echo ^<Version value="7.21h" /^> >>%PSA_1DB%\Strip.psa
echo ^<ServerName value="Strip" /^> >>%PSA_1DB%\Strip.psa
echo ^<InputDir value="Z:\Users\jhooper\Documents\Work_Data\WBTS\ab1403\sbe_ctd\1db\proc_data" /^> >>%PSA_1DB%\Strip.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="0" value="ab1403_001.cnv" /^> >>%PSA_1DB%\Strip.psa
echo ^</InputFileArray^> >>%PSA_1DB%\Strip.psa
echo ^<OutputDir value="Z:\Users\jhooper\Documents\Work_Data\WBTS\ab1403\sbe_ctd\1db\proc_data" /^> >>%PSA_1DB%\Strip.psa
echo ^<NameAppend value="" /^> >>%PSA_1DB%\Strip.psa
echo ^<OutputFile value="ab1403_001.cnv" /^> >>%PSA_1DB%\Strip.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArray Size="27" ^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="0" CalcID="72" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="-1" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Scan Count" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="1" CalcID="84" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="52" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Time, Elapsed [seconds]" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="2" CalcID="17" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="31" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Depth [salt water, m]" /^> >>%PSA_1DB%\Strip.psa
echo ^<Latitude value="0.000000" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="3" CalcID="65" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="3" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Pressure, Digiquartz [db]" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="4" CalcID="81" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="6" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Temperature [ITS-90, deg C]" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="5" CalcID="81" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="6" Ordinal="1" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Temperature, 2 [ITS-90, deg C]" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="6" CalcID="12" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="58" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Conductivity [S/m]" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="7" CalcID="12" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="58" Ordinal="1" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Conductivity, 2 [S/m]" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="8" CalcID="57" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="63" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Oxygen raw, SBE 43 [V]" /^> >>%PSA_1DB%\Strip.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="9" CalcID="57" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="63" Ordinal="1" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Oxygen raw, SBE 43, 2 [V]" /^> >>%PSA_1DB%\Strip.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="10" CalcID="1" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="29" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Altimeter [m]" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="11" CalcID="39" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Latitude [deg]" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="12" CalcID="40" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Longitude [deg]" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="13" CalcID="55" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="68" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Oxygen, SBE 43 [dov/dt]" /^> >>%PSA_1DB%\Strip.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1DB%\Strip.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="14" CalcID="55" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="68" Ordinal="1" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Oxygen, SBE 43, 2 [dov/dt]" /^> >>%PSA_1DB%\Strip.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1DB%\Strip.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="15" CalcID="55" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="40" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Oxygen, SBE 43 [ml/l]" /^> >>%PSA_1DB%\Strip.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1DB%\Strip.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="16" CalcID="55" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="40" Ordinal="1" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Oxygen, SBE 43, 2 [ml/l]" /^> >>%PSA_1DB%\Strip.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1DB%\Strip.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="17" CalcID="62" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="6" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Potential Temperature [ITS-90, deg C]" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="18" CalcID="62" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="6" Ordinal="1" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Potential Temperature, 2 [ITS-90, deg C]" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="19" CalcID="70" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="49" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Salinity, Practical [PSU]" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="20" CalcID="70" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="49" Ordinal="1" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Salinity, Practical, 2 [PSU]" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="21" CalcID="15" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="53" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Density [sigma-theta, Kg/m^3]" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="22" CalcID="15" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="53" Ordinal="1" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Density, 2 [sigma-theta, Kg/m^3]" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="23" CalcID="2" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="33" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Average Sound Velocity [Chen-Millero, m/s]" /^> >>%PSA_1DB%\Strip.psa
echo ^<Latitude value="0.000000" /^> >>%PSA_1DB%\Strip.psa
echo ^<MinPressure value="20.000000" /^> >>%PSA_1DB%\Strip.psa
echo ^<MinSalinity value="20.000000" /^> >>%PSA_1DB%\Strip.psa
echo ^<PressureWindowSize value="20.000000" /^> >>%PSA_1DB%\Strip.psa
echo ^<TimeWindowSize value="60.000000" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="24" CalcID="55" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="61" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Oxygen, SBE 43 [umol/Kg]" /^> >>%PSA_1DB%\Strip.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1DB%\Strip.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="25" CalcID="55" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="61" Ordinal="1" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Oxygen, SBE 43, 2 [umol/Kg]" /^> >>%PSA_1DB%\Strip.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1DB%\Strip.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^<CalcArrayItem index="26" CalcID="73" ^> >>%PSA_1DB%\Strip.psa
echo ^<Calc UnitID="-1" Ordinal="0" ^> >>%PSA_1DB%\Strip.psa
echo ^<FullName value="Scans Per Bin" /^> >>%PSA_1DB%\Strip.psa
echo ^</Calc^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\Strip.psa
echo ^</CalcArray^> >>%PSA_1DB%\Strip.psa
echo ^<SelectArray ^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="0" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="1" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="2" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="3" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="4" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="5" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="6" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="7" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="8" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="9" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="10" value="0" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="11" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="12" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="13" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="14" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="15" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="16" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="17" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="18" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="19" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="20" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="21" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="22" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="23" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="24" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="25" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^<ArrayItem index="26" value="1" /^> >>%PSA_1DB%\Strip.psa
echo ^</SelectArray^> >>%PSA_1DB%\Strip.psa
echo ^</Strip^> >>%PSA_1DB%\Strip.psa
REM #### END Strip.psa ####
REM #### START Trans.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1DB%\Trans.psa
echo ^<Translate ^> >>%PSA_1DB%\Trans.psa
echo ^<Version value="7.21h" /^> >>%PSA_1DB%\Trans.psa
echo ^<ServerName value="Translate" /^> >>%PSA_1DB%\Trans.psa
echo ^<InputDir value="C:\Data\Cruises\ctd\gomecc2\1db\proc_data" /^> >>%PSA_1DB%\Trans.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1DB%\Trans.psa
echo ^<ArrayItem index="0" value="rv1203_001.cnv" /^> >>%PSA_1DB%\Trans.psa
echo ^</InputFileArray^> >>%PSA_1DB%\Trans.psa
echo ^<OutputDir value="C:\Data\Cruises\ctd\gomecc2\1db\proc_data" /^> >>%PSA_1DB%\Trans.psa
echo ^<NameAppend value="" /^> >>%PSA_1DB%\Trans.psa
echo ^<OutputFile value="rv1203_001.cnv" /^> >>%PSA_1DB%\Trans.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1DB%\Trans.psa
echo ^<Translation value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1DB%\Trans.psa
echo ^</Translate^> >>%PSA_1DB%\Trans.psa
REM #### END Trans.psa ####
REM #### START WildEdit.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1DB%\WildEdit.psa
echo ^<Wild_Edit ^> >>%PSA_1DB%\WildEdit.psa
echo ^<Version value="7.23.2" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ServerName value="Wild Edit" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<InputDir value="C:\Users\scs.user.rb\CTD\ab1802\proc_data\1db" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<ArrayItem index="0" value="ab1802_000.cnv" /^> >>%PSA_1DB%\WildEdit.psa
echo ^</InputFileArray^> >>%PSA_1DB%\WildEdit.psa
echo ^<OutputDir value="C:\Users\scs.user.rb\CTD\ab1802\proc_data\1db" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<NameAppend value="" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<OutputFile value="ab1802_000.cnv" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<StdDevPassOne value="2.000000" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<StdDevPassTwo value="2.000000" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ScansPerBlock value="100" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<MinDelta value="0.003000" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ExcludeMarkedBad value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<CalcArray Size="13" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<CalcArrayItem index="0" CalcID="17" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<Calc UnitID="31" Ordinal="0" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<FullName value="Depth [salt water, m]" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<Latitude value="0.000000" /^> >>%PSA_1DB%\WildEdit.psa
echo ^</Calc^> >>%PSA_1DB%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\WildEdit.psa
echo ^<CalcArrayItem index="1" CalcID="65" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<Calc UnitID="3" Ordinal="0" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<FullName value="Pressure, Digiquartz [db]" /^> >>%PSA_1DB%\WildEdit.psa
echo ^</Calc^> >>%PSA_1DB%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\WildEdit.psa
echo ^<CalcArrayItem index="2" CalcID="81" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<Calc UnitID="6" Ordinal="0" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<FullName value="Temperature [ITS-90, deg C]" /^> >>%PSA_1DB%\WildEdit.psa
echo ^</Calc^> >>%PSA_1DB%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\WildEdit.psa
echo ^<CalcArrayItem index="3" CalcID="81" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<Calc UnitID="6" Ordinal="1" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<FullName value="Temperature, 2 [ITS-90, deg C]" /^> >>%PSA_1DB%\WildEdit.psa
echo ^</Calc^> >>%PSA_1DB%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\WildEdit.psa
echo ^<CalcArrayItem index="4" CalcID="12" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<Calc UnitID="58" Ordinal="0" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<FullName value="Conductivity [S/m]" /^> >>%PSA_1DB%\WildEdit.psa
echo ^</Calc^> >>%PSA_1DB%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\WildEdit.psa
echo ^<CalcArrayItem index="5" CalcID="12" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<Calc UnitID="58" Ordinal="1" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<FullName value="Conductivity, 2 [S/m]" /^> >>%PSA_1DB%\WildEdit.psa
echo ^</Calc^> >>%PSA_1DB%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\WildEdit.psa
echo ^<CalcArrayItem index="6" CalcID="57" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<Calc UnitID="63" Ordinal="0" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<FullName value="Oxygen raw, SBE 43 [V]" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^</Calc^> >>%PSA_1DB%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\WildEdit.psa
echo ^<CalcArrayItem index="7" CalcID="57" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<Calc UnitID="63" Ordinal="1" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<FullName value="Oxygen raw, SBE 43, 2 [V]" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^</Calc^> >>%PSA_1DB%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\WildEdit.psa
echo ^<CalcArrayItem index="8" CalcID="1" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<Calc UnitID="29" Ordinal="0" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<FullName value="Altimeter [m]" /^> >>%PSA_1DB%\WildEdit.psa
echo ^</Calc^> >>%PSA_1DB%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\WildEdit.psa
echo ^<CalcArrayItem index="9" CalcID="39" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<FullName value="Latitude [deg]" /^> >>%PSA_1DB%\WildEdit.psa
echo ^</Calc^> >>%PSA_1DB%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\WildEdit.psa
echo ^<CalcArrayItem index="10" CalcID="40" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<FullName value="Longitude [deg]" /^> >>%PSA_1DB%\WildEdit.psa
echo ^</Calc^> >>%PSA_1DB%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\WildEdit.psa
echo ^<CalcArrayItem index="11" CalcID="55" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<Calc UnitID="68" Ordinal="0" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<FullName value="Oxygen, SBE 43 [dov/dt]" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^</Calc^> >>%PSA_1DB%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\WildEdit.psa
echo ^<CalcArrayItem index="12" CalcID="55" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<Calc UnitID="68" Ordinal="1" ^> >>%PSA_1DB%\WildEdit.psa
echo ^<FullName value="Oxygen, SBE 43, 2 [dov/dt]" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^</Calc^> >>%PSA_1DB%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1DB%\WildEdit.psa
echo ^</CalcArray^> >>%PSA_1DB%\WildEdit.psa
echo ^<SelectArray ^> >>%PSA_1DB%\WildEdit.psa
echo ^<ArrayItem index="0" value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ArrayItem index="1" value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ArrayItem index="2" value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ArrayItem index="3" value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ArrayItem index="4" value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ArrayItem index="5" value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ArrayItem index="6" value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ArrayItem index="7" value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ArrayItem index="8" value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ArrayItem index="9" value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ArrayItem index="10" value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ArrayItem index="11" value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^<ArrayItem index="12" value="1" /^> >>%PSA_1DB%\WildEdit.psa
echo ^</SelectArray^> >>%PSA_1DB%\WildEdit.psa
echo ^</Wild_Edit^> >>%PSA_1DB%\WildEdit.psa
REM #### END WildEdit.psa ####

REM #### COPY ABOVE THIS LINE ####


REM # Generate 1hz files
REM #### COPY BELOW THIS LINE ####

REM #### START AlignCTD.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1HZ%\AlignCTD.psa
echo ^<Align_CTD ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<Version value="7.23.2" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ServerName value="Align CTD" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<InputDir value="C:\Users\scs.user.rb\CTD\ab1802\proc_data\1hz" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ArrayItem index="0" value="ab1802_000.cnv" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</InputFileArray^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<OutputDir value="C:\Users\scs.user.rb\CTD\ab1802\proc_data\1hz" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<NameAppend value="" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<OutputFile value="ab1802_000.cnv" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<CalcArray Size="12" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<CalcArrayItem index="0" CalcID="81" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<Calc UnitID="6" Ordinal="0" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<FullName value="Temperature [ITS-90, deg C]" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<CalcArrayItem index="1" CalcID="81" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<Calc UnitID="6" Ordinal="1" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<FullName value="Temperature, 2 [ITS-90, deg C]" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<CalcArrayItem index="2" CalcID="12" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<Calc UnitID="58" Ordinal="0" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<FullName value="Conductivity [S/m]" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<CalcArrayItem index="3" CalcID="12" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<Calc UnitID="58" Ordinal="1" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<FullName value="Conductivity, 2 [S/m]" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<CalcArrayItem index="4" CalcID="70" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<Calc UnitID="49" Ordinal="0" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<FullName value="Salinity, Practical [PSU]" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<CalcArrayItem index="5" CalcID="70" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<Calc UnitID="49" Ordinal="1" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<FullName value="Salinity, Practical, 2 [PSU]" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<CalcArrayItem index="6" CalcID="39" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<FullName value="Latitude [deg]" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<CalcArrayItem index="7" CalcID="40" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<FullName value="Longitude [deg]" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<CalcArrayItem index="8" CalcID="57" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<Calc UnitID="63" Ordinal="0" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<FullName value="Oxygen raw, SBE 43 [V]" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<CalcArrayItem index="9" CalcID="57" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<Calc UnitID="63" Ordinal="1" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<FullName value="Oxygen raw, SBE 43, 2 [V]" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<CalcArrayItem index="10" CalcID="55" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<Calc UnitID="40" Ordinal="0" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<FullName value="Oxygen, SBE 43 [ml/l]" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<CalcArrayItem index="11" CalcID="55" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<Calc UnitID="40" Ordinal="1" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<FullName value="Oxygen, SBE 43, 2 [ml/l]" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</Calc^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</CalcArray^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ValArray size="12" ^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ValArrayItem index="0" value="0.000000" variable_name="Temperature" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ValArrayItem index="1" value="0.000000" variable_name="Temperature" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ValArrayItem index="2" value="0.000000" variable_name="Conductivity" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ValArrayItem index="3" value="0.000000" variable_name="Conductivity" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ValArrayItem index="4" value="0.000000" variable_name="Salinity, Practical" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ValArrayItem index="5" value="0.000000" variable_name="Salinity, Practical" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ValArrayItem index="6" value="0.000000" variable_name="Latitude" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ValArrayItem index="7" value="0.000000" variable_name="Longitude" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ValArrayItem index="8" value="1.073000" variable_name="Oxygen raw, SBE 43" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ValArrayItem index="9" value="1.073000" variable_name="Oxygen raw, SBE 43" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ValArrayItem index="10" value="1.073000" variable_name="Oxygen, SBE 43" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^<ValArrayItem index="11" value="1.073000" variable_name="Oxygen, SBE 43" /^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</ValArray^> >>%PSA_1HZ%\AlignCTD.psa
echo ^</Align_CTD^> >>%PSA_1HZ%\AlignCTD.psa
REM #### END AlignCTD.psa ####
REM #### START BinAvg.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1HZ%\BinAvg.psa
echo ^<Bin_Average ^> >>%PSA_1HZ%\BinAvg.psa
echo ^<Version value="7.26.7.114" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<ServerName value="Bin Average" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<InputDir value="C:\Users\scs.user.rb\CTD\ab1802\proc_data\1hz" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1HZ%\BinAvg.psa
echo ^<ArrayItem index="0" value="ab1802_012.cnv" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^</InputFileArray^> >>%PSA_1HZ%\BinAvg.psa
echo ^<OutputDir value="C:\Users\scs.user.rb\CTD\ab1802\proc_data\1hz" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<NameAppend value="" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<OutputFile value="ab1802_012.cnv" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<BinType value="4" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<BinSize value="1.000000" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<IncludeNumberScans value="0" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<ExcludeMarkedBad value="1" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<ScansToSkip value="0" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<ScansToOmit value="0" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<MinScansPerBin value="1" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<MaxScansPerBin value="90" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<CastToProcess value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<IncludeSurfaceBin value="0" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<SurfaceBinMinVal value="0.000000" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<SurfaceBinMaxVal value="0.000000" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^<SurfaceBinVal value="0.000000" /^> >>%PSA_1HZ%\BinAvg.psa
echo ^</Bin_Average^> >>%PSA_1HZ%\BinAvg.psa
REM #### END BinAvg.psa ####
REM #### START CellTM.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1HZ%\CellTM.psa
echo ^<Cell_Thermal_Mass ^> >>%PSA_1HZ%\CellTM.psa
echo ^<Version value="7.14c" /^> >>%PSA_1HZ%\CellTM.psa
echo ^<ServerName value="Cell Thermal Mass" /^> >>%PSA_1HZ%\CellTM.psa
echo ^<InputDir value="C:\DATA\AB0709\ADCP\proc_data" /^> >>%PSA_1HZ%\CellTM.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1HZ%\CellTM.psa
echo ^<ArrayItem index="0" value="ab0709_000.cnv" /^> >>%PSA_1HZ%\CellTM.psa
echo ^</InputFileArray^> >>%PSA_1HZ%\CellTM.psa
echo ^<OutputDir value="C:\DATA\AB0709\ADCP\proc_data" /^> >>%PSA_1HZ%\CellTM.psa
echo ^<NameAppend value="" /^> >>%PSA_1HZ%\CellTM.psa
echo ^<OutputFile value="ab0709_000.cnv" /^> >>%PSA_1HZ%\CellTM.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1HZ%\CellTM.psa
echo ^<Primary ^> >>%PSA_1HZ%\CellTM.psa
echo ^<Correct value="1" /^> >>%PSA_1HZ%\CellTM.psa
echo ^<TempSensor value="0" /^> >>%PSA_1HZ%\CellTM.psa
echo ^<TA_Amplitude value="0.030000" /^> >>%PSA_1HZ%\CellTM.psa
echo ^<TA_TimeConstant value="7.000000" /^> >>%PSA_1HZ%\CellTM.psa
echo ^</Primary^> >>%PSA_1HZ%\CellTM.psa
echo ^<Secondary ^> >>%PSA_1HZ%\CellTM.psa
echo ^<Correct value="1" /^> >>%PSA_1HZ%\CellTM.psa
echo ^<TempSensor value="1" /^> >>%PSA_1HZ%\CellTM.psa
echo ^<TA_Amplitude value="0.030000" /^> >>%PSA_1HZ%\CellTM.psa
echo ^<TA_TimeConstant value="7.000000" /^> >>%PSA_1HZ%\CellTM.psa
echo ^</Secondary^> >>%PSA_1HZ%\CellTM.psa
echo ^</Cell_Thermal_Mass^> >>%PSA_1HZ%\CellTM.psa
REM #### END CellTM.psa ####
REM #### START DatCnv.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1HZ%\DatCnv.psa
echo ^<Data_Conversion ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Version value="7.25.0.319" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ServerName value="Data Conversion" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<InstrumentPath value="Z:\Users\jhooper\Documents\Work_data\WBTS\ab1602\sbe_ctd\raw_data\ab1602_003.xmlcon" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<InstrumentMatch value="0" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<InputDir value="Z:\Users\jhooper\Documents\Work_data\WBTS\ab1602\sbe_ctd\raw_data" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ArrayItem index="0" value="ab1602_003.hex" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</InputFileArray^> >>%PSA_1HZ%\DatCnv.psa
echo ^<OutputDir value="Z:\Users\jhooper\Documents\Work_data\WBTS\ab1602\sbe_ctd\1hz\proc_data" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<NameAppend value="" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<OutputFile value="ab1602_003.cnv" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ProcessScansToEnd value="1" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ScansToSkip value="0" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ScansToProcess value="1" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<MergeHeaderFile value="0" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<OutputFormat value="1" high="1" low="0" initialValue="0" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<FromCast value="0" high="1" low="0" initialValue="0" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CreateFile value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ScanRangeSource value="3" high="3" low="0" initialValue="3" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ScanRangeOffset value="0.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ScanRangeDuration value="2.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<StartTimeOption value="1" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<PromptForNoteAndOrStartTime value="0" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CalcArray Size="16" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CalcArrayItem index="0" CalcID="72" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Calc UnitID="-1" Ordinal="0" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<FullName value="Scan Count" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Calc^> >>%PSA_1HZ%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CalcArrayItem index="1" CalcID="84" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Calc UnitID="27" Ordinal="0" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<FullName value="Julian Days" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Calc^> >>%PSA_1HZ%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CalcArrayItem index="2" CalcID="84" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Calc UnitID="52" Ordinal="0" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<FullName value="Time, Elapsed [seconds]" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Calc^> >>%PSA_1HZ%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CalcArrayItem index="3" CalcID="65" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Calc UnitID="3" Ordinal="0" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<FullName value="Pressure, Digiquartz [db]" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Calc^> >>%PSA_1HZ%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CalcArrayItem index="4" CalcID="81" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Calc UnitID="6" Ordinal="0" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<FullName value="Temperature [ITS-90, deg C]" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Calc^> >>%PSA_1HZ%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CalcArrayItem index="5" CalcID="81" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Calc UnitID="6" Ordinal="1" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<FullName value="Temperature, 2 [ITS-90, deg C]" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Calc^> >>%PSA_1HZ%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CalcArrayItem index="6" CalcID="12" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Calc UnitID="58" Ordinal="0" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<FullName value="Conductivity [S/m]" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Calc^> >>%PSA_1HZ%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CalcArrayItem index="7" CalcID="12" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Calc UnitID="58" Ordinal="1" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<FullName value="Conductivity, 2 [S/m]" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Calc^> >>%PSA_1HZ%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CalcArrayItem index="8" CalcID="70" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Calc UnitID="49" Ordinal="0" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<FullName value="Salinity, Practical [PSU]" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Calc^> >>%PSA_1HZ%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CalcArrayItem index="9" CalcID="70" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Calc UnitID="49" Ordinal="1" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<FullName value="Salinity, Practical, 2 [PSU]" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Calc^> >>%PSA_1HZ%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CalcArrayItem index="10" CalcID="39" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<FullName value="Latitude [deg]" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Calc^> >>%PSA_1HZ%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CalcArrayItem index="11" CalcID="40" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<FullName value="Longitude [deg]" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Calc^> >>%PSA_1HZ%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CalcArrayItem index="12" CalcID="57" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Calc UnitID="63" Ordinal="0" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<FullName value="Oxygen raw, SBE 43 [V]" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ApplyHysteresisCorrection value="0" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Calc^> >>%PSA_1HZ%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CalcArrayItem index="13" CalcID="57" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Calc UnitID="63" Ordinal="1" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<FullName value="Oxygen raw, SBE 43, 2 [V]" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ApplyHysteresisCorrection value="0" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Calc^> >>%PSA_1HZ%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CalcArrayItem index="14" CalcID="55" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Calc UnitID="40" Ordinal="0" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<FullName value="Oxygen, SBE 43 [ml/l]" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ApplyHysteresisCorrection value="0" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Calc^> >>%PSA_1HZ%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\DatCnv.psa
echo ^<CalcArrayItem index="15" CalcID="55" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Calc UnitID="40" Ordinal="1" ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<FullName value="Oxygen, SBE 43, 2 [ml/l]" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ApplyHysteresisCorrection value="0" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Calc^> >>%PSA_1HZ%\DatCnv.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\DatCnv.psa
echo ^</CalcArray^> >>%PSA_1HZ%\DatCnv.psa
echo ^<MiscellaneousDataForCalculations ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Latitude value="0.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Longitude value="0.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<DescentRateAndAcceleration ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</DescentRateAndAcceleration^> >>%PSA_1HZ%\DatCnv.psa
echo ^<Oxygen ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ApplyHysteresisCorrection value="0" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Oxygen^> >>%PSA_1HZ%\DatCnv.psa
echo ^<AverageSoundVelocity ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<MinimumPressure value="20.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<MinimumSalinity value="20.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<PressureWindowSize value="20.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<TimeWindowSize value="60.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</AverageSoundVelocity^> >>%PSA_1HZ%\DatCnv.psa
echo ^<PlumeAnomaly ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ThetaB value="0.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<SalinityB value="0.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ThetaZSalinityZRatio value="0.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<ReferencePressure value="0.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</PlumeAnomaly^> >>%PSA_1HZ%\DatCnv.psa
echo ^<PotentialTempAnomaly ^> >>%PSA_1HZ%\DatCnv.psa
echo ^<A0 value="0.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<A1 value="0.000000" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^<A1Multiplier value="0" /^> >>%PSA_1HZ%\DatCnv.psa
echo ^</PotentialTempAnomaly^> >>%PSA_1HZ%\DatCnv.psa
echo ^</MiscellaneousDataForCalculations^> >>%PSA_1HZ%\DatCnv.psa
echo ^</Data_Conversion^> >>%PSA_1HZ%\DatCnv.psa
REM #### END DatCnv.psa ####
REM #### START Derive.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1HZ%\Derive.psa
echo ^<Derive ^> >>%PSA_1HZ%\Derive.psa
echo ^<Version value="7.16a" /^> >>%PSA_1HZ%\Derive.psa
echo ^<ServerName value="Derive" /^> >>%PSA_1HZ%\Derive.psa
echo ^<InstrumentPath value="C:\DATA\AB0804\ADCP\raw_data\AB0804_001_009.CON" /^> >>%PSA_1HZ%\Derive.psa
echo ^<InstrumentMatch value="0" /^> >>%PSA_1HZ%\Derive.psa
echo ^<InputDir value="C:\DATA\AB0804\ADCP\proc_data_pcor" /^> >>%PSA_1HZ%\Derive.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1HZ%\Derive.psa
echo ^<ArrayItem index="0" value="ab0804_001.cnv" /^> >>%PSA_1HZ%\Derive.psa
echo ^</InputFileArray^> >>%PSA_1HZ%\Derive.psa
echo ^<OutputDir value="C:\DATA\AB0804\ADCP\proc_data_pcor" /^> >>%PSA_1HZ%\Derive.psa
echo ^<NameAppend value="" /^> >>%PSA_1HZ%\Derive.psa
echo ^<OutputFile value="AB0804_001.cnv" /^> >>%PSA_1HZ%\Derive.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1HZ%\Derive.psa
echo ^<CalcArray Size="2" ^> >>%PSA_1HZ%\Derive.psa
echo ^<CalcArrayItem index="0" CalcID="70" ^> >>%PSA_1HZ%\Derive.psa
echo ^<Calc UnitID="49" Ordinal="0" ^> >>%PSA_1HZ%\Derive.psa
echo ^<FullName value="Salinity [PSU]" /^> >>%PSA_1HZ%\Derive.psa
echo ^</Calc^> >>%PSA_1HZ%\Derive.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Derive.psa
echo ^<CalcArrayItem index="1" CalcID="70" ^> >>%PSA_1HZ%\Derive.psa
echo ^<Calc UnitID="49" Ordinal="1" ^> >>%PSA_1HZ%\Derive.psa
echo ^<FullName value="Salinity, 2 [PSU]" /^> >>%PSA_1HZ%\Derive.psa
echo ^</Calc^> >>%PSA_1HZ%\Derive.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Derive.psa
echo ^</CalcArray^> >>%PSA_1HZ%\Derive.psa
echo ^</Derive^> >>%PSA_1HZ%\Derive.psa
REM #### END Derive.psa ####
REM #### START Filter.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1HZ%\Filter.psa
echo ^<Filter ^> >>%PSA_1HZ%\Filter.psa
echo ^<Version value="7.14c" /^> >>%PSA_1HZ%\Filter.psa
echo ^<ServerName value="Filter" /^> >>%PSA_1HZ%\Filter.psa
echo ^<InputDir value="C:\DATA\AB0709\ADCP\proc_data" /^> >>%PSA_1HZ%\Filter.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1HZ%\Filter.psa
echo ^<ArrayItem index="0" value="ab0709_000.cnv" /^> >>%PSA_1HZ%\Filter.psa
echo ^</InputFileArray^> >>%PSA_1HZ%\Filter.psa
echo ^<OutputDir value="C:\DATA\AB0709\ADCP\proc_data" /^> >>%PSA_1HZ%\Filter.psa
echo ^<NameAppend value="" /^> >>%PSA_1HZ%\Filter.psa
echo ^<OutputFile value="ab0709_000.cnv" /^> >>%PSA_1HZ%\Filter.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1HZ%\Filter.psa
echo ^<TimeConstFilterA value="0.030000" /^> >>%PSA_1HZ%\Filter.psa
echo ^<TimeConstFilterB value="0.150000" /^> >>%PSA_1HZ%\Filter.psa
echo ^<CalcArray Size="5" ^> >>%PSA_1HZ%\Filter.psa
echo ^<CalcArrayItem index="0" CalcID="65" ^> >>%PSA_1HZ%\Filter.psa
echo ^<Calc UnitID="3" Ordinal="0" ^> >>%PSA_1HZ%\Filter.psa
echo ^<FullName value="Pressure, Digiquartz [db]" /^> >>%PSA_1HZ%\Filter.psa
echo ^</Calc^> >>%PSA_1HZ%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Filter.psa
echo ^<CalcArrayItem index="1" CalcID="81" ^> >>%PSA_1HZ%\Filter.psa
echo ^<Calc UnitID="6" Ordinal="0" ^> >>%PSA_1HZ%\Filter.psa
echo ^<FullName value="Temperature [ITS-90, deg C]" /^> >>%PSA_1HZ%\Filter.psa
echo ^</Calc^> >>%PSA_1HZ%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Filter.psa
echo ^<CalcArrayItem index="2" CalcID="81" ^> >>%PSA_1HZ%\Filter.psa
echo ^<Calc UnitID="6" Ordinal="1" ^> >>%PSA_1HZ%\Filter.psa
echo ^<FullName value="Temperature, 2 [ITS-90, deg C]" /^> >>%PSA_1HZ%\Filter.psa
echo ^</Calc^> >>%PSA_1HZ%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Filter.psa
echo ^<CalcArrayItem index="3" CalcID="12" ^> >>%PSA_1HZ%\Filter.psa
echo ^<Calc UnitID="58" Ordinal="0" ^> >>%PSA_1HZ%\Filter.psa
echo ^<FullName value="Conductivity [S/m]" /^> >>%PSA_1HZ%\Filter.psa
echo ^</Calc^> >>%PSA_1HZ%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Filter.psa
echo ^<CalcArrayItem index="4" CalcID="12" ^> >>%PSA_1HZ%\Filter.psa
echo ^<Calc UnitID="58" Ordinal="1" ^> >>%PSA_1HZ%\Filter.psa
echo ^<FullName value="Conductivity, 2 [S/m]" /^> >>%PSA_1HZ%\Filter.psa
echo ^</Calc^> >>%PSA_1HZ%\Filter.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Filter.psa
echo ^</CalcArray^> >>%PSA_1HZ%\Filter.psa
echo ^<FilterTypeArray ^> >>%PSA_1HZ%\Filter.psa
echo ^<ArrayItem index="0" value="2" /^> >>%PSA_1HZ%\Filter.psa
echo ^<ArrayItem index="1" value="1" /^> >>%PSA_1HZ%\Filter.psa
echo ^<ArrayItem index="2" value="1" /^> >>%PSA_1HZ%\Filter.psa
echo ^<ArrayItem index="3" value="1" /^> >>%PSA_1HZ%\Filter.psa
echo ^<ArrayItem index="4" value="1" /^> >>%PSA_1HZ%\Filter.psa
echo ^</FilterTypeArray^> >>%PSA_1HZ%\Filter.psa
echo ^</Filter^> >>%PSA_1HZ%\Filter.psa
REM #### END Filter.psa ####
REM #### START Strip.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1HZ%\Strip.psa
echo ^<Strip ^> >>%PSA_1HZ%\Strip.psa
echo ^<Version value="7.23.1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ServerName value="Strip" /^> >>%PSA_1HZ%\Strip.psa
echo ^<InputDir value="J:\ab1602\sbe_ctd\1hz\proc_data" /^> >>%PSA_1HZ%\Strip.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1HZ%\Strip.psa
echo ^<ArrayItem index="0" value="ab1602_001.cnv" /^> >>%PSA_1HZ%\Strip.psa
echo ^</InputFileArray^> >>%PSA_1HZ%\Strip.psa
echo ^<OutputDir value="J:\ab1602\sbe_ctd\1hz\proc_data" /^> >>%PSA_1HZ%\Strip.psa
echo ^<NameAppend value="" /^> >>%PSA_1HZ%\Strip.psa
echo ^<OutputFile value="ab1602_001.cnv" /^> >>%PSA_1HZ%\Strip.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1HZ%\Strip.psa
echo ^<CalcArray Size="16" ^> >>%PSA_1HZ%\Strip.psa
echo ^<CalcArrayItem index="0" CalcID="72" ^> >>%PSA_1HZ%\Strip.psa
echo ^<Calc UnitID="-1" Ordinal="0" ^> >>%PSA_1HZ%\Strip.psa
echo ^<FullName value="Scan Count" /^> >>%PSA_1HZ%\Strip.psa
echo ^</Calc^> >>%PSA_1HZ%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Strip.psa
echo ^<CalcArrayItem index="1" CalcID="84" ^> >>%PSA_1HZ%\Strip.psa
echo ^<Calc UnitID="27" Ordinal="0" ^> >>%PSA_1HZ%\Strip.psa
echo ^<FullName value="Julian Days" /^> >>%PSA_1HZ%\Strip.psa
echo ^</Calc^> >>%PSA_1HZ%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Strip.psa
echo ^<CalcArrayItem index="2" CalcID="84" ^> >>%PSA_1HZ%\Strip.psa
echo ^<Calc UnitID="52" Ordinal="0" ^> >>%PSA_1HZ%\Strip.psa
echo ^<FullName value="Time, Elapsed [seconds]" /^> >>%PSA_1HZ%\Strip.psa
echo ^</Calc^> >>%PSA_1HZ%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Strip.psa
echo ^<CalcArrayItem index="3" CalcID="65" ^> >>%PSA_1HZ%\Strip.psa
echo ^<Calc UnitID="3" Ordinal="0" ^> >>%PSA_1HZ%\Strip.psa
echo ^<FullName value="Pressure, Digiquartz [db]" /^> >>%PSA_1HZ%\Strip.psa
echo ^</Calc^> >>%PSA_1HZ%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Strip.psa
echo ^<CalcArrayItem index="4" CalcID="81" ^> >>%PSA_1HZ%\Strip.psa
echo ^<Calc UnitID="6" Ordinal="0" ^> >>%PSA_1HZ%\Strip.psa
echo ^<FullName value="Temperature [ITS-90, deg C]" /^> >>%PSA_1HZ%\Strip.psa
echo ^</Calc^> >>%PSA_1HZ%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Strip.psa
echo ^<CalcArrayItem index="5" CalcID="81" ^> >>%PSA_1HZ%\Strip.psa
echo ^<Calc UnitID="6" Ordinal="1" ^> >>%PSA_1HZ%\Strip.psa
echo ^<FullName value="Temperature, 2 [ITS-90, deg C]" /^> >>%PSA_1HZ%\Strip.psa
echo ^</Calc^> >>%PSA_1HZ%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Strip.psa
echo ^<CalcArrayItem index="6" CalcID="12" ^> >>%PSA_1HZ%\Strip.psa
echo ^<Calc UnitID="58" Ordinal="0" ^> >>%PSA_1HZ%\Strip.psa
echo ^<FullName value="Conductivity [S/m]" /^> >>%PSA_1HZ%\Strip.psa
echo ^</Calc^> >>%PSA_1HZ%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Strip.psa
echo ^<CalcArrayItem index="7" CalcID="12" ^> >>%PSA_1HZ%\Strip.psa
echo ^<Calc UnitID="58" Ordinal="1" ^> >>%PSA_1HZ%\Strip.psa
echo ^<FullName value="Conductivity, 2 [S/m]" /^> >>%PSA_1HZ%\Strip.psa
echo ^</Calc^> >>%PSA_1HZ%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Strip.psa
echo ^<CalcArrayItem index="8" CalcID="70" ^> >>%PSA_1HZ%\Strip.psa
echo ^<Calc UnitID="49" Ordinal="0" ^> >>%PSA_1HZ%\Strip.psa
echo ^<FullName value="Salinity, Practical [PSU]" /^> >>%PSA_1HZ%\Strip.psa
echo ^</Calc^> >>%PSA_1HZ%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Strip.psa
echo ^<CalcArrayItem index="9" CalcID="70" ^> >>%PSA_1HZ%\Strip.psa
echo ^<Calc UnitID="49" Ordinal="1" ^> >>%PSA_1HZ%\Strip.psa
echo ^<FullName value="Salinity, Practical, 2 [PSU]" /^> >>%PSA_1HZ%\Strip.psa
echo ^</Calc^> >>%PSA_1HZ%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Strip.psa
echo ^<CalcArrayItem index="10" CalcID="39" ^> >>%PSA_1HZ%\Strip.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1HZ%\Strip.psa
echo ^<FullName value="Latitude [deg]" /^> >>%PSA_1HZ%\Strip.psa
echo ^</Calc^> >>%PSA_1HZ%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Strip.psa
echo ^<CalcArrayItem index="11" CalcID="40" ^> >>%PSA_1HZ%\Strip.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1HZ%\Strip.psa
echo ^<FullName value="Longitude [deg]" /^> >>%PSA_1HZ%\Strip.psa
echo ^</Calc^> >>%PSA_1HZ%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Strip.psa
echo ^<CalcArrayItem index="12" CalcID="57" ^> >>%PSA_1HZ%\Strip.psa
echo ^<Calc UnitID="63" Ordinal="0" ^> >>%PSA_1HZ%\Strip.psa
echo ^<FullName value="Oxygen raw, SBE 43 [V]" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^</Calc^> >>%PSA_1HZ%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Strip.psa
echo ^<CalcArrayItem index="13" CalcID="57" ^> >>%PSA_1HZ%\Strip.psa
echo ^<Calc UnitID="63" Ordinal="1" ^> >>%PSA_1HZ%\Strip.psa
echo ^<FullName value="Oxygen raw, SBE 43, 2 [V]" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^</Calc^> >>%PSA_1HZ%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Strip.psa
echo ^<CalcArrayItem index="14" CalcID="55" ^> >>%PSA_1HZ%\Strip.psa
echo ^<Calc UnitID="40" Ordinal="0" ^> >>%PSA_1HZ%\Strip.psa
echo ^<FullName value="Oxygen, SBE 43 [ml/l]" /^> >>%PSA_1HZ%\Strip.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^</Calc^> >>%PSA_1HZ%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Strip.psa
echo ^<CalcArrayItem index="15" CalcID="55" ^> >>%PSA_1HZ%\Strip.psa
echo ^<Calc UnitID="40" Ordinal="1" ^> >>%PSA_1HZ%\Strip.psa
echo ^<FullName value="Oxygen, SBE 43, 2 [ml/l]" /^> >>%PSA_1HZ%\Strip.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^</Calc^> >>%PSA_1HZ%\Strip.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\Strip.psa
echo ^</CalcArray^> >>%PSA_1HZ%\Strip.psa
echo ^<SelectArray ^> >>%PSA_1HZ%\Strip.psa
echo ^<ArrayItem index="0" value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ArrayItem index="1" value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ArrayItem index="2" value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ArrayItem index="3" value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ArrayItem index="4" value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ArrayItem index="5" value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ArrayItem index="6" value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ArrayItem index="7" value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ArrayItem index="8" value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ArrayItem index="9" value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ArrayItem index="10" value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ArrayItem index="11" value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ArrayItem index="12" value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ArrayItem index="13" value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ArrayItem index="14" value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^<ArrayItem index="15" value="1" /^> >>%PSA_1HZ%\Strip.psa
echo ^</SelectArray^> >>%PSA_1HZ%\Strip.psa
echo ^</Strip^> >>%PSA_1HZ%\Strip.psa
REM #### END Strip.psa ####
REM #### START Trans.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1HZ%\Trans.psa
echo ^<Translate ^> >>%PSA_1HZ%\Trans.psa
echo ^<Version value="7.14c" /^> >>%PSA_1HZ%\Trans.psa
echo ^<ServerName value="Translate" /^> >>%PSA_1HZ%\Trans.psa
echo ^<InputDir value="C:\DATA\AB0709\ADCP\proc_data" /^> >>%PSA_1HZ%\Trans.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1HZ%\Trans.psa
echo ^<ArrayItem index="0" value="ab0709_000.cnv" /^> >>%PSA_1HZ%\Trans.psa
echo ^</InputFileArray^> >>%PSA_1HZ%\Trans.psa
echo ^<OutputDir value="C:\DATA\AB0709\ADCP\proc_data" /^> >>%PSA_1HZ%\Trans.psa
echo ^<NameAppend value="" /^> >>%PSA_1HZ%\Trans.psa
echo ^<OutputFile value="ab0709_000.cnv" /^> >>%PSA_1HZ%\Trans.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1HZ%\Trans.psa
echo ^<Translation value="0" high="2" low="0" initialValue="0" /^> >>%PSA_1HZ%\Trans.psa
echo ^</Translate^> >>%PSA_1HZ%\Trans.psa
REM #### END Trans.psa ####
REM #### START WildEdit.psa ####
echo ^<?xml version="1.0" encoding="UTF-8"?^> >%PSA_1HZ%\WildEdit.psa
echo ^<Wild_Edit ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<Version value="7.23.2" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ServerName value="Wild Edit" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<InputDir value="C:\Users\scs.user.rb\CTD\ab1802\proc_data\1hz" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<InputFileArray size="1" GrowBy="-1" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ArrayItem index="0" value="ab1802_000.cnv" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^</InputFileArray^> >>%PSA_1HZ%\WildEdit.psa
echo ^<OutputDir value="C:\Users\scs.user.rb\CTD\ab1802\proc_data\1hz" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<NameAppend value="" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<OutputFile value="ab1802_000.cnv" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<LastProcessed value="0" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<StdDevPassOne value="2.000000" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<StdDevPassTwo value="2.000000" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ScansPerBlock value="100" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<MinDelta value="0.003000" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ExcludeMarkedBad value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<CalcArray Size="13" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<CalcArrayItem index="0" CalcID="65" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<Calc UnitID="3" Ordinal="0" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<FullName value="Pressure, Digiquartz [db]" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^</Calc^> >>%PSA_1HZ%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\WildEdit.psa
echo ^<CalcArrayItem index="1" CalcID="81" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<Calc UnitID="6" Ordinal="0" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<FullName value="Temperature [ITS-90, deg C]" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^</Calc^> >>%PSA_1HZ%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\WildEdit.psa
echo ^<CalcArrayItem index="2" CalcID="81" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<Calc UnitID="6" Ordinal="1" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<FullName value="Temperature, 2 [ITS-90, deg C]" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^</Calc^> >>%PSA_1HZ%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\WildEdit.psa
echo ^<CalcArrayItem index="3" CalcID="12" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<Calc UnitID="58" Ordinal="0" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<FullName value="Conductivity [S/m]" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^</Calc^> >>%PSA_1HZ%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\WildEdit.psa
echo ^<CalcArrayItem index="4" CalcID="12" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<Calc UnitID="58" Ordinal="1" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<FullName value="Conductivity, 2 [S/m]" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^</Calc^> >>%PSA_1HZ%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\WildEdit.psa
echo ^<CalcArrayItem index="5" CalcID="70" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<Calc UnitID="49" Ordinal="0" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<FullName value="Salinity, Practical [PSU]" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^</Calc^> >>%PSA_1HZ%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\WildEdit.psa
echo ^<CalcArrayItem index="6" CalcID="70" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<Calc UnitID="49" Ordinal="1" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<FullName value="Salinity, Practical, 2 [PSU]" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^</Calc^> >>%PSA_1HZ%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\WildEdit.psa
echo ^<CalcArrayItem index="7" CalcID="39" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<FullName value="Latitude [deg]" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^</Calc^> >>%PSA_1HZ%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\WildEdit.psa
echo ^<CalcArrayItem index="8" CalcID="40" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<Calc UnitID="4" Ordinal="0" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<FullName value="Longitude [deg]" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^</Calc^> >>%PSA_1HZ%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\WildEdit.psa
echo ^<CalcArrayItem index="9" CalcID="57" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<Calc UnitID="63" Ordinal="0" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<FullName value="Oxygen raw, SBE 43 [V]" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^</Calc^> >>%PSA_1HZ%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\WildEdit.psa
echo ^<CalcArrayItem index="10" CalcID="57" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<Calc UnitID="63" Ordinal="1" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<FullName value="Oxygen raw, SBE 43, 2 [V]" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^</Calc^> >>%PSA_1HZ%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\WildEdit.psa
echo ^<CalcArrayItem index="11" CalcID="55" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<Calc UnitID="40" Ordinal="0" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<FullName value="Oxygen, SBE 43 [ml/l]" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^</Calc^> >>%PSA_1HZ%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\WildEdit.psa
echo ^<CalcArrayItem index="12" CalcID="55" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<Calc UnitID="40" Ordinal="1" ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<FullName value="Oxygen, SBE 43, 2 [ml/l]" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<WindowSize value="2.000000" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ApplyHysteresisCorrection value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ApplyTauCorrection value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^</Calc^> >>%PSA_1HZ%\WildEdit.psa
echo ^</CalcArrayItem^> >>%PSA_1HZ%\WildEdit.psa
echo ^</CalcArray^> >>%PSA_1HZ%\WildEdit.psa
echo ^<SelectArray ^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ArrayItem index="0" value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ArrayItem index="1" value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ArrayItem index="2" value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ArrayItem index="3" value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ArrayItem index="4" value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ArrayItem index="5" value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ArrayItem index="6" value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ArrayItem index="7" value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ArrayItem index="8" value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ArrayItem index="9" value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ArrayItem index="10" value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ArrayItem index="11" value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^<ArrayItem index="12" value="1" /^> >>%PSA_1HZ%\WildEdit.psa
echo ^</SelectArray^> >>%PSA_1HZ%\WildEdit.psa
echo ^</Wild_Edit^> >>%PSA_1HZ%\WildEdit.psa
REM #### END WildEdit.psa ####

REM #### COPY ABOVE THIS LINE ####



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
