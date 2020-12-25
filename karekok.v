`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.12.2020 15:24:52
// Design Name: 
// Module Name: karekok
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


module karekok(
    input 	[31:0] sayi,
	input 	clk,
	output 	reg [63:0] sonuc,
	output reg	hazir,
	output reg gecerli,
	output reg	tasma
    );
    reg [31:0] temp_sayi;
    reg[15:0] temp_sonuc;
 	reg	temp_hazir;
	reg temp_gecerli;
	reg	temp_tasma;   
    integer i;
    reg [17:0] sol,sag,hatirlat;
    reg [11:0] bolen;
    reg [63:0] bolme_sonucu;
initial begin
bolen=12'b000100000000; //256
temp_sonuc=0;
sol=0;
sag=0;
hatirlat=0;
i=0;
end   
    
always@(posedge clk) begin
     
     for(i=0;i<16;i=i+1) begin 
        sag = {temp_sonuc,hatirlat[17],1'b1};
        sol = {hatirlat[15:0],sayi[31:30]};
        temp_sayi = {sayi[29:0],2'b00};    //2 bit sola kaydýrdýk
        if (hatirlat[17] == 1) //hatýrlatýcý negatifse topluyoruz
            hatirlat= sol + sag;
        else    //hatýrlatýcý pozitifse çýkarýyoruz
            hatirlat = sol - sag;
        temp_sonuc = {temp_sonuc[14:0],!hatirlat[17]};       
    end
   
   
    temp_sayi={8'b0, temp_sonuc, 8'b0};
    
    bolme bolme1(.bolunen(temp_sayi),
    .bolen(bolen),
    .clk(clk),
    .hazir(hazir),
    .gecerli(gecerli),
    .tasma(tasma),
    .sonuc(bolme_sonucu));
    
    sonuc<=bolme_sonucu;
 
  end
    
endmodule
