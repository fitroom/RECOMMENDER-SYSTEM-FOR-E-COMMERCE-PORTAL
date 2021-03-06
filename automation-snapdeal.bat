
cls
:start
for /f "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do set "dt=%%a"
set "YYYY=%dt:~0,4%"
set "MM=%dt:~4,2%"
set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%"
set "Min=%dt:~10,2%"
set "Sec=%dt:~12,2%"

set datestamp=%YYYY%%MM%%DD%
set timestamp=%HH%%Min%%Sec%
set fullstamp=%DD%-%MM%-%YYYY%_%HH%-%Min%-%Sec%
echo datestamp: "%datestamp%"
echo timestamp: "%timestamp%"
echo fullstamp: "%fullstamp%"
cd c:\snap
scrapy crawl flip1 -o %fullstamp%.json
cd c:\test
python test.py c:/snap/%fullstamp%.json c:/snap/%fullstamp%.link
cd c:\snapfinal
scrapy crawl flip1 -o %fullstamp%.final.json -a category=c:/snap/%fullstamp%.link
pause