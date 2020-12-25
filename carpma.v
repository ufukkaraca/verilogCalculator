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
    input clk, rst,
    input [31:0] sayi1, 
    input [31:0] sayi2,
    output reg hazir=0,
    output reg gecerli=0, tasma=0, 
    output reg [63:0] sonuc=0
    );
    
    reg [63:0] sonuc_temp=0;
    integer i;
    reg basla=1;
    
    always @(posedge clk) begin
    if(basla)begin
        sonuc_temp=0;
        sonuc_temp[31:0] = sayi2;
        
        for(i=1; i<=32; i=i+1) begin
        hazir=0; 
                if (sonuc_temp[0] == 1) begin
                    sonuc_temp = {sayi1, 32'b0} + sonuc_temp;  //toplama
                    sonuc_temp = sonuc_temp >> 1;
                end
                else begin
                    sonuc_temp = sonuc_temp >> 1;
                end
         if(i==32)
            sonuc= sonuc_temp;
            hazir=1;      
         end
            gecerli=1;
            tasma=0;
     end
     
     if (rst)begin
        i=1;
        sonuc=0;
     end
            
     end
    
endmodule
