module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
); 
    wire [3:0] enaw;
    assign enaw = {
        (mm == 8'h59 && ss == 8'h59),
        (ss == 8'h59),
        (mm[3:0] == 4'd9 && ss == 8'h59),
        (ss[3:0] == 4'd9 && ena)
    };

    decade_counterh h2 (clk, reset, enaw[3], hh);
    decade_counter m0 (clk, reset, enaw[2], mm[3:0]);
    decade_counter3 m1 (clk, reset, enaw[1], mm[7:4]);
    decade_counter s0 (clk, reset, ena, ss[3:0]);
    decade_counter3 s1 (clk, reset, enaw[0], ss[7:4]);

    always @(posedge clk) begin
        if (reset)
            pm <= 0;
        else if (enaw[3] && hh == 8'h11) // hh == 12
            pm <= ~pm;
    end
endmodule

module decade_counter(
    input clk,
    input reset,
    input ena,
    output reg [3:0] q
);
    always @(posedge clk) begin
        if (reset)
            q <= 4'b0;
        else if (q == 4'd9 && ena)
            q <= 4'b0;
        else if (ena)
            q <= q + 4'b1;
    end
endmodule

module decade_counterh(
    input clk,
    input reset,
    input ena,
    output reg [7:0] Q
);
    reg [3:0] q;
    initial q <= 4'd1;

    always @(posedge clk) begin
        if (reset)
            q <= 4'd12;
        else if (q == 4'd12 && ena)
            q <= 4'd1;
        else if (ena)
            q <= q + 4'd1;
    end

    always @* begin
        case (q)
            4'd1: Q = 8'h01;
            4'd2: Q = 8'h02;
            4'd3: Q = 8'h03;
            4'd4: Q = 8'h04;
            4'd5: Q = 8'h05;
            4'd6: Q = 8'h06;
            4'd7: Q = 8'h07;
            4'd8: Q = 8'h08;
            4'd9: Q = 8'h09;
            4'd10: Q = 8'h10;
            4'd11: Q = 8'h11;
            4'd12: Q = 8'h12;
            default: Q = 8'h00;
        endcase
    end
endmodule

module decade_counter3(
    input clk,
    input reset,
    input ena,
    output reg [3:0] q
);
    always @(posedge clk) begin
        if (reset)
            q <= 4'b0;
        else if (q == 4'd5 && ena)
            q <= 4'b0;
        else if (ena)
            q <= q + 4'b1;
    end
endmodule
