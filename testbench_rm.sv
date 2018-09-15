module testbench_rm();
		logic clk, left, right, reset;
		logic lc, lb, la, ra, rb, rc;
lab3_rm dut(
				clk, reset, left, right,
				lc, lb, la, ra, rb, rc);
initial
forever begin
clk = 0; #50; clk = 1; #50;
end
initial begin
#100;
left = 1;
right = 0;
reset = 0;
#400;
left = 0;
right = 0;
reset = 1;
#100;
left = 0;
right = 1;
reset = 0;
#400;
left = 0;
right = 0;
reset = 1;
#100;
left = 1;
right = 1;
reset = 0;
#400;
end
endmodule