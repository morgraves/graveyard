$Path = "B:\BillingMOW\"
$PathDay = "B:\BillingMOW\Archive\Day"
$PathMonth = "B:\BillingMow\Archive\Month"
$PathQuarter = "B:\BillingMow\Archive\Quarter"
$PathYear = "B:\BillingMow\Archive\Year"
$PathOther = "B:\BillingMow\Archive\_Other"
$Day = "-5"
$Mounth = "-1"
$Quarter = "-3"
$CurrentDate = Get-Date
$OldDate = $CurrentDate.AddDays($Day)
$OldM = $CurrentDate.AddMonths($Mounth)
$OldQ = $CurrentDate.AddMonths($Quarter)

#Перенос в папку DAY бэкапов за последние 5 дней
Get-ChildItem $Path | Where-Object { $_.LastWriteTime -gt $OldDate } | Move-Item -Destination $PathDay -force

#Перенос бэкапов из последних 5 в месяц
Get-ChildItem $PathDay | Where-Object { $_.LastWriteTime -lt $OldDate -AND $_.LastWriteTime -gt $OldM} | Move-Item -Destination $PathMonth -force

#Перенос бэкапов из месяца в квартал
Get-ChildItem $PathMonth | Where-Object { $_.LastWriteTime.Day -eq 1 -AND $_.LastWriteTime -gt $OldQ } | Move-Item -Destination $PathQuarter -force

#Перенос бэкапов из месяца в удаление
Get-ChildItem $PathMonth | Where-Object { $_.LastWriteTime -lt $OldM } | Move-Item -Destination $PathOther -force

#Перенос бэкапов из 1 квартала в Год
Get-ChildItem $PathQuarter | Where-Object { $_.LastWriteTime.Month -eq 3 } | Move-Item -Destination $PathYear -force

#Перенос бэкапов из 2 квартала в Год
Get-ChildItem $PathQuarter | Where-Object { $_.LastWriteTime.Month -eq 6 } | Move-Item -Destination $PathYear -force

#Перенос бэкапов из 3 квартала в Год
Get-ChildItem $PathQuarter | Where-Object { $_.LastWriteTime.Month -eq 9 } | Move-Item -Destination $PathYear -force

#Перенос бэкапов из 4 квартала в Год
Get-ChildItem $PathQuarter | Where-Object { $_.LastWriteTime.Month -eq 12 } | Move-Item -Destination $PathYear -force