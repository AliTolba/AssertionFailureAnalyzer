module design_44 #(
  parameter W = 20
)(
  input              clk,
  input              rst_n,
  input              start,
  input      [W-1:0] a,
  input      [W-1:0] b,
  output     [W-1:0] y,
  output             valid
);
  reg [W-1:0] a_q, b_q;
  wire [W-1:0] y_c;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      a_q <= {W{1'b0}};
      b_q <= {W{1'b0}};
    end else begin
      a_q <= a;
      b_q <= b;
    end
  end

  design_44_core #(.W(W)) u_core (.a_q(a_q), .b_q(b_q), .y_c(y_c));
  design_44_ctrl           u_ctrl (.clk(clk), .rst_n(rst_n), .start(start), .valid(valid));
  assign y = y_c;
endmodule
