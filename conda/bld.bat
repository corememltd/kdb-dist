mkdir "%PREFIX%\%PKG_NAME%\w%ARCH%" || goto :eof
copy "%SRC_DIR%\w%ARCH%\q.exe" "%PREFIX%\%PKG_NAME%\w%ARCH%\q.exe" || goto :eof
copy "%SRC_DIR%\q.k" "%PREFIX%\%PKG_NAME%" || goto :eof
copy "%RECIPE_DIR%\q.bat" "%SCRIPTS%\q.bat" || goto :eof

copy "%RECIPE_DIR%\..\kc.lic.py" "%PREFIX%\%PKG_NAME%" || goto :eof

FOR %%C IN (activate deactivate) DO (
	mkdir "%PREFIX%\etc\conda\%%C.d" || goto :eof
	copy "%RECIPE_DIR%\%%C.bat" "%PREFIX%\etc\conda\%%C.d\%PKG_NAME%-%%C.bat" || goto :eof
)
