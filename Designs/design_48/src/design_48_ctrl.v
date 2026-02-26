module design_48_ctrl(
  input  clk,
  input  rst_n,
  input  start,
  output reg valid
);
  reg start_q;
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      valid <= 1'b0;
      start_q <= 1'b0;
    end else begin
      start_q <= start;
      valid <= start;
    end
  end
endmodule
