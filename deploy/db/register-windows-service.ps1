# Step W6 of the Postgres setup guide: run the dev cluster as a Windows service.
# Run once from an Administrator PowerShell 7 window:
#   pwsh -File D:\Work\projects\Personal\restaurants_promo_app\deploy\db\register-windows-service.ps1
$ErrorActionPreference = 'Stop'
$bin  = 'D:\Apps\pgsql\18\bin'
$data = 'D:\Data\pgsql\18\data'

# Stop a copy started by hand (pg_ctl start), if one is running, so the service can take port 5432.
& "$bin\pg_ctl.exe" -D $data status *> $null
if ($LASTEXITCODE -eq 0) { & "$bin\pg_ctl.exe" -D $data -m fast -w stop }

# The service account needs full control of the data directory.
icacls $data /grant "NT AUTHORITY\NetworkService:(OI)(CI)F" /T /Q

if (-not (Get-Service postgresql-18 -ErrorAction SilentlyContinue)) {
    & "$bin\pg_ctl.exe" register -N postgresql-18 -U "NT AUTHORITY\NetworkService" -D $data -S auto -w
}
Start-Service postgresql-18
Get-Service postgresql-18 | Format-Table Name, Status, StartType
Get-NetTCPConnection -LocalPort 5432 -State Listen | Format-Table LocalAddress, LocalPort, OwningProcess
Get-ChildItem "$data\log" | Sort-Object LastWriteTime | Select-Object -Last 1 | Get-Content -Tail 3
