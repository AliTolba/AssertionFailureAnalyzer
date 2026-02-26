vlib C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/run_logs/questa/20260227_010123/design_10/work
vmap work C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/run_logs/questa/20260227_010123/design_10/work
vlog -sv -vopt "C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/design_10/src/design_10.sv"
vlog -sv -vopt "C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/design_10/tb/tb_design_10.sv"
vsim -c -onfinish exit tb_design_10 -do {run -all; quit -f}