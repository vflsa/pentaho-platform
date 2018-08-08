@echo off

set "dir_changes=src\main\changes"
set "dir_java=src\main\java"
set "file_list_to_chg=(org\pentaho\platform\repository2\unified\fs\FileSystemBackedUnifiedRepository org\pentaho\platform\repository2\unified\fs\FileSystemRepositoryFileDao)"
set "file_list_to_add=(org\pentaho\platform\security\policy\rolebased\AllowAllAuthorizationPolicy)"

REM Loop through files to change...
for %%f in %file_list_to_chg% do (
  REM echo Processing %%f changes...
  del %dir_changes%\%%f_new.java
  copy %dir_java%\%%f.java %dir_changes%\%%f_new.java
  del %dir_java%\%%f.java
  diff3 -m %dir_changes%\%%f_new.java %dir_changes%\%%f_ori.java %dir_changes%\%%f_orichg.java > %dir_java%\%%f.java
  
  if %errorlevel% neq 0 ( 
	echo Error - Conflict trying to change class '%dir_java%\%%f.java'
	exit /b 1 
  ) else (
    echo Successfully changed class '%dir_java%\%%f.java'
  )
)

REM Loop through files to add...
for %%f in %file_list_to_add% do (
  REM echo Processing %%f class...
  copy %dir_changes%\%%f.java %dir_java%\%%f.java
  
  if %errorlevel% neq 0 ( 
	echo Error - Failed creating new class '%dir_java%\%%f.java'
	exit /b 1 
  ) else (
    echo Successfully added new class '%dir_java%\%%f.java'
  )
)
  
exit /b %errorlevel%