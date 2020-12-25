`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.12.2020 13:20:58
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


module karekok
    (
    input [31:0] sayi,
    input clk,
    output [63:0] sonuc,
    output hazir,
    output gecerli,
    output tasma
    );

    reg [31:0] temp_sayi;
    reg [15:0] temp_sonuc;
    reg [15:0] temp;
    reg temp_hazir = 1;
    reg [17:0] sol,sag,hatirlat;
    wire [63:0] sonuc_wire; 
    integer i;


    bolme b1(.bolunen({8'b0, temp, 8'b0}), .bolen({7'b0, 9'b100000000, 16'b0}), .clk(clk), .gecerli(), .hazir(), .sonuc(sonuc_wire));

    always@(posedge clk)begin
    temp_sayi = sayi;
    temp_sonuc = 0;
    i = 0;
    sol = 0;   //hatirlatici icin toplama ve cikartmaya eklenecek olanlar
    sag = 0;  
    hatirlat = 0;  //hatirlatici

    //16 kez tekrar et

        for(i=0;i<16;i=i+1) begin 
            sag = {temp_sonuc,hatirlat[17],1'b1};
            sol = {hatirlat[15:0],temp_sayi[31:30]};
            temp_sayi = {temp_sayi[29:0],2'b00};    //2 bit sola kaydir
            if (hatirlat[17] == 1) //hatirlat negatifse topla
                hatirlat = sol + sag;
            else    //hatirlat pozitifken cikart
                hatirlat = sol - sag;

            temp_sonuc = {temp_sonuc[14:0],!hatirlat[17]};
        end
        temp_hazir = ~temp_hazir;
        temp = temp_sonuc;
    end

    assign sonuc = {sonuc_wire[54:0], 9'b0};
    assign hazir = 1'b1;
    assign tasma = 1'b0;
    assign gecerli = 1'b1;

endmodule
