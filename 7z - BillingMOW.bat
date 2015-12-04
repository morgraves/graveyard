rem Сжатие 7z резервных копий SQL БД
@echo off

:: Определяем в переменную каталог с бэкапами p, имя папки и архивной базы n.
set P=d:
set n=BillingMOW
:: Определяем текущее время и его формат
set t0=%time:~0,2%
set t1=%time:~3,2%
set t=%t0%%t1%

cd "c:\Scripts\add_arch_sql_base"

:: Создаем архив требуемого формата в нужной директории. Удаляем исходный фаил и записываем результат в обновляемый лог.


::::::::::::::::::::::::функция на сегодня:::::::::::::::::::::::::::

for /f %%i in ('advdatetime -f YYYYMMDD') DO ( set $YYYYMMDD=%%i
C:\7-Zip\7z.exe a "%P%\%n%\%n%_backup_%%i%t%.7z" "%P%:\%n%\%n%_backup_%%i*.bak" %P%\%n%\%n%_backup_%%i*.bak -sdel >>%P%\%n%\log_file.txt
)

::::::::::::::::::::::::функция на вчера:::::::::::::::::::::::::::

for /f %%i in ('advdatetime -f YYYYMMDD -d -1') DO ( set $YYYYMMDD=%%i
C:\7-Zip\7z.exe a "%P%\%n%\%n%_backup_%%i%t%.7z" "%P%:\%n%\%n%_backup_%%i*.bak" %P%\%n%\%n%_backup_%%i*.bak -sdel >>%P%\%n%\log_file.txt
)


::::::::::::::::::::::::функция на позавчера:::::::::::::::::::::::::::

for /f %%i in ('advdatetime -f YYYYMMDD -d -2') DO ( set $YYYYMMDD=%%i
C:\7-Zip\7z.exe a "%P%\%n%\%n%_backup_%%i%t%.7z" "%P%:\%n%\%n%_backup_%%i*.bak" %P%\%n%\%n%_backup_%%i*.bak -sdel >>%P%\%n%\log_file.txt
)
