module sequence_detector(input x,clk,reset, output reg z);
	parameter S0=0, S1=1, S2=2, S3=3;
	reg [0:1] PS,NS;
	
	always @(posedge clk or posedge reset) begin
		if(reset) PS<= S0;
		else PS<=NS;
	end
	
	always @(PS,x) begin
		case(PS)
			S0: begin
				z= 0;
				NS = x ? S1 : S0;
				end
			
			S1: begin
				z=0;
				NS =x ? S1: S2;
				end
			
			S2: begin
				z=0;
				NS = x ? S3 : S0;
				end
			
			S3: begin
				z= x ? 0 : 1;
				NS= x ? S1 : S2;
				end
		endcase
	end
endmodule