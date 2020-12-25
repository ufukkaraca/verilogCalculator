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
	

	reg [31:0] temp_sonuc;
	reg [31:0] temp_sayi1;
	reg [31:0] temp_sayi2;
	reg [32:0] carry_out;                   //  Her bir tur icin carry tutar
	reg temp_hazir;
	reg temp_gecerli;
	reg temp_carry;
	integer i;
	
	initial begin
	   temp_sonuc = 32'b0;
	   temp_sayi1 = 32'b0;
	   temp_sayi2 = 32'b0;
	   carry_out = 33'b0;
	   temp_hazir = 1'b1;
	   temp_gecerli = 1'b0;
	   temp_carry = 1'b0;
	   i = 0;	
	end
	
	always@(posedge clk) begin
	   if (temp_hazir) begin
	       temp_hazir <= 1'b0;
	       temp_sonuc <= 32'b0;
	       temp_sayi1 <= sayi1;
	       temp_sayi2 <= ~sayi2 + 1;
	       carry_out <= 33'b0;
	       temp_carry <= 1'b0;
	       i=0;
	   end
	   
	   else begin
	       if (i<=6'd32)
	           i <= i+1'd1;
	       
	       case({carry_out[i-1], temp_sayi1[i-1], temp_sayi2[i-1]})
	           3'b000: begin
	               carry_out[i]<=1'b0; temp_sonuc[i-1]<=1'b0;
	           end
	           3'b001: begin
	               carry_out[i]<=1'b0; temp_sonuc[i-1]<=1'b1;
	           end
	           3'b010: begin
	               carry_out[i]<=1'b0; temp_sonuc[i-1]<=1'b1;
	           end
	           3'b011: begin
	               carry_out[i]<=1'b1; temp_sonuc[i-1]<=1'b0;
	           end
	           3'b100: begin
	               carry_out[i]<=1'b0; temp_sonuc[i-1]<=1'b1;
	           end
	           3'b101: begin
	               carry_out[i]<=1'b1; temp_sonuc[i-1]<=1'b0;
	           end
	           3'b110: begin
	               carry_out[i]<=1'b1; temp_sonuc[i-1]<=1'b0;
	           end
	           3'b111: begin
	               carry_out[i]<=1'b1; temp_sonuc[i-1]<=1'b1;
	           end
	       endcase
	       
	       if( i>6'd32 ) begin
	           temp_hazir <= 1'b1;
	           temp_gecerli <= 1'b1;
	           i=0;
	           if ( carry_out[32] )
	               temp_carry = 1'b1;	       
	       end
	       
	   end
	   
	end

    assign sonuc[63:0] = {15'b0, temp_carry, temp_sonuc, 16'b0};
    assign hazir = temp_hazir;
    assign gecerli = temp_gecerli;
    assign tasma = 1'b0;                    //  Sonuc alanimiz 64b. Iki 32b toplami asla 64b'den buyuk olamaz.

endmodule
    
