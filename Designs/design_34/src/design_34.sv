module design_34 #(
  parameter int W = 20
)(
  input  logic         clk,
  input  logic         rst_n,
  input  logic         start,
  input  logic [W-1:0] a,
  input  logic [W-1:0] b,
  output logic [W-1:0] y,
  output logic         valid
);
  logic [W-1:0] a_d, b_d;
  logic         start_d;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      y <= {W{1'b0}}; valid <= 1'b0; a_d <= {W{1'b0}}; b_d <= {W{1'b0}}; start_d <= 1'b0;
    end else begin
      a_d <= a;
      b_d <= b;
      start_d <= start;
      if (start_d)
        y <= a_d + b;
      valid <= start_d;
    end
  end
endmodule
