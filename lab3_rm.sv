module lab3_rm(
					input logic clk,
					input logic reset,
					input logic left, right,
					output logic lc, lb, la, ra, rb, rc);
typedef enum logic [2:0] {S0, S1, S2, S3, S4, S5, S6} statetype;
statetype state, nextstate;

// state register
always_ff @(posedge clk, posedge reset)
if (reset) state <= S0;
else state <= nextstate;

// next state logic
always_comb
					 
case (state)
S0: if (left & ~right & ~reset) nextstate = S1;
else if (right & ~left & ~reset) nextstate = S4;
else nextstate = S0;
S1: if (reset) nextstate = S0;
else nextstate = S2;
S2: if (reset) nextstate = S0;
else nextstate = S3;
S3: nextstate = S0;
S4: if (reset) nextstate = S0;
else nextstate = S5;
S5: if (reset) nextstate = S0;
else nextstate = S6;
S6: nextstate = S0;
default: nextstate = S0;
endcase

// output logic
assign la = (state==S1 | state==S2 |state==S3);
assign lb = (state==S2 |state==S3);
assign lc = (state==S3);
assign ra = (state==S4 | state==S5 |state==S6);
assign rb = (state==S5 |state==S6);
assign rc = (state==S6);

endmodule
