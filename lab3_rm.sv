module Lab3(input logic CLOCK_50,
	input logic [2:0] KEY,
	output [5:0] LEDR);
	
	typedef enum logic [2:0] {OFF, HAZ, L1, L2, L3, R1, R2, R3} State;
	
	logic [5:0] LIGHTS;
	
	State currentstate = OFF, nextstate;
	
	logic [5:0] counter;
	logic enable;
	
	always @(posedge CLOCK_50)
		begin 
			enable = counter[24];
			counter = counter + 1'b1;
		end

	always @(posedge enable)
		begin
		if(~KEY[2]) currentstate = OFF;
		else currentstate = nextstate;
		
		case(currentstate)
			OFF:
				begin
					LIGHTS = 6'b000000;
					if(KEY[0] && ~KEY[1]) nextstate = L1;
					else if(~KEY[0] && KEY[1]) nextstate = R1;
					else if(~KEY[0] && ~KEY[1]) nextstate = HAZ;
					else nextstate = L1;
				end
			L1:
				begin
					LIGHTS = 6'b001000;
					if(KEY[0] && ~KEY[1]) nextstate = L2;
					else if(~KEY[0] && KEY[1]) nextstate = R1;
					else if(~KEY[0] && ~KEY[1]) nextstate = HAZ;
					else nextstate = L2;
				end
			L2:	
				begin
					LIGHTS = 6'b011000;
					if(KEY[0] && ~KEY[1]) nextstate = L3;
					else if(~KEY[0] && KEY[1]) nextstate = R1;
					else if(~KEY[0] && ~KEY[1]) nextstate = HAZ;
					else nextstate = L3;
				end
			L3:
				begin
					LIGHTS = 6'b111000;
					if(KEY[0] && ~KEY[1]) nextstate = OFF;
					else if(~KEY[0] && KEY[1]) nextstate = R1;
					else if(~KEY[0] && ~KEY[1]) nextstate = HAZ;
					else nextstate = OFF;
				end
			R1:
				begin
					LIGHTS = 6'b000100;
					if(~KEY[0] && KEY[1]) nextstate = R2;
					else if(KEY[0] && ~KEY[1]) nextstate = L1;
					else if(~KEY[0] && ~KEY[1]) nextstate = HAZ;
					else nextstate = R2;
				end
			R2:
				begin
					LIGHTS = 6'b000110;
					if(~KEY[0] && KEY[1]) nextstate = R3;
					else if(KEY[0] && ~KEY[1]) nextstate = L1;
					else if(~KEY[0] && ~KEY[1]) nextstate = HAZ;
					else nextstate = R2;
				end
			R3:
				begin
					LIGHTS = 6'b000111;
					if(~KEY[0] && KEY[1]) nextstate = OFF;
					else if(KEY[0] && ~KEY[1]) nextstate = L1;
					else if(~KEY[0] && ~KEY[1]) nextstate = HAZ;
					else nextstate = OFF;
				end
			HAZ:
				begin
					LIGHTS = 6'b111111;
					
				end
		endcase
	end
	
	assign LEDR = LIGHTS;
	
endmodule