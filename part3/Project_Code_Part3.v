//=============================================
// D Flip-Flop
//=============================================
module DFF(clk,in,out,nout);
  
  parameter n =1; //width  Are we supposed to change to 32bits? Because we have a 32Bit Memory Register? 
  input reset; // Added to have a reset I'm not 100% sure we need it, but looking at DflipFlop in diagrams there is a reset...
  input  clk;
  input  [n-1:0] in;
  output [n-1:0] out;
  output [n-1:0] nout;
  reg    [n-1:0] out;
  
	always @(posedge clk)//<--This is the statement that makes the circuit behave with TIME
	 begin 
		 if(reset)
		  out <= 0;
		 else
	          out <= in;
	  end
			 
	 assign  nout = !out; 
 endmodule

//=============================================
// Half Adder
//=============================================
module HalfAdder(A,B,carry,sum);
	input A;
	input B;
	output carry;
	output sum;
	reg carry;
	reg sum;
//---------------------------------------------	
	always @(*) 
	  begin
	    sum= A ^ B;
	    carry= A & B;
	  end
//---------------------------------------------
endmodule

//=============================================
// Full Adder
//=============================================
module FullAdder(A,B,C,carry,sum);
	input A;
	input B;
	input C;
	output carry;
	output sum;
	reg carry;
	reg sum;
//---------------------------------------------	
	wire c0;
	wire s0;
	wire c1;
	wire s1;
//---------------------------------------------
	HalfAdder ha1(A ,B,c0,s0);
	HalfAdder ha2(s0,C,c1,s1);
//---------------------------------------------
	always @(*) 
	  begin
	    sum=s1;
	    carry=c1|c0;
	  end
//---------------------------------------------
	
endmodule



module AddSub32B(inputA,inputB,mode,sum,carry,overflow);
    input [15:0] inputA;
    input [15:0] inputB;
    
    input mode;
    
    output [31:0] sum;
    output carry;
    output overflow;
    
    AddSub16B a(inputA,inputB,mode,sum[15:0],carry,overflow);
	assign sum[16] = carry;
	assign sum[17] = carry;
	assign sum[18] = carry;
	assign sum[19] = carry;
	assign sum[20] = carry;
	assign sum[21] = carry;
	assign sum[22] = carry;
	assign sum[23] = carry;
	assign sum[24] = carry;
	assign sum[25] = carry;
	assign sum[26] = carry;
	assign sum[27] = carry;
	assign sum[28] = carry;
	assign sum[29] = carry;
	assign sum[30] = carry;
	assign sum[31] = carry;
 
endmodule



module Mux16x32b(channels, select, b);
	input [15:0][31:0] channels;
	input      [15:0] select;
	output      [31:0] b;

	assign b =	({32{select[15]}} & channels[15]) | 
				({32{select[14]}} & channels[14]) |
				({32{select[13]}} & channels[13]) |
				({32{select[12]}} & channels[12]) |
				({32{select[11]}} & channels[11]) |
				({32{select[10]}} & channels[10]) |
				({32{select[ 9]}} & channels[ 9]) |
			   ({32{select[ 8]}} & channels[ 8]) |
			   ({32{select[ 7]}} & channels[ 7]) |
			   ({32{select[ 6]}} & channels[ 6]) |
			   ({32{select[ 5]}} & channels[ 5]) |
			   ({32{select[ 4]}} & channels[ 4]) |
			   ({32{select[ 3]}} & channels[ 3]) |
			   ({32{select[ 2]}} & channels[ 2]) | 
               	({32{select[ 1]}} & channels[ 1]) |
               	({32{select[ 0]}} & channels[ 0]) ;

endmodule



