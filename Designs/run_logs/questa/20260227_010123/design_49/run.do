vlib C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/run_logs/questa/20260227_010123/design_49/work
vmap work C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/run_logs/questa/20260227_010123/design_49/work
vlog -sv -vopt "C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/design_49/src/design_49.v"
vlog -sv -vopt "C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/design_49/tb/tb_design_49.sv"
vsim -c -onfinish exit tb_design_49 -do {run -all; quit -f}