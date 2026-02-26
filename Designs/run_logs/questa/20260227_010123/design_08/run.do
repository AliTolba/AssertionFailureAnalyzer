vlib C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/run_logs/questa/20260227_010123/design_08/work
vmap work C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/run_logs/questa/20260227_010123/design_08/work
vlog -sv -vopt "C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/design_08/src/design_08.v"
vlog -sv -vopt "C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/design_08/src/design_08_core.v"
vlog -sv -vopt "C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/design_08/src/design_08_ctrl.v"
vlog -sv -vopt "C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/design_08/tb/tb_design_08.sv"
vsim -c -onfinish exit tb_design_08 -do {run -all; quit -f}