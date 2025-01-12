//State transitions
`define S0 4'b0000
`define S1 4'b0001
`define S2 4'b0010
`define S3 4'b0011
`define S4 4'b0100
`define S5 4'b0101
`define OPEN 4'b0110 
`define S0o 4'b0111 
`define S1o 4'b1000
`define S2o 4'b1001
`define S3o 4'b1010
`define S4o 4'b1011
`define S5o 4'b1100
`define CLOSED 4'b1101

module lock(SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,LEDR);

//Inputs and outputs
	input [3:0] SW;
	input [3:0] KEY;
	output reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;  

	wire clk = ~KEY[0];  // this is your clock
	wire rst_n = ~KEY[3];

	reg [3:0] PS;

//State machine sequential logic
	always_ff @(posedge clk) begin
		if (rst_n) begin 
			PS<=`S0;
		end
		else begin
			case(PS)
				`S0: if(SW==(4'b0011)) PS<=`S1;
					else PS<=`S0o;
				`S1: if(SW==(4'b0110)) PS<=`S2;
					else PS<=`S1o;
				`S2: if(SW==(4'b0011)) PS<=`S3;
					else PS<=`S2o;
				`S3: if(SW==(4'b0110)) PS<=`S4;
					else PS<=`S3o;
				`S4: if(SW==(4'b1001)) PS<=`S5;
					else PS<=`S4o;
				`S5: if(SW==(4'b0110)) PS<=`OPEN;
					else PS<=`S5o;
				`OPEN: if (rst_n) PS<=`S0;
					else PS<=`OPEN;
				`S0o: PS<=`S1o;
				`S1o: PS<=`S2o;
				`S2o: PS<=`S3o;
				`S3o: PS<=`S4o;
				`S4o: PS<=`S5o;
				`S5o: PS<=`CLOSED;
				`CLOSED: if (rst_n) PS=`S0;
					else PS<=`CLOSED;
				default PS<=`S0;
			endcase
		end
	end

//Combinational and display logic
	always_comb begin
		case(PS)
			`OPEN: 
			begin
			    HEX0=7'b0101011;
				HEX1=7'b0000110;
				HEX2=7'b0001100;
				HEX3=7'b1000000;
			    HEX4=7'b1111111;
			    HEX5=7'b1111111;
			end
			`CLOSED: 
			begin
				HEX0=7'b1000000;
				HEX1=7'b0000110;
				HEX2=7'b0010010;
				HEX3=7'b1000000;
				HEX4=7'b1000111;
				HEX5=7'b1000110;
			end
			default:
				case (SW)
					4'b0000: if (SW==(4'b0000)) begin 
						HEX0=7'b1000000;
						HEX1=7'b1111111;
						HEX2=7'b1111111;
						HEX3=7'b1111111;
						HEX4=7'b1111111;
						HEX5=7'b1111111;
					end
					4'b0001: if (SW==(4'b0001)) begin
						HEX0=7'b1111001;
						HEX1=7'b1111111;
						HEX2=7'b1111111;
						HEX3=7'b1111111;
						HEX4=7'b1111111;
						HEX5=7'b1111111;
					end
					4'b0010: if (SW==(4'b0010)) begin
						HEX0=7'b0100100;
						HEX1=7'b1111111;
						HEX2=7'b1111111;
						HEX3=7'b1111111;
						HEX4=7'b1111111;
						HEX5=7'b1111111;
					end
					4'b0011: if (SW==(4'b0011)) begin
						HEX0=7'b0110000;
						HEX1=7'b1111111;
						HEX2=7'b1111111;
						HEX3=7'b1111111;
						HEX4=7'b1111111;
						HEX5=7'b1111111;
					end
					4'b0100: if (SW==(4'b0100)) begin
						HEX0=7'b0011001;
						HEX1=7'b1111111;
						HEX2=7'b1111111;
						HEX3=7'b1111111;
						HEX4=7'b1111111;
						HEX5=7'b1111111;
					end
					4'b0101: if (SW==(4'b0101)) begin
						HEX0=7'b0010010;
						HEX1=7'b1111111;
						HEX2=7'b1111111;
						HEX3=7'b1111111;
						HEX4=7'b1111111;
						HEX5=7'b1111111;
					end
					4'b0110: if (SW==(4'b0110)) begin
						HEX0=7'b0000010;
						HEX1=7'b1111111;
						HEX2=7'b1111111;
						HEX3=7'b1111111;
						HEX4=7'b1111111;
						HEX5=7'b1111111;
					end
					4'b0111: if (SW==(4'b0111)) begin
						HEX0=7'b1111000;
						HEX1=7'b1111111;
						HEX2=7'b1111111;
						HEX3=7'b1111111;
						HEX4=7'b1111111;
						HEX5=7'b1111111;
					end
					4'b1000: if (SW==(4'b1000)) begin
						HEX0=7'b0000000;
						HEX1=7'b1111111;
						HEX2=7'b1111111;
						HEX3=7'b1111111;
						HEX4=7'b1111111;
						HEX5=7'b1111111;
					end
					4'b1001: if (SW==(4'b1001)) begin
						HEX0=7'b0010000;
						HEX1=7'b1111111;
						HEX2=7'b1111111;
						HEX3=7'b1111111;
						HEX4=7'b1111111;
						HEX5=7'b1111111;
					end
					default: begin
						HEX0=7'b0101111;
						HEX1=7'b1000000;
						HEX2=7'b0101111;
						HEX3=7'b0101111;
						HEX4=7'b0000110;
						HEX5=7'b1111111;
					end
				endcase
		endcase
	end
endmodule