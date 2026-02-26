vlib C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/run_logs/questa/20260227_010123/design_30/work
vmap work C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/run_logs/questa/20260227_010123/design_30/work
vlog -sv -vopt "C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/design_30/src/design_30.sv"
vlog -sv -vopt "C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/design_30/tb/tb_design_30.sv"
vsim -c -onfinish exit tb_design_30 -do {run -all; quit -f}