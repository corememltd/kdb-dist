@ECHO OFF
IF NOT DEFINED QHOME	SET "QHOME=%CONDA_PREFIX%\kdb"
IF NOT DEFINED QLIC	SET "QLIC=%HOMEDRIVE%%HOMEPATH%"

IF NOT EXIST k4.lic IF NOT EXIST "%QLIC%\k4.lic" IF NOT EXIST "%QHOME%\k4.lic" IF NOT EXIST kc.lic IF NOT EXIST "%QLIC%\kc.lic" IF NOT EXIST "%QHOME%\kc.lic" python "%CONDA_PREFIX%\kdb\kc.lic.py" || echo q non-functional, to re-run the license fetcher reactivate your env >&2
