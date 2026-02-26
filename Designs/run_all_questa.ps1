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

$runRoot = Join-Path $Root 'run_logs\questa'
New-Item -ItemType Directory -Path $runRoot -Force | Out-Null

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

  $caseDir = Join-Path $runRoot $name
  New-Item -ItemType Directory -Path $caseDir -Force | Out-Null
  $workDir = Join-Path $caseDir 'work'
  if (Test-Path $workDir) { Remove-Item $workDir -Recurse -Force }

  $doPath = Join-Path $caseDir 'run.do'
  $logPath = Join-Path $caseDir 'run.log'

  $do = @()
  $do += "vlib $workDir"
  $do += "vmap work $workDir"
  foreach ($f in $srcFiles) { $do += "vlog -sv {\"$($f.FullName)\"}" }
  $do += "vlog -sv {\"$($tbFile.FullName)\"}"
  $do += "vsim -c -onfinish exit $tbTop -do {run -all; quit -f}"
  Set-Content -Path $doPath -Value ($do -join "`r`n") -Encoding UTF8

  $out = & vsim -c -do $doPath 2>&1
  $out | Out-File -FilePath $logPath -Encoding utf8

  if ($LASTEXITCODE -eq 0) {
    Write-Host "[PASS] $name" -ForegroundColor Green
    $pass++
  } else {
    Write-Host "[FAIL] $name" -ForegroundColor Red
    $fail++
    if ($StopOnError) { break }
  }
}

Write-Host ""
Write-Host "Summary: PASS=$pass FAIL=$fail TOTAL=$($pass + $fail)"
if ($fail -gt 0) { exit 1 } else { exit 0 }