module Dec4x16(binary,onehot);
	input [3:0] binary;
	output [15:0]onehot;
	
	assign onehot[ 0]=~binary[3]&~binary[2]&~binary[1]&~binary[0];
	assign onehot[ 1]=~binary[3]&~binary[2]&~binary[1]& binary[0];
	assign onehot[ 2]=~binary[3]&~binary[2]& binary[1]&~binary[0];
	assign onehot[ 3]=~binary[3]&~binary[2]& binary[1]& binary[0];
	assign onehot[ 4]=~binary[3]& binary[2]&~binary[1]&~binary[0];
	assign onehot[ 5]=~binary[3]& binary[2]&~binary[1]& binary[0];
	assign onehot[ 6]=~binary[3]& binary[2]& binary[1]&~binary[0];
	assign onehot[ 7]=~binary[3]& binary[2]& binary[1]& binary[0];
	assign onehot[ 8]= binary[3]&~binary[2]&~binary[1]&~binary[0];
	assign onehot[ 9]= binary[3]&~binary[2]&~binary[1]& binary[0];
	assign onehot[10]= binary[3]&~binary[2]& binary[1]&~binary[0];
	assign onehot[11]= binary[3]&~binary[2]& binary[1]& binary[0];
	assign onehot[12]= binary[3]& binary[2]&~binary[1]&~binary[0];
	assign onehot[13]= binary[3]& binary[2]&~binary[1]& binary[0];
	assign onehot[14]= binary[3]& binary[2]& binary[1]&~binary[0];
	assign onehot[15]= binary[3]& binary[2]& binary[1]& binary[0];
	
endmodule;



// Needed for multiplier
module AddSub16B(inputA,inputB,mode,sum,carry,overflow);
	input [15:0] inputA;
    input [15:0] inputB;
    
    input mode;
    
    output [15:0] sum;
    output carry;
    output overflow;
    
    wire b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,ba,bb,bc,bd,be,bf; //XOR Interfaces
    wire c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,ca,cb,cc,cd,ce,cf,c00; //Carry Interfaces
	
    assign b0 = inputB[0]  ^ mode;
    assign b1 = inputB[1]  ^ mode;
    assign b2 = inputB[2]  ^ mode;
    assign b3 = inputB[3]  ^ mode;
    assign b4 = inputB[4]  ^ mode;
    assign b5 = inputB[5]  ^ mode;
    assign b6 = inputB[6]  ^ mode;
    assign b7 = inputB[7]  ^ mode;
    assign b8 = inputB[8]  ^ mode;
    assign b9 = inputB[9]  ^ mode;
    assign ba = inputB[10] ^ mode;
    assign bb = inputB[11] ^ mode;
    assign bc = inputB[12] ^ mode;
    assign bd = inputB[13] ^ mode;
    assign be = inputB[14] ^ mode;
    assign bf = inputB[15] ^ mode;

    FullAdder FA0(inputA[0], b0,mode,c1,sum[0]);
    FullAdder FA1(inputA[1], b1,  c1,c2,sum[1]);
    FullAdder FA2(inputA[2], b2,  c2,c3,sum[2]);
    FullAdder FA3(inputA[3], b3,  c3,c4,sum[3]);
    FullAdder FA4(inputA[4], b4,  c4,c5,sum[4]);
    FullAdder FA5(inputA[5], b5,  c5,c6,sum[5]);
    FullAdder FA6(inputA[6], b6,  c6,c7,sum[6]);
    FullAdder FA7(inputA[7], b7,  c7,c8,sum[7]);
    FullAdder FA8(inputA[8], b8,  c8,c9,sum[8]);
    FullAdder FA9(inputA[9], b9,  c9,ca,sum[9]);
    FullAdder FAa(inputA[10],ba,  ca,cb,sum[10]);
    FullAdder FAb(inputA[11],bb,  cb,cc,sum[11]);
    FullAdder FAc(inputA[12],bc,  cc,cd,sum[12]);
    FullAdder FAd(inputA[13],bd,  cd,ce,sum[13]);
    FullAdder FAe(inputA[14],be,  ce,cf,sum[14]);
    FullAdder FAf(inputA[15],bf,  cf,c00,sum[15]);
	
    assign carry=c00;
    assign overflow=c00^cf;
	
endmodule



