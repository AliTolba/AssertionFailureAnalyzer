vlib C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/run_logs/questa/20260227_010123/design_46/work
vmap work C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/run_logs/questa/20260227_010123/design_46/work
vlog -sv -vopt "C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/design_46/src/design_46.sv"
vlog -sv -vopt "C:/Users/Ali/OneDrive/Desktop/AssertionsAnalyzer/AssertionFailureAnalyzer/Designs/design_46/tb/tb_design_46.sv"
vsim -c -onfinish exit tb_design_46 -do {run -all; quit -f}