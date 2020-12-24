`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 			TOBB University of Economics and Technology
// Engineer: 			Ufuk Karaca
// 
// Create Date:		
// Design Name: 	Verilog Hesap Makinesi ana modülü.
// Module Name:		anamodul.v
//////////////////////////////////////////////////////////////////////////////////


module anaModul
    (
	input 	[31:0] sayi1,
	input 	[31:0] sayi2,
	input   [2:0] tur,
	input 	clk,
	input   rst,
	output 	[63:0] sonuc,
	output 	hazir,
	output  gecerli,
	output	tasma
	);
	
	reg [31:0] temp_sayi1;
	reg [31:0] temp_sayi2;
	reg [2:0] temp_tur;
	reg ana_hazir;
    
    initial begin
        ana_hazir = 1'b1;
    end
	
	always@(negedge rst)begin
	   if (ana_hazir)begin
	   
	       ana_hazir <= 0;
	       temp_sayi1 <= sayi1;
	       temp_sayi2 <= sayi2;
	       temp_tur <= 0;
	   end
	   
	   else if (!ana_hazir) begin
	       case (temp_tur)
	           3'b000: toplama(.sayi1(temp_sayi1),.sayi2(temp_sayi2),.clk(clk),.sonuc(sonuc),.hazir(ana_hazir),.gecerli(gecerli),.tasma(tasma));
	           3'b001: cikarma(.sayi1(temp_sayi1),.sayi2(temp_sayi2),.clk(clk),.sonuc(sonuc),.hazir(ana_hazir),.gecerli(gecerli),.tasma(tasma));
	           3'b010: carpma(.sayi1(temp_sayi1),.sayi2(temp_sayi2),.clk(clk),.sonuc(sonuc),.hazir(ana_hazir),.gecerli(gecerli),.tasma(tasma));
	           3'b011: bolme(.bolunen(temp_sayi1),.bolen(temp_sayi2),.clk(clk),.sonuc(sonuc),.hazir(ana_hazir),.gecerli(gecerli),.tasma(tasma));
	           3'b100: karekok(.sayi1(temp_sayi1),.sayi2(temp_sayi2),.clk(clk),.sonuc(sonuc),.hazir(ana_hazir),.gecerli(gecerli),.tasma(tasma));
	           3'b101: tanjant(.sayi1(temp_sayi1),.sayi2(temp_sayi2),.clk(clk),.sonuc(sonuc),.hazir(ana_hazir),.gecerli(gecerli),.tasma(tasma));
	           3'b110: kotanjant(.sayi1(temp_sayi1),.sayi2(temp_sayi2),.clk(clk),.sonuc(sonuc),.hazir(ana_hazir),.gecerli(gecerli),.tasma(tasma));
	           3'b111: $DISPLAY("GECERSIZ ISLEM GIRDINIZ");
	       
	       endcase
	       
	   end
	
	
	end
	
	assign hazir = ana_hazir;
	
endmodule
