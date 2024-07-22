module counter (clk,clr,count);
input clk,clr;
output reg[N-1:0] count;
parameter N = 8;
always @(negedge clk)
begin 
if (clr) count <= 0;
else count <= count+1;
end
endmodule