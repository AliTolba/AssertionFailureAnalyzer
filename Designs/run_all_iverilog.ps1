param(
  [string]$Root = $PSScriptRoot,
  [switch]$StopOnError
)

$ErrorActionPreference = 'Stop'
$designDirs = Get-ChildItem -Path $Root -Directory |
  Where-Object { $_.Name -match '^design_\d+$' } |
  Sort-Object Name

if (-not $designDirs) {
  Write-Error "No design_XX directories found under $Root"
}

$buildRoot = Join-Path $Root 'run_logs\iverilog'
New-Item -ItemType Directory -Path $buildRoot -Force | Out-Null

$pass = 0
$fail = 0

foreach ($dir in $designDirs) {
  $name = $dir.Name
  $srcDir = Join-Path $dir.FullName 'src'
  $tbDir = Join-Path $dir.FullName 'tb'
  $tbTop = "tb_$name"

  $srcFiles = @(Get-ChildItem -Path $srcDir -File | Where-Object { $_.Extension -in '.v', '.sv' } | Sort-Object Name)
  $tbFile = Get-ChildItem -Path $tbDir -File -Filter "tb_$name.sv" | Select-Object -First 1

  if (-not $srcFiles -or -not $tbFile) {
    Write-Host "[FAIL] $name (missing src or tb file)" -ForegroundColor Red
    $fail++
    if ($StopOnError) { break }
    continue
  }

  $caseDir = Join-Path $buildRoot $name
  New-Item -ItemType Directory -Path $caseDir -Force | Out-Null
  $vvpPath = Join-Path $caseDir "$name.vvp"
  $logPath = Join-Path $caseDir 'run.log'
  if (Test-Path $logPath) { Remove-Item $logPath -Force }

  "=== $name : compile ===" | Out-File -FilePath $logPath -Encoding utf8
  $compileArgs = @('-g2012', '-s', $tbTop, '-o', $vvpPath) + $srcFiles.FullName + $tbFile.FullName
  $compileOut = & iverilog @compileArgs 2>&1
  $compileOut | Out-File -FilePath $logPath -Append -Encoding utf8

  if ($LASTEXITCODE -ne 0) {
    Write-Host "[FAIL] $name (compile)" -ForegroundColor Red
    $fail++
    if ($StopOnError) { break }
    continue
  }

  "=== $name : run ===" | Out-File -FilePath $logPath -Append -Encoding utf8
  $runOut = & vvp $vvpPath 2>&1
  $runOut | Out-File -FilePath $logPath -Append -Encoding utf8

  if ($LASTEXITCODE -eq 0) {
    Write-Host "[PASS] $name" -ForegroundColor Green
    $pass++
  } else {
    Write-Host "[FAIL] $name (run)" -ForegroundColor Red
    $fail++
    if ($StopOnError) { break }
  }
}

Write-Host "" 
Write-Host "Summary: PASS=$pass FAIL=$fail TOTAL=$($pass + $fail)"
if ($fail -gt 0) { exit 1 } else { exit 0 }
