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
	
	wire [63:0] temp_sonuc[6:0];
	wire temp_tasma [6:0];
	wire temp_hazir [6:0];
	wire temp_gecerli [6:0];
	
	reg [63:0] son_sonuc;
	reg son_hazir;
	reg son_tasma;
	reg son_gecerli;
	
    toplama toplama1(.sayi1(temp_sayi1),.sayi2(temp_sayi2),.clk(clk),.sonuc(temp_sonuc[0]),.hazir( temp_hazir[0]),.gecerli(temp_gecerli[0]),.tasma(temp_tasma[0]));
	cikarma cikarma1(.sayi1(temp_sayi1),.sayi2(temp_sayi2),.clk(clk),.sonuc(temp_sonuc[1]),.hazir( temp_hazir[1]),.gecerli(temp_gecerli[1]),.tasma(temp_tasma[1]));
	carpma carpma1(.sayi1(temp_sayi1),.sayi2(temp_sayi2),.clk(clk),.sonuc(temp_sonuc[2]),.hazir( temp_hazir[2]),.gecerli(temp_gecerli[2]),.tasma(temp_tasma[2]));
	bolme bolme1(.bolunen(temp_sayi1),.bolen(temp_sayi2),.clk(clk),.sonuc(temp_sonuc[3]),.hazir( temp_hazir[3]),.gecerli(temp_gecerli[3]),.tasma(temp_tasma[3]));
	karekok karekok1(.sayi1(temp_sayi1),.clk(clk),.sonuc(temp_sonuc[4]),.hazir( temp_hazir[4]),.gecerli(temp_gecerli[4]),.tasma(temp_tasma[4]));
	tanjant tanjant1(.sayi1(temp_sayi1),.clk(clk),.sonuc(temp_sonuc[5]),.hazir( temp_hazir[5]),.gecerli(temp_gecerli[5]);
	kotanjant kotanjant1(.radyan(temp_sayi1),.clk(clk),.sonuc(temp_sonuc[6]),.hazir( temp_hazir[6]),.gecerli(temp_gecerli[6]),.tasma(temp_tasma[6]));
    
    initial begin
        ana_hazir = 1'b1;
    end
	   
    always@* begin
	   if (ana_hazir)begin
	       ana_hazir <= 0;
	       temp_sayi1 <= sayi1;
	       temp_sayi2 <= sayi2;
	       temp_tur <= tur;
	   end
	   
	   else if (!ana_hazir) begin
	       case (temp_tur)
                   3'b000: 
                    begin
                        son_sonuc <= temp_sonuc[0]; son_hazir <= temp_hazir[0]; son_gecerli <= temp_gecerli[0]; son_tasma <= temp_tasma[0];
                    end
                   3'b001: 
                    begin
                        son_sonuc = temp_sonuc[1]; son_hazir = temp_hazir[1]; son_gecerli = temp_gecerli[1]; son_tasma = temp_tasma[1];
                    end
                   3'b010: 
                    begin
                        son_sonuc = temp_sonuc[2]; son_hazir = temp_hazir[2]; son_gecerli = temp_gecerli[2]; son_tasma = temp_tasma[2];
                    end
                   3'b011: 
                    begin
                        son_sonuc = temp_sonuc[3]; son_hazir = temp_hazir[3]; son_gecerli = temp_gecerli[3]; son_tasma = temp_tasma[3];
                    end 
                   3'b100: 
                    begin
                        son_sonuc = temp_sonuc[4]; son_hazir = temp_hazir[4]; son_gecerli = temp_gecerli[4]; son_tasma = temp_tasma[4];
                    end 
                   3'b101: 
                    begin
                        son_sonuc = temp_sonuc[5]; son_hazir = temp_hazir[5]; son_gecerli = temp_gecerli[5]; son_tasma = temp_tasma[5];
                    end 
                   3'b110: 
                    begin
                        son_sonuc = temp_sonuc[6]; son_hazir = temp_hazir[6]; son_gecerli = temp_gecerli[6]; son_tasma = temp_tasma[6];
                    end 
                   3'b111: ;
               
               endcase
               
               ana_hazir = 1'b1;
	   
	   end
    end
	
	assign sonuc[63:0] = son_sonuc[63:0];
	assign tasma = son_tasma;
	assign gecerli = son_gecerli;
	assign hazir = son_hazir;
	
endmodule
