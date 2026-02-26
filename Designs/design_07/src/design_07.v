module design_07 #(
  parameter W = 12
)(
  input              clk,
  input              rst_n,
  input              start,
  input      [W-1:0] a,
  input      [W-1:0] b,
  output reg [W-1:0] y,
  output reg         valid
);
  reg [W-1:0] a_d, b_d;
  reg         start_d;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      y <= {W{1'b0}}; valid <= 1'b0; a_d <= {W{1'b0}}; b_d <= {W{1'b0}}; start_d <= 1'b0;
    end else begin
      a_d <= a;
      b_d <= b;
      start_d <= start;
      if (start_d)
        y <= a_d ^ b_d;
      valid <= start_d;
    end
  end
endmodule
