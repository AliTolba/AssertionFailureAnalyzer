# Verilog/SystemVerilog Bug Suite

Generated on 2026-02-26
Contains 50 designs with intentional RTL bugs and assertion-based testbenches.

## Structure
- design_XX/src : RTL (one or multiple files for complex cases)
- design_XX/tb  : SystemVerilog testbench with assertions

## Batch Run (All 50 Designs)

### Icarus Verilog (Windows/Linux)
- Prereq: `iverilog` and `vvp` available in `PATH`
- Run from suite root:
	- `powershell -ExecutionPolicy Bypass -File ./run_all_iverilog.ps1`
- Optional stop at first failure:
	- `powershell -ExecutionPolicy Bypass -File ./run_all_iverilog.ps1 -StopOnError`

### Questa/ModelSim (Windows/Linux)
- Prereq: `vsim`, `vlog`, `vlib`, `vmap` available in `PATH`
- Run from suite root:
	- `powershell -ExecutionPolicy Bypass -File ./run_all_questa.ps1`
- Optional stop at first failure:
	- `powershell -ExecutionPolicy Bypass -File ./run_all_questa.ps1 -StopOnError`

### Synopsys VCS (Linux)
- Prereq: `vcs` available in `PATH`
- Run from suite root:
	- `bash ./run_all_vcs.sh`

### Logs
- Per-design logs are written under:
	- `run_logs/iverilog/design_XX/run.log`
	- `run_logs/questa/design_XX/run.log`
	- `run_logs/vcs/design_XX/run.log`

## Bug Catalog
- design_01 : valid sticks high after first transaction
- design_02 : reset does not clear valid
- design_03 : off-by-one arithmetic error
- design_04 : width truncation on datapath
- design_05 : zero-latency valid instead of 1-cycle latency
- design_06 : blocking assignment race in sequential path
- design_07 : XOR used instead of ADD
- design_08 : saturating behavior instead of wrap-around
- design_09 : valid pulse length is 2 cycles
- design_10 : uses live b instead of delayed b
- design_11 : latch-like hold by missing else update
- design_12 : ALU uses subtraction instead of addition
- design_13 : valid sticks high after first transaction
- design_14 : reset does not clear valid
- design_15 : off-by-one arithmetic error
- design_16 : width truncation on datapath
- design_17 : zero-latency valid instead of 1-cycle latency
- design_18 : blocking assignment race in sequential path
- design_19 : XOR used instead of ADD
- design_20 : saturating behavior instead of wrap-around
- design_21 : valid pulse length is 2 cycles
- design_22 : uses live b instead of delayed b
- design_23 : latch-like hold by missing else update
- design_24 : ALU uses subtraction instead of addition
- design_25 : valid sticks high after first transaction
- design_26 : reset does not clear valid
- design_27 : off-by-one arithmetic error
- design_28 : width truncation on datapath
- design_29 : zero-latency valid instead of 1-cycle latency
- design_30 : blocking assignment race in sequential path
- design_31 : XOR used instead of ADD
- design_32 : saturating behavior instead of wrap-around
- design_33 : valid pulse length is 2 cycles
- design_34 : uses live b instead of delayed b
- design_35 : latch-like hold by missing else update
- design_36 : ALU uses subtraction instead of addition
- design_37 : valid sticks high after first transaction
- design_38 : reset does not clear valid
- design_39 : off-by-one arithmetic error
- design_40 : width truncation on datapath
- design_41 : zero-latency valid instead of 1-cycle latency
- design_42 : blocking assignment race in sequential path
- design_43 : XOR used instead of ADD
- design_44 : saturating behavior instead of wrap-around
- design_45 : valid pulse length is 2 cycles
- design_46 : uses live b instead of delayed b
- design_47 : latch-like hold by missing else update
- design_48 : ALU uses subtraction instead of addition
- design_49 : valid sticks high after first transaction
- design_50 : reset does not clear valid
