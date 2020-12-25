`timescale 1ns / 1ps


//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Alpkan Atilla
// 
// Create Date: 23.12.2020 23:38:20
// Design Name: 
// Module Name: tan
// Project Name: tantana
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


module tan(
input[31:0] sayi1,
input clk,
input rst,
output reg[63:0] sonuc,
output reg hazir,
output reg gecerli
    );
    localparam PI = 3.14159265;
    
   
    reg[31:0] yenisayi1;

    

    
    always@(posedge clk)begin
    
    yenisayi1 = sayi1;
    
   if (sayi1 < 0)begin
    yenisayi1 = -sayi1;
   end 
   //negatif degerlerden kurtulmak icin
   
   if((sayi1*(10**8)) > (314159265/2)) begin
    yenisayi1 = ((sayi1*(10**8))%(314159265/2))/(10**8);
    end
   //tanjantin araligini korumak icin
    
    
    sonuc = ((yenisayi1**13)*21844*(32'b10000000000000000000000000000000)/6081075 + (yenisayi1**11)*1382*(32'b10000000000000000000000000000000)/155925 + (yenisayi1**9)*62*(32'b10000000000000000000000000000000)/2835 + (yenisayi1**7)*17*(32'b10000000000000000000000000000000)/315 + (yenisayi1**5)*2*(32'b10000000000000000000000000000000)/15 + (yenisayi1**3)*(32'b10000000000000000000000000000000)/3 + yenisayi1*(32'b10000000000000000000000000000000));
    //yukardaki satir tamamen maclaurin serisi
    hazir = 1;
    gecerli = 1;
    
    if (rst)begin
        sonuc = 0;
        hazir = 0;
        gecerli = 1;
     end
    
    end
endmodule
