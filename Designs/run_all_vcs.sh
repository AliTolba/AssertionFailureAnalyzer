#!/usr/bin/env bash
set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_ROOT="$ROOT/run_logs/vcs"
mkdir -p "$LOG_ROOT"

pass=0
fail=0

for d in "$ROOT"/design_[0-9][0-9]; do
  [[ -d "$d" ]] || continue
  name="$(basename "$d")"
  tb_top="tb_${name}"
  case_dir="$LOG_ROOT/$name"
  mkdir -p "$case_dir"

  shopt -s nullglob
  src_files=("$d"/src/*.v "$d"/src/*.sv)
  tb_files=("$d"/tb/tb_${name}.sv)
  shopt -u nullglob

  if (( ${#src_files[@]} == 0 || ${#tb_files[@]} == 0 )); then
    echo "[FAIL] $name (missing src or tb file)"
    ((fail++))
    continue
  fi

  build="$case_dir/simv"
  log="$case_dir/run.log"

  {
    echo "=== $name : compile ==="
    vcs -full64 -sverilog -timescale=1ns/1ps -top "$tb_top" -o "$build" "${src_files[@]}" "${tb_files[@]}"
    cstat=$?
    if (( cstat != 0 )); then
      echo "COMPILE_FAIL"
      exit 10
    fi

    echo "=== $name : run ==="
    "$build"
    rstat=$?
    if (( rstat != 0 )); then
      echo "RUN_FAIL"
      exit 11
    fi
  } >"$log" 2>&1

  status=$?
  if (( status == 0 )); then
    echo "[PASS] $name"
    ((pass++))
  else
    echo "[FAIL] $name"
    ((fail++))
  fi

done

echo
echo "Summary: PASS=$pass FAIL=$fail TOTAL=$((pass + fail))"
if (( fail > 0 )); then
  exit 1
else
  exit 0
fi
