`timescale 1ns/1ps
module tb_design_19;
  localparam int W = 20;

  logic clk;
  logic rst_n;
  logic start;
  logic [W-1:0] a, b;
  logic [W-1:0] y;
  logic valid;

  design_19 #(.W(W)) dut (
    .clk(clk), .rst_n(rst_n), .start(start), .a(a), .b(b), .y(y), .valid(valid)
  );

  logic [W-1:0] exp_sum_q;
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) exp_sum_q <= '0;
    else if (start) exp_sum_q <= a + b;
  end

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    rst_n = 0; start = 0; a = '0; b = '0;
    repeat (3) @(posedge clk);
    rst_n = 1;

    repeat (10) begin
      @(posedge clk);
      a <= $urandom_range(0, (1<<((W>10)?10:W))-1);
      b <= $urandom_range(0, (1<<((W>10)?10:W))-1);
      start <= 1'b1;
      @(posedge clk);
      start <= 1'b0;
      repeat (2) @(posedge clk);
    end

    repeat (5) @(posedge clk);
    $finish;
  end

  property p_reset_clears_valid;
    @(posedge clk) !rst_n |-> (valid == 1'b0);
  endproperty
  assert property (p_reset_clears_valid) else $error("reset/valid protocol violation");

  property p_valid_one_cycle_after_start;
    @(posedge clk) disable iff (!rst_n) start |=> valid;
  endproperty
  assert property (p_valid_one_cycle_after_start) else $error("latency/valid bug");

  property p_sum_matches_when_valid;
    @(posedge clk) disable iff (!rst_n) valid |-> (y == exp_sum_q);
  endproperty
  assert property (p_sum_matches_when_valid) else $error("datapath mismatch");
endmodule
