//=============================================
// D Flip-Flop
//=============================================
module DFF(clk,in,out);
  parameter n =1; //width  Are we supposed to change to 32bits? Because we have a 32Bit Memory Register? 
  input reset; // Added to have a reset I'm not 100% sure we need it, but looking at DflipFlop in diagrams there is a reset...
  input  clk;
  input  [n-1:0] in;
  output [n-1:0] out;
  reg    [n-1:0] out;
  
	always @(posedge clk)//<--This is the statement that makes the circuit behave with TIME
	  out = in;	 
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
	assign sum[16] = sum[15] ^ overflow;
	assign sum[17] = sum[15] ^ overflow;
	assign sum[18] = sum[15] ^ overflow;
	assign sum[19] = sum[15] ^ overflow;
	assign sum[20] = sum[15] ^ overflow;
	assign sum[21] = sum[15] ^ overflow;
	assign sum[22] = sum[15] ^ overflow;
	assign sum[23] = sum[15] ^ overflow;
	assign sum[24] = sum[15] ^ overflow;
	assign sum[25] = sum[15] ^ overflow;
	assign sum[26] = sum[15] ^ overflow;
	assign sum[27] = sum[15] ^ overflow;
	assign sum[28] = sum[15] ^ overflow;
	assign sum[29] = sum[15] ^ overflow;
	assign sum[30] = sum[15] ^ overflow;
	assign sum[31] = sum[15] ^ overflow;
 
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
	
	wire [15:0] s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31;
	wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31;
	wire overflow;
	
	AddSub16B as0({1'b0,({15{inpA[0]}} & inpB[15:1])}, ({16{inpA[1]}} & inpB), 1'b0, s1, c1, overflow);
	AddSub16B as1({c1,  s1[15:1]},  ({16{inpA[2]}} & inpB),  1'b0, s2,  c2,  overflow);
	AddSub16B as2({c2,  s2[15:1]},  ({16{inpA[3]}} & inpB),  1'b0, s3,  c3,  overflow);
	AddSub16B as3({c3,  s3[15:1]},  ({16{inpA[4]}} & inpB),  1'b0, s4,  c4,  overflow);
	AddSub16B as4({c4,  s4[15:1]},  ({16{inpA[5]}} & inpB),  1'b0, s5,  c5,  overflow);
	AddSub16B as5({c5,  s5[15:1]},  ({16{inpA[6]}} & inpB),  1'b0, s6,  c6,  overflow);
	AddSub16B as6({c6,  s6[15:1]},  ({16{inpA[7]}} & inpB),  1'b0, s7,  c7,  overflow);
	AddSub16B as7({c7,  s7[15:1]},  ({16{inpA[8]}} & inpB),  1'b0, s8,  c8,  overflow);
	AddSub16B as8({c8,  s8[15:1]},  ({16{inpA[9]}} & inpB),  1'b0, s9,  c9,  overflow);
	AddSub16B as9({c9,  s9[15:1]},  ({16{inpA[10]}} & inpB), 1'b0, s10, c10, overflow);
	AddSub16B as10({c10, s10[15:1]}, ({16{inpA[11]}} & inpB), 1'b0, s11, c11, overflow);
	AddSub16B as11({c11, s11[15:1]}, ({16{inpA[12]}} & inpB), 1'b0, s12, c12, overflow);
	AddSub16B as12({c12, s12[15:1]}, ({16{inpA[13]}} & inpB), 1'b0, s13, c13, overflow);
	AddSub16B as13({c13, s13[15:1]}, ({16{inpA[14]}} & inpB), 1'b0, s14, c14, overflow);
	AddSub16B as14({c14, s14[15:1]}, ({16{inpA[15]}} & inpB), 1'b0, s15, c15, overflow);
	AddSub16B as15({c15, s15[15:1]}, ({16{inpA[15]}} & inpB), 1'b0, s16, c16, overflow);
	AddSub16B as16({c16, s16[15:1]}, ({16{inpA[15]}} & inpB), 1'b0, s17, c17, overflow);
	AddSub16B as17({c17, s17[15:1]}, ({16{inpA[15]}} & inpB), 1'b0, s18, c18, overflow);
	AddSub16B as18({c18, s18[15:1]}, ({16{inpA[15]}} & inpB), 1'b0, s19, c19, overflow);
	AddSub16B as19({c19, s19[15:1]}, ({16{inpA[15]}} & inpB), 1'b0, s20, c20, overflow);
	AddSub16B as20({c20, s20[15:1]}, ({16{inpA[15]}} & inpB), 1'b0, s21, c21, overflow);
	AddSub16B as21({c21, s21[15:1]}, ({16{inpA[12]}} & inpB), 1'b0, s22, c22, overflow);
	AddSub16B as22({c22, s22[15:1]}, ({16{inpA[13]}} & inpB), 1'b0, s23, c23, overflow);
	AddSub16B as23({c23, s23[15:1]}, ({16{inpA[14]}} & inpB), 1'b0, s24, c24, overflow);
	AddSub16B as24({c24, s24[15:1]}, ({16{inpA[15]}} & inpB), 1'b0, s25, c25, overflow);
	AddSub16B as25({c25, s25[15:1]}, ({16{inpA[15]}} & inpB), 1'b0, s26, c26, overflow);
	AddSub16B as26({c26, s26[15:1]}, ({16{inpA[15]}} & inpB), 1'b0, s27, c27, overflow);
	AddSub16B as27({c27, s27[15:1]}, ({16{inpA[15]}} & inpB), 1'b0, s28, c28, overflow);
	AddSub16B as28({c28, s28[15:1]}, ({16{inpA[15]}} & inpB), 1'b0, s29, c29, overflow);
	AddSub16B as29({c29, s29[15:1]}, ({16{inpA[15]}} & inpB), 1'b0, s30, c30, overflow);
	AddSub16B as30({c30, s30[15:1]}, ({16{inpA[15]}} & inpB), 1'b0, s31, c31, overflow);

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
	assign out[15] = s15[0];
	assign out[16] = s16[0];
	assign out[17] = s17[0];
	assign out[18] = s18[0];
	assign out[19] = s19[0];
	assign out[20] = s20[0];
	assign out[21] = s21[0];
	assign out[22] = s22[0];
	assign out[23] = s23[0];
	assign out[24] = s24[0];
	assign out[25] = s25[0];
	assign out[26] = s26[0];
	assign out[27] = s27[0];
	assign out[28] = s28[0];
	assign out[29] = s29[0];
	assign out[30] = s30[0];
	assign out[31] = s31[0];

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

module BreadBoard(clk,inputA,OpCode,feedback,Result,Error);
	input clk;
	input [15:0]inputA;
	input [3:0] OpCode;
	
	output [31:0] Result;
	output [15:0] feedback;
	output [1:0] Error;
	
	reg [31:0] Result;

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
	
	//DFlipFlop
	wire [31:0] out;
	wire [31:0] nout;
	wire [15:0] feedback;
	
	//Multiplexer
	wire [31:0] MUXtoDFF;
	
	Dec4x16 Decoder(OpCode,DECtoMUX);
	AddSub32B AddSub(inputA,feedback,mode,ADDtoMUX,carry,overflow);
	multiplier Multiplier(inputA,feedback,MULTtoMUX);
	divisor Divider(inputA, feedback,DIVtoMUX,DIV_err);
	modulus Modulus(inputA,feedback,MODtoMUX,MOD_err);
	Mux16x32b Multiplexor(channels,DECtoMUX,MUXtoDFF);
	DFF #(32) Accumulator(clk,MUXtoDFF,out);
	
	XOR xorg(inputA,feedback,XORtoMUX);
	XNOR xnorg(inputA,feedback,XNORtoMUX);
	OR org(inputA,feedback,ORtoMUX);
	NOR norg(inputA,feedback,NORtoMUX);
	AND andg(inputA,feedback,ANDtoMUX);
	NAND nandg(inputA,feedback,NANDtoMUX);
	NOT notg(inputA,NOTtoMUX);
	
	assign feedback = out[15:0];
	
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
	assign channels[12]=out;//NoOp
	assign channels[13]={32{1'b0}};//reset
	assign channels[14]={32{1'b1}};;//preset
	assign channels[15]={32{1'b0}};//reset
	
	assign Error[0]=overflow & (DECtoMUX[0] | DECtoMUX[1]);
	assign Error[1]=(DIV_err & DECtoMUX[3]) | (MOD_err & DECtoMUX[4]);
	
	always @(*)  
	begin
		mode=~OpCode[3]&~OpCode[2]&~OpCode[1]&OpCode[0];
		Result = MUXtoDFF;
	end
	
endmodule



module TestBench();
 
  reg signed [15:0] inputA;
  reg [3:0] OpCode;
  reg clk;
  wire signed [31:0] Result;
  wire [1:0] Error;
  wire [15:0] feedback;
  BreadBoard BB8(clk,inputA,OpCode,feedback,Result,Error);
	
initial
	begin
 			forever
				begin
					clk=0;
					#3;
					//$display("CLK:%b,Register:%b",clk,BB8.Result);
					#2;
					clk=1;
					#3;  
					//$display("CLK:%b,Register:%b",clk,BB8.Result);					
					#2;
				end
	end
   
//STIMULUS THREAD
  initial begin
    

	//$display("\n=======================\n");
	#5;
		
	$display("Switch on circuit");
	$display("%5d, %16b, %5d, %16b,Unknown :%2d,%10d, %32b",inputA,inputA,BB8.feedback,BB8.feedback,OpCode,Result,Result);
	//$display("\n=======================\n");

	
	//$display("Reset");
	assign inputA=16'b0000000000000000;
	assign OpCode=4'b1111;	
	#10;
	$display("%5d, %16b, %5d, %16b,Reset   :%2d,%10d, %32b",inputA,inputA,BB8.feedback,BB8.feedback,OpCode,Result,Result);
	//$display("\n=======================\n");
	
	
	//$display("Add");
	assign inputA=16'b0000000000001000;
	assign OpCode=4'b0000;	
	#10;
	$display("%5d, %16b, %5d, %16b,Add     :%2d,%10d, %32b",inputA,inputA,BB8.feedback,BB8.feedback,OpCode,Result,Result);
	//$display("\n=======================\n");
	
	
	//$display("Subtract");
	assign inputA=16'b0000000000000001;
	assign OpCode=4'b0001;	
	#10;
	$display("%5d, %16b, %5d, %16b,Subtract:%2d,%10d, %32b",inputA,inputA,BB8.feedback,BB8.feedback,OpCode,Result,Result);
	//$display("\n=======================\n");

	//$display("Multiply");
	assign inputA=16'b0000000000001010;
	assign OpCode=4'b0010;	
	#10;
	$display("%5d, %16b, %5d, %16b,Multiply:%2d,%10d, %32b",inputA,inputA,BB8.feedback,BB8.feedback,OpCode,Result,Result);
	//$display("\n=======================\n");
	
	//$display("Divide");
	assign inputA=16'b0000000000000010;
	assign OpCode=4'b0011;	
	#10;
	$display("%5d, %16b, %5d, %16b,Divide  :%2d,%10d, %32b",inputA,inputA,BB8.feedback,BB8.feedback,OpCode,Result,Result);
	//$display("\n=======================\n");
	
	//$display("Modulus");
	assign inputA=16'b0000000000000011;
	assign OpCode=4'b0011;	
	#10;
	$display("%5d, %16b, %5d, %16b,Modulus :%2d,%10d, %32b",inputA,inputA,BB8.feedback,BB8.feedback,OpCode,Result,Result);
	//$display("\n=======================\n");
	
	//$display("Xor");
	assign inputA=16'b0000000000000001;
	assign OpCode=4'b0100;	
	#10;
	$display("%5d, %16b, %5d, %16b,Xor     :%2d,%10d, %32b",inputA,inputA,BB8.feedback,BB8.feedback,OpCode,Result,Result);
	//$display("\n=======================\n");
	
	//$display("Xnor");
	assign inputA=16'b0000000000000001;
	assign OpCode=4'b0101;	
	#10;
	$display("%5d, %16b, %5d, %16b,Xnor    :%2d,%10d, %32b",inputA,inputA,BB8.feedback,BB8.feedback,OpCode,Result,Result);
	//$display("\n=======================\n");
	
	//$display("Or");
	assign inputA=16'b0000000000000001;
	assign OpCode=4'b0111;	
	#10;
	$display("%5d, %16b, %5d, %16b,Or      :%2d,%10d, %32b",inputA,inputA,BB8.feedback,BB8.feedback,OpCode,Result,Result);
	//$display("\n=======================\n");
	
	//$display("Nor");
	assign inputA=16'b0000000000000001;
	assign OpCode=4'b1000;	
	#10;
	$display("%5d, %16b, %5d, %16b,Nor     :%2d,%10d, %32b",inputA,inputA,BB8.feedback,BB8.feedback,OpCode,Result,Result);
	//$display("\n=======================\n");
	

	//$display("And");
	assign inputA=16'b0000000000000001;
	assign OpCode=4'b1001;	
	#10;
	$display("%5d, %16b, %5d, %16b,And     :%2d,%10d, %32b",inputA,inputA,BB8.feedback,BB8.feedback,OpCode,Result,Result);
	//$display("\n=======================\n");
	
	//$display("Nand");
	assign inputA=16'b0000000000000010;
	assign OpCode=4'b1010;	
	#10;
	$display("%5d, %16b, %5d, %16b,Nand    :%2d,%10d, %32b",inputA,inputA,BB8.feedback,BB8.feedback,OpCode,Result,Result);
	//$display("\n=======================\n");

	//$display("Not");
	assign inputA=16'b0000000000001111;
	assign OpCode=4'b1011;	
	#10;
	$display("%5d, %16b, %5d, %16b,Not     :%2d,%10d, %32b",inputA,inputA,BB8.feedback,BB8.feedback,OpCode,Result,Result);
	//$display("\n=======================\n");

	//$display("No-Op");
	assign inputA=16'b0000000000000001;
	assign OpCode=4'b1100;	
	#10;
	$display("%5d, %16b, %5d, %16b,No-op   :%2d,%10d, %32b",inputA,inputA,BB8.feedback,BB8.feedback,OpCode,Result,Result);
	//$display("\n=======================\n");
	
	//$display("Preset");
	assign inputA=16'b0000000000000001;
	assign OpCode=4'b1110;	
	#10;
	$display("%5d, %16b, %5d, %16b,Preset  :%2d,%10d, %32b",inputA,inputA,BB8.feedback,BB8.feedback,OpCode,Result,Result);
	//$display("\n=======================\n");
	 
	$finish;
  end  
  
endmodule
