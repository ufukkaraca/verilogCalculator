`timescale 1ns / 1ps

module kotanjant1(
    input [31:0] radyan,
    input clk,
    output hazir,
    output reg [63:0] sonuc,
    output gecerli,
    output tasma
    );
    //maclaurin serisinin acilimindaki ilk 7 terim buyuk oranda yeterli bir yakinsama sagliyor kotanjant icin
    reg [15:0] radyan_tamkisim;
    reg [15:0] radyan_virguldensonra;
    reg [31:0] temp_radyan;
    reg temp_hazir;
    reg temp_gecerli;
    reg temp_tasma;
    reg [63:0] temp_sonuc;
    reg [31:0] PI;
    
    wire [63:0] sonuc1;// 1/x
    wire [63:0] sonuc2;// x/3
    wire [63:0] sonuc3;// x^3/45
    wire [63:0] sonuc4;// 2x^5/945
    wire[63:0] sonuc5;// x^7 /4725
    wire[63:0] sonuc6;// 2x^9/93555
    wire [63:0] sonuc7;//1382x^11/638512875
    
    wire [63:0] cikarma1;
    wire [63:0] cikarma2;
    wire [63:0] cikarma3;
    wire [63:0] cikarma4;
    wire [63:0] cikarma5;
    wire [63:0] cikarma6;
   /* wire[63:0] carpma1;
    wire[63:0] carpma2;
    wire[63:0] carpma3;
    wire[63:0] carpma4;
    wire [63:0] carpma5;
    wire [63:0] carpma6;
    wire [63:0] carpma7;//2
    wire [63:0] carpma8;//2
    wire [63:0] carpma9;//1382*/
   
    reg[63:0] carpma1;
    reg[63:0] carpma2;
    reg[63:0] carpma3;
    reg[63:0] carpma4;
    reg [63:0] carpma5;
    reg [63:0] carpma6;
    reg [63:0] carpma7;//2
    reg [63:0] carpma8;//2
    reg [63:0] carpma9;//1382
    
    
    
    
    
    
    initial begin
    radyan_tamkisim = 15'b0;
    radyan_virguldensonra = 15'b0;
    temp_hazir = 1'b1;
	temp_gecerli = 1'b1;
	temp_sonuc =64'b0;
	temp_radyan =32'b0;
	PI={14'b0,2'b11,16'b001000111101011100};
	temp_tasma=1'b0;
	
	end
	
    /*assign sonuc1=64'b0;
	assign sonuc2=64'b0;
	assign sonuc3=64'b0;
	assign sonuc4=64'b0;
	assign sonuc5=64'b0;
	assign sonuc6=64'b0;
	assign sonuc7=64'b0;
	*/
    /*assign carpma1 =64'b0;
    assign carpma2 =64'b0;
    assign carpma3 =64'b0;
    assign carpma4 =64'b0;
    assign carpma5 =64'b0;
    assign carpma6 =64'b0;
    assign carpma7 =64'b0;
    assign carpma8 =64'b0;
    assign carpma9 =64'b0;
    */
   // assign temp_sonuc = 64'b0;
    always@(posedge clk) begin
       if(temp_hazir) begin
           temp_hazir <= 1'b0;
	       //temp_sonuc <= 64'b0;
	       
	       temp_radyan = radyan;
	   end
	  if(temp_radyan > PI ) begin
	       temp_radyan = temp_radyan - ((temp_radyan % PI) * PI);
	   end
	   carpma2 = (temp_radyan **3);
	   carpma7 = 2*(temp_radyan **5);
	   carpma4 = (temp_radyan **7);
	   carpma8 = 2*(temp_radyan **9);
	   carpma9 = 1382*(temp_radyan **11);
	   
	   temp_sonuc = sonuc1-sonuc2-sonuc3-sonuc4-sonuc5-sonuc6-sonuc7;
	   sonuc[63:0] = temp_sonuc;
	       
    end
    
  
    
    bolme b1(// 1/x
        .bolunen({15'b0,1'b1,16'b0}),
	 	.bolen(temp_radyan),
		.clk(clk),
	    .sonuc(sonuc1),
	    .hazir(hazir),
	    .gecerli(gecerli),
	    .tasma(tasma)
	);
    
     bolme b2(// x/3
        .bolunen(temp_radyan),
	 	.bolen({14'b0,2'b11,16'b0}),
		.clk(clk),
	    .sonuc(sonuc2),
	    .hazir(hazir),
	    .gecerli(gecerli),
	    .tasma(tasma)
	);
	
	
    
	
	bolme b3(// x^3 /45
        .bolunen(carpma2[47:16]),
	 	.bolen({10'b0,6'b101101,16'b0}),
		.clk(clk),
	    .sonuc(sonuc3),
	    .hazir(hazir),
	    .gecerli(gecerli),
	    .tasma(tasma)
	);
	
	bolme b4(// 2x^5/945
        .bolunen(carpma7[47:16]),
	 	.bolen({6'b0,10'b1110110001,16'b0}),
		.clk(clk),
	    .sonuc(sonuc4),
	    .hazir(hazir),
	    .gecerli(gecerli),
	    .tasma(tasma)
	);
	bolme b5(//x^7 /4725
        .bolunen(carpma4[47:16]),
	 	.bolen({3'b0,13'b1001001110101,16'b0}),
		.clk(clk),
	    .sonuc(sonuc5),
	    .hazir(hazir),
	    .gecerli(gecerli),
	    .tasma(tasma)
	);
	
	
	bolme b6(//2x^9/93555
        .bolunen(carpma8[47:16]),
	 	.bolen({16'b1011011010111001,16'b0}),
		.clk(clk),
	    .sonuc(sonuc6),
	    .hazir(hazir),
	    .gecerli(gecerli),
	    .tasma(tasma)
	);
	
	
	bolme b7(//1382x^11/638512875
        .bolunen(carpma9[47:16]),
	 	.bolen({16'b1001100000111011,16'b0}),
		.clk(clk),
	    .sonuc(sonuc7),
	    .hazir(hazir),
	    .gecerli(gecerli),
	    .tasma(tasma)
	);
	 
endmodule
