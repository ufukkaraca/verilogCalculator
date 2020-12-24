`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.12.2020 21:27:49
// Design Name: 
// Module Name: carpma
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

module carpma(
    input clk, rst, basla,
    input [31:0] sayi1, 
    input [31:0] sayi2,
    output reg [63:0] sonuc=0
    );
    
    reg [5:0] i;
    
    always @(posedge clk) begin
    if(basla)begin
        sonuc[31:0] = sayi2;
        for(i=1; i<=32; i=i+1) begin
                if (sonuc[0] == 1) begin
                    sonuc = {sayi1, 32'b0} + sonuc;  //toplama
                    sonuc = sonuc >> 1;
                end
                else begin
                    sonuc = sonuc >> 1;
                end
         end  
     end
     
     if (rst)begin
        i=1;
        sonuc=0;
     end
            
     end
    
endmodule
