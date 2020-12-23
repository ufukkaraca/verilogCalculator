`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 			TOBB University of Economics and Technology
// Engineer: 			Ufuk Karaca
// 
// Create Date:		
// Design Name: 	32 bit fixed point bolme modulu
// Module Name:		bolme.v
//////////////////////////////////////////////////////////////////////////////////
 
module bolme
	(
	input 	[31:0] bolunen,
	input 	[31:0] bolen,
	input 	clk,
	output 	[63:0] sonuc,
	output 	hazir,
	output  gecerli,
	output	tasma
	);
 
	reg [79:0] temp_sonuc;														//	Gecici sonuc (Bitshifting icin)
	reg [31:0] reg_sonuc;														//	Son sonuc (32 bit cunku bit shifting ile sagdaki precision truncate ediliyor)
	reg [47:0] temp_bolunen;													//	Gecici bolunen (48 bit cunku sagdaki 16 bit precision icin fazladan 16 kaydiriyoruz)
	reg [79:0] temp_bolen;														//  Gecici bolen
 
	reg [31:0] tur;
										 
	reg	temp_hazir;
	reg temp_gecerli;
	reg	temp_tasma;
 
	initial begin
		temp_hazir = 1'b1;
		temp_gecerli = 1'b0;
		temp_tasma = 1'b0;
		temp_sonuc = 0;	
		reg_sonuc = 0;				
		temp_bolunen = 0;	
		temp_bolen = 0;		
		tur = 0;
	end 		
 
	always @( posedge clk ) begin
		if( temp_hazir ) begin										//	Baslangic, hazir olmasini bekliyoruz			
			temp_hazir <= 1'b0;
			tur <= 47;
			temp_sonuc <= 0;													//  Modul testinde art arda girdiler olacagi belirtildigi icin her baslangicta 
			temp_bolunen <= 0;														//  hafizayi temizliyoruz.
			temp_bolen <= 0;
			temp_tasma <= 1'b0;

			temp_bolunen[47:16] <= bolunen[31:0];								//	Long division icin bolunen ve boleni sola dayiyorum
			temp_bolen[79:48] <= bolen[31:0];
			
			if(temp_bolen == 80'd0 || temp_bolunen == 80'd0)begin				//  Eger 0'a veya 0'? bolme durumu varsa, bitshifting operasyonlarina hic sokmayarak 0 veriyorum.
				temp_hazir <= 1'b1;												//  x/0 Matematiksel olarak belirsiz olsa da, binary ile 0 olarak temsil etmeyi tercih ettim.
				reg_sonuc <= 64'd0;
			end
		end

		else if(!temp_hazir) begin
			temp_bolen <= temp_bolen >> 1;										//	Long division, her turda saga kaydiriyorum boleni
			tur <= tur - 1;														//	Turu degistiriyorum, aslinda genvar benzeri islev ustleniyor

			if(temp_bolunen >= temp_bolen) begin								//  Kaydirmadan sonra bolunen bolenden buyukse durumu
				temp_sonuc[tur] <= 1'b1;										//	Kosul saglandigi icin uygun noktadaki biti 1 olarak tanimliyorum, yine long division
				temp_bolunen <= temp_bolunen - temp_bolen;
			end
 
			if(tur == 0) begin													//  ?slemlerin hepsi bittiyse ciktilari hafizalara tasiyorum
				temp_hazir <= 1'b1;
				temp_gecerli <= 1'b1;
				reg_sonuc <= temp_sonuc;
				if (temp_sonuc[79:32]>0)										//  Tasma kontrolum
					temp_tasma <= 1'b1;
				
            end
			else																//  Bolen hala bolunenden buyukse siradaki tura gecip bir daha kaydirma yapiyoruz
				tur <= tur - 1;	
			
		end
	end

	assign sonuc[63:0] = {16'b0, reg_sonuc[31:0], 16'b0};								
	assign hazir = temp_hazir;
	assign gecerli = temp_gecerli;
	assign tasma = temp_tasma;													//  Tasma varsa 1, yoksa 0 verecektir.

endmodule