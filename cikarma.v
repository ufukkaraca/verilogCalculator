`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2020 11:15:17 AM
// Design Name: 
// Module Name: cikarma
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cikarma
    (
	input 	[31:0] sayi1,
	input 	[31:0] sayi2,
	input 	clk,
	output 	[63:0] sonuc,
	output 	hazir,
	output  gecerli,
	output	tasma
	);
	

	reg [31:0] temp_sayi1;
	reg [31:0] temp_sayi2;
	reg [31:0] temp_sayi2_complement;
    wire [31:0] temp_sonuc;
	reg temp_hazir;
	wire temp_hazir2;
	wire temp_gecerli;
	wire temp_tasma;
	
	reg [31:0] son_sonuc;
	reg son_gecerli;
	reg son_tasma;
	
	initial begin

	   temp_sayi1 = 32'b0;
	   temp_sayi2 = 32'b0;
	   temp_hazir = 1'b1;

	end
	
	toplama t1(.sayi1(temp_sayi1), .sayi2(temp_sayi2_complement+1), .clk(clk), .sonuc(temp_sonuc), .hazir(temp_hazir2), .gecerli(temp_gecerli), .tasma(temp_tasma));		
	
	always@(posedge clk) begin
	   if (temp_hazir) begin
	       temp_hazir <= 1'b0;
	       temp_sayi1 <= sayi1;
	       temp_sayi2 <= sayi2;
	   end
	   
	   else if (!temp_hazir && temp_hazir2) begin
	       temp_hazir <= 1'b1;
	       son_sonuc <= temp_sonuc;
	       son_gecerli <= temp_gecerli;
	       son_tasma <= temp_tasma;
	   end
	   
	
	end
	
	
	always@* begin
        temp_sayi2_complement[0] = ~temp_sayi2[0];
        temp_sayi2_complement[1] = ~temp_sayi2[1];
        temp_sayi2_complement[2] = ~temp_sayi2[2];
        temp_sayi2_complement[3] = ~temp_sayi2[3];
        temp_sayi2_complement[4] = ~temp_sayi2[4];
        temp_sayi2_complement[5] = ~temp_sayi2[5];
        temp_sayi2_complement[6] = ~temp_sayi2[6];
        temp_sayi2_complement[7] = ~temp_sayi2[7];
        temp_sayi2_complement[8] = ~temp_sayi2[8];
        temp_sayi2_complement[9] = ~temp_sayi2[9];
        temp_sayi2_complement[10] = ~temp_sayi2[10];
        temp_sayi2_complement[11] = ~temp_sayi2[11];
        temp_sayi2_complement[12] = ~temp_sayi2[12];
        temp_sayi2_complement[13] = ~temp_sayi2[13];
        temp_sayi2_complement[14] = ~temp_sayi2[14];
        temp_sayi2_complement[15] = ~temp_sayi2[15];
        temp_sayi2_complement[16] = ~temp_sayi2[16];
        temp_sayi2_complement[17] = ~temp_sayi2[17];
        temp_sayi2_complement[18] = ~temp_sayi2[18];
        temp_sayi2_complement[19] = ~temp_sayi2[19];
        temp_sayi2_complement[20] = ~temp_sayi2[20];
        temp_sayi2_complement[21] = ~temp_sayi2[21];
        temp_sayi2_complement[22] = ~temp_sayi2[22];
        temp_sayi2_complement[23] = ~temp_sayi2[23];
        temp_sayi2_complement[24] = ~temp_sayi2[24];
        temp_sayi2_complement[25] = ~temp_sayi2[25];
        temp_sayi2_complement[26] = ~temp_sayi2[26];
        temp_sayi2_complement[27] = ~temp_sayi2[27];
        temp_sayi2_complement[28] = ~temp_sayi2[28];
        temp_sayi2_complement[29] = ~temp_sayi2[29];
        temp_sayi2_complement[30] = ~temp_sayi2[30];
        temp_sayi2_complement[31] = ~temp_sayi2[31];
    end
    
    assign sonuc = son_sonuc;
    assign tasma = son_tasma;
    assign gecerli = son_gecerli;
    assign hazir = temp_hazir;
    
endmodule
