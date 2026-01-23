@ECHO OFF
SETLOCAL

SET "BASEDIR=%~dp0"
SET "WRAPPER_DIR=%BASEDIR%.mvn\wrapper"
SET "WRAPPER_JAR=%WRAPPER_DIR%\maven-wrapper.jar"
SET "WRAPPER_PROPS=%WRAPPER_DIR%\maven-wrapper.properties"

IF EXIST "%JAVA_HOME%\bin\java.exe" (
  SET "JAVA_EXE=%JAVA_HOME%\bin\java.exe"
) ELSE (
  SET "JAVA_EXE=java"
)

IF NOT EXIST "%WRAPPER_JAR%" (
  IF NOT EXIST "%WRAPPER_DIR%" MKDIR "%WRAPPER_DIR%"
  FOR /F "usebackq tokens=1,2 delims==" %%A IN ("%WRAPPER_PROPS%") DO (
    IF "%%A"=="wrapperUrl" SET "WRAPPER_URL=%%B"
  )
  IF "%WRAPPER_URL%"=="" (
    ECHO wrapperUrl not found in %WRAPPER_PROPS%
    EXIT /B 1
  )
  ECHO Downloading Maven Wrapper JAR from %WRAPPER_URL%
  POWERSHELL -NoProfile -ExecutionPolicy Bypass -Command ^
    "Invoke-WebRequest -Uri '%WRAPPER_URL%' -OutFile '%WRAPPER_JAR%'"
)

REM Find project base dir
SET "MAVEN_PROJECTBASEDIR="
SET "CUR=%CD%"
:findPom
IF EXIST "%CUR%\pom.xml" (
  SET "MAVEN_PROJECTBASEDIR=%CUR%"
) ELSE (
  CD /D "%CUR%\.."
  SET "CUR=%CD%"
  IF "%CUR%"=="%SystemDrive%\" GOTO afterFind
  GOTO findPom
)
:afterFind
IF "%MAVEN_PROJECTBASEDIR%"=="" SET "MAVEN_PROJECTBASEDIR=%BASEDIR%"

"%JAVA_EXE%" -Dmaven.wrapper.log.level=INFO ^
 "-Dmaven.multiModuleProjectDirectory=%MAVEN_PROJECTBASEDIR%" ^
 -cp "%WRAPPER_JAR%" org.apache.maven.wrapper.MavenWrapperMain %*