module multiplier(inpA, inpB, out);
	input [15:0] inpA;
	input [15:0] inpB;
	output [31:0] out;
	
	wire [15:0] s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15;
	wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15;
	wire overflow;
	
	AddSub16B a({1'b0,({15{inpA[0]}} & inpB[15:1])}, ({16{inpA[1]}} & inpB), 1'b0, s1, c1, overflow);
	AddSub16B b({c1,  s1[15:1]},  ({16{inpA[2]}} & inpB),  1'b0, s2,  c2,  overflow);
	AddSub16B c({c2,  s2[15:1]},  ({16{inpA[3]}} & inpB),  1'b0, s3,  c3,  overflow);
	AddSub16B d({c3,  s3[15:1]},  ({16{inpA[4]}} & inpB),  1'b0, s4,  c4,  overflow);
	AddSub16B e({c4,  s4[15:1]},  ({16{inpA[5]}} & inpB),  1'b0, s5,  c5,  overflow);
	AddSub16B f({c5,  s5[15:1]},  ({16{inpA[6]}} & inpB),  1'b0, s6,  c6,  overflow);
	AddSub16B g({c6,  s6[15:1]},  ({16{inpA[7]}} & inpB),  1'b0, s7,  c7,  overflow);
	AddSub16B h({c7,  s7[15:1]},  ({16{inpA[8]}} & inpB),  1'b0, s8,  c8,  overflow);
	AddSub16B i({c8,  s8[15:1]},  ({16{inpA[9]}} & inpB),  1'b0, s9,  c9,  overflow);
	AddSub16B j({c9,  s9[15:1]},  ({16{inpA[10]}} & inpB), 1'b0, s10, c10, overflow);
	AddSub16B k({c10, s10[15:1]}, ({16{inpA[11]}} & inpB), 1'b0, s11, c11, overflow);
	AddSub16B l({c11, s11[15:1]}, ({16{inpA[12]}} & inpB), 1'b0, s12, c12, overflow);
	AddSub16B m({c12, s12[15:1]}, ({16{inpA[13]}} & inpB), 1'b0, s13, c13, overflow);
	AddSub16B n({c13, s13[15:1]}, ({16{inpA[14]}} & inpB), 1'b0, s14, c14, overflow);
	AddSub16B o({c14, s14[15:1]}, ({16{inpA[15]}} & inpB), 1'b0, s15, c15, overflow);

	assign out[0]  = inpA[0] & inpB[0];
	assign out[1]  = s1[0];
	assign out[2]  = s2[0];
	assign out[3]  = s3[0];
	assign out[4]  = s4[0];
	assign out[5]  = s5[0];
	assign out[6]  = s6[0];
	assign out[7]  = s7[0];
	assign out[8]  = s8[0];
	assign out[9]  = s9[0];
	assign out[10] = s10[0];
	assign out[11] = s11[0];
	assign out[12] = s12[0];
	assign out[13] = s13[0];
	assign out[14] = s14[0];
	assign out[30:15] = s15;
	assign out[31] = c15;

endmodule;



module divisor(inputA,inputB,result,error);
	input [15:0] inputA;
	input [15:0] inputB;
	
	output [31:0] result;
	output error;
	
	assign result = (inputB == 16'b0000000000000000) ? 16'b0000000000000000 :
					inputA/inputB;
					
	assign error = (inputB == 16'b0000000000000000) ? 1'b1 :
					1'b0;
	
endmodule



module modulus(inputA,inputB,result,error);
	input [15:0] inputA;
	input [15:0] inputB;
	
	output [31:0] result;
	output error;
	
	assign result = (inputB == 16'b0000000000000000) ? 16'b0000000000000000 :
					inputA%inputB;
	
	assign error = (inputB == 16'b0000000000000000) ? 1'b1 :
					1'b0;
	
endmodule



module XOR(inputA,inputB,result);
	input [15:0] inputA;
	input [15:0] inputB;
	
	output [31:0] result;
	
	assign result[0] = inputA[0] ^ inputB[0];
	assign result[1] = inputA[1] ^ inputB[1];
	assign result[2] = inputA[2] ^ inputB[2];
	assign result[3] = inputA[3] ^ inputB[3];
	assign result[4] = inputA[4] ^ inputB[4];
	assign result[5] = inputA[5] ^ inputB[5];
	assign result[6] = inputA[6] ^ inputB[6];
	assign result[7] = inputA[7] ^ inputB[7];
	assign result[8] = inputA[8] ^ inputB[8];
	assign result[9] = inputA[9] ^ inputB[9];
	assign result[10] = inputA[10] ^ inputB[10];
	assign result[11] = inputA[11] ^ inputB[11];
	assign result[12] = inputA[12] ^ inputB[12];
	assign result[13] = inputA[13] ^ inputB[13];
	assign result[14] = inputA[14] ^ inputB[14];
	assign result[15] = inputA[15] ^ inputB[15];
	assign result[31:16] = 16'b0000000000000000;
	
endmodule


module AND(inputA,inputB,result);
	input [15:0] inputA;
	input [15:0] inputB;
	
	output [31:0] result;
	
	assign result[15:0] = inputA & inputB;
	assign result[31:16] = 16'b0000000000000000;
	
endmodule

module OR(inputA,inputB,result);
	input [15:0] inputA;
	input [15:0] inputB;
	
	output [31:0] result;
	
	assign result[15:0] = inputA | inputB;
	assign result[31:16] = 16'b0000000000000000;
	
endmodule

module NAND(inputA,inputB,result);
	input [15:0] inputA;
	input [15:0] inputB;
	
	output [31:0] result;
	
	assign result[15:0] = inputA ~& inputB;
	assign result[31:16] = 16'b0000000000000000;
	
endmodule

module NOR(inputA,inputB,result);
	input [15:0] inputA;
	input [15:0] inputB;
	
	output [31:0] result;
	
	assign result[15:0] = inputA ~| inputB;
	assign result[31:16] = 16'b0000000000000000;
	
endmodule

module XNOR(inputA,inputB,result);
	input [15:0] inputA;
	input [15:0] inputB;
	
	output [31:0] result;
	
	assign result[15:0] = inputA ~^ inputB;
	assign result[31:16] = 16'b0000000000000000;
	
endmodule

module NOT(inputA,result);
	input [15:0] inputA;
	
	output [31:0] result;
	
	assign result[15:0] = ~inputA;
	assign result[31:16] = 16'b0000000000000000;
	
endmodule

module BreadBoard(inputA,inputB,OpCode,Result,Error);
	input [15:0]inputA;
	input [15:0]inputB;
	
	input [3:0] OpCode;
	output [31:0] Result;
	output [1:0] Error;

	//Multiplexer
	wire [15:0][31:0] channels ;
	wire [15:0] DECtoMUX;

	// Adder-Subtractor
	wire [31:0] ADDtoMUX;
	reg mode;
	wire overflow;
	
	// Multiplier
	wire [31:0] MULTtoMUX;
	
	// Divisor
	wire [31:0] DIVtoMUX;
	wire DIV_err;
	
	// Modulus
	wire [31:0] MODtoMUX;
	wire MOD_err;
	
	// Logic Gates
	wire [31:0] XORtoMUX;
	wire [31:0] ORtoMUX;
	wire [31:0] XNORtoMUX;
	wire [31:0] NORtoMUX;
	wire [31:0] ANDtoMUX;
	wire [31:0] NANDtoMUX;
	wire [31:0] NOTtoMUX;
	
	
	Dec4x16 DecAlpha(OpCode,DECtoMUX);
	AddSub32B AddSub(inputA,inputB,mode,ADDtoMUX,carry,overflow);
	multiplier Multiplier(inputA,inputB,MULTtoMUX);
	divisor Divider(inputA, inputB,DIVtoMUX,DIV_err);
	modulus Modulus(inputA,inputB,MODtoMUX,MOD_err);
	Mux16x32b Multiplexor(channels,DECtoMUX,Result);
	
	XOR xorg(inputA,inputB,XORtoMUX);
	XNOR xnorg(inputA,inputB,XNORtoMUX);
	OR org(inputA,inputB,ORtoMUX);
	NOR norg(inputA,inputB,NORtoMUX);
	AND andg(inputA,inputB,ANDtoMUX);
	NAND nandg(inputA,inputB,NANDtoMUX);
	NOT notg(inputA,NOTtoMUX);
	
	
	assign channels[ 0]=ADDtoMUX;//Addition
	assign channels[ 1]=ADDtoMUX;//Subtraction
	assign channels[ 2]=MULTtoMUX;
	assign channels[ 3]=DIVtoMUX;
	assign channels[ 4]=MODtoMUX;
	assign channels[ 5]=XORtoMUX;//GROUND=0
	assign channels[ 6]=XNORtoMUX;//GROUND=0
	assign channels[ 7]=ORtoMUX;//GROUND=0
	assign channels[ 8]=NORtoMUX;//GROUND=0
	assign channels[ 9]=ANDtoMUX;//GROUND=0
	assign channels[10]=NANDtoMUX;//GROUND=0
	assign channels[11]=NOTtoMUX;//GROUND=0
	assign channels[12]=0;//GROUND=0
	assign channels[13]=0;//GROUND=0
	assign channels[14]={32{1'b1}};;//preset
	assign channels[15]=0;//reset
	
	assign Error[0]=overflow & (DECtoMUX[0] | DECtoMUX[1]);
	assign Error[1]=(DIV_err & DECtoMUX[3]) | (MOD_err & DECtoMUX[4]);
	
	always @(*)  
	begin
		mode=~OpCode[3]&~OpCode[2]&~OpCode[1]&OpCode[0];
	end
	
endmodule



module TestBench();
 
  reg [15:0] inputA;
  reg [15:0] inputB;
  reg [3:0] OpCode;
  wire [31:0] Result;
  wire [1:0] Error;
  BreadBoard BB8(inputA,inputB,OpCode,Result,Error);
	
  initial begin
	  #0
	  clk =0;
	  forever
		  begin 
			  clk = 0;
			  #5
			  clk = 1;
			  #10
		  end
  end
	   
			  
    
  initial begin
	assign inputA  = 16'b0000000000001111;
	assign inputB  = 16'b0000000001111110;
	assign OpCode = 4'b0000;
	#10;
	$display("InputA:   %2d:%b,InputB:  %2d:%b,ADD:%b,Result:  %2d:%b,Error:%b",inputA,inputA,inputB,inputB,OpCode,Result,Result,Error);  
   	assign OpCode=4'b0001;
	#10;
	$display("InputA:   %2d:%b,InputB:  %2d:%b,SUB:%b,Result:%2d:%b,Error:%b",inputA,inputA,inputB,inputB,OpCode,Result,Result,Error); 
	assign OpCode=4'b0010;
	#10;
	$display("InputA:   %2d:%b,InputB:  %2d:%b,MUL:%b,Result: %2d:%b,Error:%b",inputA,inputA,inputB,inputB,OpCode,Result,Result,Error); 
	assign OpCode=4'b0011;
	#10;
	$display("InputA:   %2d:%b,InputB:  %2d:%b,DIV:%b,Result:   %2d:%b,Error:%b",inputA,inputA,inputB,inputB,OpCode,Result,Result,Error); 
	assign OpCode=4'b0100;
	#10;
	$display("InputA:   %2d:%b,InputB:  %2d:%b,MOD:%b,Result:   %2d:%b,Error:%b",inputA,inputA,inputB,inputB,OpCode,Result,Result,Error); 
	#10;
	assign inputA  = 16'b1111001111111111;
	assign inputB  = 16'b0110010001111110;
	assign OpCode = 4'b0000;
	#10;
	$display("InputA:%2d:%b,InputB:%2d:%b,ADD:%b,Result:     %2d:%b,Error:%b",inputA,inputA,inputB,inputB,OpCode,Result,Result,Error); 
   	assign OpCode=4'b0001;
	#10;
	$display("InputA:%2d:%b,InputB:%2d:%b,SUB:%b,Result:     %2d:%b,Error:%b",inputA,inputA,inputB,inputB,OpCode,Result,Result,Error); 
	assign OpCode=4'b0010;
	#10;
	$display("InputA:%2d:%b,InputB:%2d:%b,MUL:%b,Result:%2d:%b,Error:%b",inputA,inputA,inputB,inputB,OpCode,Result,Result,Error); 
	assign OpCode=4'b0011;
	#10;
	$display("InputA:%2d:%b,InputB:%2d:%b,DIV:%b,Result:        %2d:%b,Error:%b",inputA,inputA,inputB,inputB,OpCode,Result,Result,Error); 
	assign OpCode=4'b0100;
	#10;
	$display("InputA:%2d:%b,InputB:%2d:%b,MOD:%b,Result:     %2d:%b,Error:%b",inputA,inputA,inputB,inputB,OpCode,Result,Result,Error); 
	#10;
	$finish;
  end  
  
endmodule
