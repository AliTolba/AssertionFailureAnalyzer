module design_20_core #(
  parameter W = 8
)(
  input      [W-1:0] a_q,
  input      [W-1:0] b_q,
  output reg [W-1:0] y_c
);
  always @* begin
    y_c = a_q + b_q + 1'b1;
  end
endmodule
