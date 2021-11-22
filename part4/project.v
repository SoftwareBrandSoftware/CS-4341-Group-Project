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



module Mux16x128b(channels, select, b);
	input [15:0][127:0] channels;
	input      [15:0] select;
	output      [127:0] b;

	assign b =	({128{select[15]}} & channels[15]) | 
				({128{select[14]}} & channels[14]) |
				({128{select[13]}} & channels[13]) |
				({128{select[12]}} & channels[12]) |
				({128{select[11]}} & channels[11]) |
				({128{select[10]}} & channels[10]) |
				({128{select[ 9]}} & channels[ 9]) |
			   ({128{select[ 8]}} & channels[ 8]) |
			   ({128{select[ 7]}} & channels[ 7]) |
			   ({128{select[ 6]}} & channels[ 6]) |
			   ({128{select[ 5]}} & channels[ 5]) |
			   ({128{select[ 4]}} & channels[ 4]) |
			   ({128{select[ 3]}} & channels[ 3]) |
			   ({128{select[ 2]}} & channels[ 2]) | 
               	({128{select[ 1]}} & channels[ 1]) |
               	({128{select[ 0]}} & channels[ 0]) ;

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


module AddSub128B(inputA,inputB,mode,sum,carry,overflow);
    input [127:0] inputA;
    input [127:0] inputB;
    
    input mode;
    
    output [127:0] sum;
    output carry;
    output overflow;
    
    wire b0,b1,b2,b3,b4,b5,b6,b7,b8,b9; //XOR Interfaces
    wire b10,b11,b12,b13,b14,b15,b16,b17,b18,b19;
    wire b20,b21,b22,b23,b24,b25,b26,b27,b28,b29;
    wire b30,b31,b32,b33,b34,b35,b36,b37,b38,b39;
    wire b40,b41,b42,b43,b44,b45,b46,b47,b48,b49;
    wire b50,b51,b52,b53,b54,b55,b56,b57,b58,b59;
    wire b60,b61,b62,b63,b64,b65,b66,b67,b68,b69;
    wire b70,b71,b72,b73,b74,b75,b76,b77,b78,b79;
    wire b80,b81,b82,b83,b84,b85,b86,b87,b88,b89;
    wire b90,b91,b92,b93,b94,b95,b96,b97,b98,b99;
    wire b100,b101,b102,b103,b104,b105,b106,b107,b108,b109;
    wire b110,b111,b112,b113,b114,b115,b116,b117,b118,b119;
    wire b120,b121,b122,b123,b124,b125,b126,b127;

    wire c0,c1,c2,c3,c4,c5,c6,c7,c8,c9; //Carry Interfaces
    wire c10,c11,c12,c13,c14,c15,c16,c17,c18,c19;
    wire c20,c21,c22,c23,c24,c25,c26,c27,c28,c29;
    wire c30,c31,c32,c33,c34,c35,c36,c37,c38,c39;
    wire c40,c41,c42,c43,c44,c45,c46,c47,c48,c49;
    wire c50,c51,c52,c53,c54,c55,c56,c57,c58,c59;
    wire c60,c61,c62,c63,c64,c65,c66,c67,c68,c69;
    wire c70,c71,c72,c73,c74,c75,c76,c77,c78,c79;
    wire c80,c81,c82,c83,c84,c85,c86,c87,c88,c89;
    wire c90,c91,c92,c93,c94,c95,c96,c97,c98,c99;
    wire c100,c101,c102,c103,c104,c105,c106,c107,c108,c109;
    wire c110,c111,c112,c113,c114,c115,c116,c117,c118,c119;
    wire c120,c121,c122,c123,c124,c125,c126,c127,c128;
	
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
    assign b10 = inputB[10] ^ mode;
    assign b11 = inputB[11] ^ mode;
    assign b12 = inputB[12] ^ mode;
    assign b13 = inputB[13] ^ mode;
    assign b14 = inputB[14] ^ mode;
    assign b15 = inputB[15] ^ mode;
    assign b16 = inputB[16] ^ mode;
    assign b17 = inputB[17] ^ mode;
    assign b18 = inputB[18] ^ mode;
    assign b19 = inputB[19] ^ mode;
    assign b20 = inputB[20]  ^ mode;
    assign b21 = inputB[21]  ^ mode;
    assign b22 = inputB[22]  ^ mode;
    assign b23 = inputB[23]  ^ mode;
    assign b24 = inputB[24]  ^ mode;
    assign b25 = inputB[25]  ^ mode;
    assign b26 = inputB[26]  ^ mode;
    assign b27 = inputB[27]  ^ mode;
    assign b28 = inputB[28]  ^ mode;
    assign b29 = inputB[29]  ^ mode;
    assign b30 = inputB[30]  ^ mode;
    assign b31 = inputB[31]  ^ mode;
    assign b32 = inputB[32]  ^ mode;
    assign b33 = inputB[33]  ^ mode;
    assign b34 = inputB[34]  ^ mode;
    assign b35 = inputB[35]  ^ mode;
    assign b36 = inputB[36]  ^ mode;
    assign b37 = inputB[37]  ^ mode;
    assign b38 = inputB[38]  ^ mode;
    assign b39 = inputB[39]  ^ mode;
    assign b40 = inputB[40]  ^ mode;
    assign b41 = inputB[41]  ^ mode;
    assign b42 = inputB[42]  ^ mode;
    assign b43 = inputB[43]  ^ mode;
    assign b44 = inputB[44]  ^ mode;
    assign b45 = inputB[45]  ^ mode;
    assign b46 = inputB[46]  ^ mode;
    assign b47 = inputB[47]  ^ mode;
    assign b48 = inputB[48]  ^ mode;
    assign b49 = inputB[49]  ^ mode;
    assign b50 = inputB[50]  ^ mode;
    assign b51 = inputB[51]  ^ mode;
    assign b52 = inputB[52]  ^ mode;
    assign b53 = inputB[53]  ^ mode;
    assign b54 = inputB[54]  ^ mode;
    assign b55 = inputB[55]  ^ mode;
    assign b56 = inputB[56]  ^ mode;
    assign b57 = inputB[57]  ^ mode;
    assign b58 = inputB[58]  ^ mode;
    assign b59 = inputB[59]  ^ mode;
    assign b60 = inputB[60]  ^ mode;
    assign b61 = inputB[61]  ^ mode;
    assign b62 = inputB[62]  ^ mode;
    assign b63 = inputB[63]  ^ mode;
    assign b64 = inputB[64]  ^ mode;
    assign b65 = inputB[65]  ^ mode;
    assign b66 = inputB[66]  ^ mode;
    assign b67 = inputB[67]  ^ mode;
    assign b68 = inputB[68]  ^ mode;
    assign b69 = inputB[69]  ^ mode;
    assign b70 = inputB[70]  ^ mode;
    assign b71 = inputB[71]  ^ mode;
    assign b72 = inputB[72]  ^ mode;
    assign b73 = inputB[73]  ^ mode;
    assign b74 = inputB[74]  ^ mode;
    assign b75 = inputB[75]  ^ mode;
    assign b76 = inputB[76]  ^ mode;
    assign b77 = inputB[77]  ^ mode;
    assign b78 = inputB[78]  ^ mode;
    assign b79 = inputB[79]  ^ mode;
    assign b80 = inputB[80]  ^ mode;
    assign b81 = inputB[81]  ^ mode;
    assign b82 = inputB[82]  ^ mode;
    assign b83 = inputB[83]  ^ mode;
    assign b84 = inputB[84]  ^ mode;
    assign b85 = inputB[85]  ^ mode;
    assign b86 = inputB[86]  ^ mode;
    assign b87 = inputB[87]  ^ mode;
    assign b88 = inputB[88]  ^ mode;
    assign b89 = inputB[89]  ^ mode;
    assign b90 = inputB[90]  ^ mode;
    assign b91 = inputB[91]  ^ mode;
    assign b92 = inputB[92]  ^ mode;
    assign b93 = inputB[93]  ^ mode;
    assign b94 = inputB[94]  ^ mode;
    assign b95 = inputB[95]  ^ mode;
    assign b96 = inputB[96]  ^ mode;
    assign b97 = inputB[97]  ^ mode;
    assign b98 = inputB[98]  ^ mode;
    assign b99 = inputB[99]  ^ mode;
    assign b100 = inputB[100] ^ mode;
    assign b101 = inputB[101] ^ mode;
    assign b102 = inputB[102] ^ mode;
    assign b103 = inputB[103] ^ mode;
    assign b104 = inputB[104] ^ mode;
    assign b105 = inputB[105] ^ mode;
    assign b106 = inputB[106] ^ mode;
    assign b107 = inputB[107] ^ mode;
    assign b108 = inputB[108] ^ mode;
    assign b109 = inputB[109] ^ mode;
    assign b110 = inputB[110] ^ mode;
    assign b111 = inputB[111] ^ mode;
    assign b112 = inputB[112] ^ mode;
    assign b113 = inputB[113] ^ mode;
    assign b114 = inputB[114] ^ mode;
    assign b115 = inputB[115] ^ mode;
    assign b116 = inputB[116] ^ mode;
    assign b117 = inputB[117] ^ mode;
    assign b118 = inputB[118] ^ mode;
    assign b119 = inputB[119] ^ mode;
    assign b120 = inputB[120] ^ mode;
    assign b121 = inputB[121] ^ mode;
    assign b122 = inputB[122] ^ mode;
    assign b123 = inputB[123] ^ mode;
    assign b124 = inputB[124] ^ mode;
    assign b125 = inputB[125] ^ mode;
    assign b126 = inputB[126] ^ mode;
    assign b127 = inputB[127] ^ mode;

    FullAdder FA0(inputA[0], b0,mode,c1,sum[0]);
    FullAdder FA1(inputA[1], b1,  c1,c2,sum[1]);
    FullAdder FA2(inputA[2], b2,  c2,c3,sum[2]);
    FullAdder FA3(inputA[3], b3,  c3,c4,sum[3]);
    FullAdder FA4(inputA[4], b4,  c4,c5,sum[4]);
    FullAdder FA5(inputA[5], b5,  c5,c6,sum[5]);
    FullAdder FA6(inputA[6], b6,  c6,c7,sum[6]);
    FullAdder FA7(inputA[7], b7,  c7,c8,sum[7]);
    FullAdder FA8(inputA[8], b8,  c8,c9,sum[8]);
    FullAdder FA9(inputA[9], b9,  c9,c10,sum[9]);
    FullAdder FA10(inputA[10],b10,  c10,c11,sum[10]);
    FullAdder FA11(inputA[11],b11,  c11,c12,sum[11]);
    FullAdder FA12(inputA[12],b12,  c12,c13,sum[12]);
    FullAdder FA13(inputA[13],b13,  c13,c14,sum[13]);
    FullAdder FA14(inputA[14],b14,  c14,c15,sum[14]);
    FullAdder FA15(inputA[15],b15,  c15,c16,sum[15]);
    FullAdder FA16(inputA[16],b16,  c16,c17,sum[16]);
    FullAdder FA17(inputA[17],b17,  c17,c18,sum[17]);
    FullAdder FA18(inputA[18],b18,  c18,c19,sum[18]);
    FullAdder FA19(inputA[19],b19,  c19,c20,sum[19]);
    FullAdder FA20(inputA[20], b20,  c20,c21,sum[20]);
    FullAdder FA21(inputA[21], b21,  c21,c22,sum[21]);
    FullAdder FA22(inputA[22], b22,  c22,c23,sum[22]);
    FullAdder FA23(inputA[23], b23,  c23,c24,sum[23]);
    FullAdder FA24(inputA[24], b24,  c24,c25,sum[24]);
    FullAdder FA25(inputA[25], b25,  c25,c26,sum[25]);
    FullAdder FA26(inputA[26], b26,  c26,c27,sum[26]);
    FullAdder FA27(inputA[27], b27,  c27,c28,sum[27]);
    FullAdder FA28(inputA[28], b28,  c28,c29,sum[28]);
    FullAdder FA29(inputA[29], b29,  c29,c30,sum[29]);
    FullAdder FA30(inputA[30], b30,  c30,c31,sum[30]);
    FullAdder FA31(inputA[31], b31,  c31,c32,sum[31]);
    FullAdder FA32(inputA[32], b32,  c32,c33,sum[32]);
    FullAdder FA33(inputA[33], b33,  c33,c34,sum[33]);
    FullAdder FA34(inputA[34], b34,  c34,c35,sum[34]);
    FullAdder FA35(inputA[35], b35,  c35,c36,sum[35]);
    FullAdder FA36(inputA[36], b36,  c36,c37,sum[36]);
    FullAdder FA37(inputA[37], b37,  c37,c38,sum[37]);
    FullAdder FA38(inputA[38], b38,  c38,c39,sum[38]);
    FullAdder FA39(inputA[39], b39,  c39,c40,sum[39]);
    FullAdder FA40(inputA[40], b30,  c40,c41,sum[40]);
    FullAdder FA41(inputA[41], b41,  c41,c42,sum[41]);
    FullAdder FA42(inputA[42], b42,  c42,c43,sum[42]);
    FullAdder FA43(inputA[43], b43,  c43,c44,sum[43]);
    FullAdder FA44(inputA[44], b44,  c44,c45,sum[44]);
    FullAdder FA45(inputA[45], b45,  c45,c46,sum[45]);
    FullAdder FA46(inputA[46], b46,  c46,c47,sum[46]);
    FullAdder FA47(inputA[47], b47,  c47,c48,sum[47]);
    FullAdder FA48(inputA[48], b48,  c48,c49,sum[48]);
    FullAdder FA49(inputA[49], b49,  c49,c50,sum[49]);
    FullAdder FA50(inputA[50], b50,  c50,c51,sum[50]);
    FullAdder FA51(inputA[51], b51,  c51,c52,sum[51]);
    FullAdder FA52(inputA[52], b52,  c52,c53,sum[52]);
    FullAdder FA53(inputA[53], b53,  c53,c54,sum[53]);
    FullAdder FA54(inputA[54], b54,  c54,c55,sum[54]);
    FullAdder FA55(inputA[55], b55,  c55,c56,sum[55]);
    FullAdder FA56(inputA[56], b56,  c56,c57,sum[56]);
    FullAdder FA57(inputA[57], b57,  c57,c58,sum[57]);
    FullAdder FA58(inputA[58], b58,  c58,c59,sum[58]);
    FullAdder FA59(inputA[59], b59,  c59,c60,sum[59]);
    FullAdder FA60(inputA[60], b60,  c60,c61,sum[60]);
    FullAdder FA61(inputA[61], b61,  c61,c62,sum[61]);
    FullAdder FA62(inputA[62], b62,  c62,c63,sum[62]);
    FullAdder FA63(inputA[63], b63,  c63,c64,sum[63]);
    FullAdder FA64(inputA[64], b64,  c64,c65,sum[64]);
    FullAdder FA65(inputA[65], b65,  c65,c66,sum[65]);
    FullAdder FA66(inputA[66], b66,  c66,c67,sum[66]);
    FullAdder FA67(inputA[67], b67,  c67,c68,sum[67]);
    FullAdder FA68(inputA[68], b68,  c68,c69,sum[68]);
    FullAdder FA69(inputA[69], b69,  c69,c70,sum[69]);
    FullAdder FA70(inputA[70], b70,  c70,c71,sum[70]);
    FullAdder FA71(inputA[71], b71,  c71,c72,sum[71]);
    FullAdder FA72(inputA[72], b72,  c72,c73,sum[72]);
    FullAdder FA73(inputA[73], b73,  c73,c74,sum[73]);
    FullAdder FA74(inputA[74], b74,  c74,c75,sum[74]);
    FullAdder FA75(inputA[75], b75,  c75,c76,sum[75]);
    FullAdder FA76(inputA[76], b76,  c76,c77,sum[76]);
    FullAdder FA77(inputA[77], b77,  c77,c78,sum[77]);
    FullAdder FA78(inputA[78], b78,  c78,c79,sum[78]);
    FullAdder FA79(inputA[79], b79,  c79,c80,sum[79]);
    FullAdder FA80(inputA[80], b80,  c80,c81,sum[80]);
    FullAdder FA81(inputA[81], b81,  c81,c82,sum[81]);
    FullAdder FA82(inputA[82], b82,  c82,c83,sum[82]);
    FullAdder FA83(inputA[83], b83,  c83,c84,sum[83]);
    FullAdder FA84(inputA[84], b84,  c84,c85,sum[84]);
    FullAdder FA85(inputA[85], b85,  c85,c86,sum[85]);
    FullAdder FA86(inputA[86], b86,  c86,c87,sum[86]);
    FullAdder FA87(inputA[87], b87,  c87,c88,sum[87]);
    FullAdder FA88(inputA[88], b88,  c88,c89,sum[88]);
    FullAdder FA89(inputA[89], b89,  c89,c90,sum[89]);
    FullAdder FA90(inputA[90], b90,  c90,c91,sum[90]);
    FullAdder FA91(inputA[91], b91,  c91,c92,sum[91]);
    FullAdder FA92(inputA[92], b92,  c92,c93,sum[92]);
    FullAdder FA93(inputA[93], b93,  c93,c94,sum[93]);
    FullAdder FA94(inputA[94], b94,  c94,c95,sum[94]);
    FullAdder FA95(inputA[95], b95,  c95,c96,sum[95]);
    FullAdder FA96(inputA[96], b96,  c96,c97,sum[96]);
    FullAdder FA97(inputA[97], b97,  c97,c98,sum[97]);
    FullAdder FA98(inputA[98], b98,  c98,c99,sum[98]);
    FullAdder FA99(inputA[99], b99,  c99,c100,sum[99]);
    FullAdder FA100(inputA[100],b100,  c100,c101,sum[100]);
    FullAdder FA101(inputA[101],b101,  c101,c102,sum[101]);
    FullAdder FA102(inputA[102],b102,  c102,c103,sum[102]);
    FullAdder FA103(inputA[103],b103,  c103,c104,sum[103]);
    FullAdder FA104(inputA[104],b104,  c104,c105,sum[104]);
    FullAdder FA105(inputA[105],b105,  c105,c106,sum[105]);
    FullAdder FA106(inputA[106],b106,  c106,c107,sum[106]);
    FullAdder FA107(inputA[107],b107,  c107,c108,sum[107]);
    FullAdder FA108(inputA[108],b108,  c108,c109,sum[108]);
    FullAdder FA109(inputA[109],b109,  c109,c110,sum[109]);
    FullAdder FA110(inputA[110],b110,  c110,c111,sum[110]);
    FullAdder FA111(inputA[111],b111,  c111,c112,sum[111]);
    FullAdder FA112(inputA[112],b112,  c112,c113,sum[112]);
    FullAdder FA113(inputA[113],b113,  c113,c114,sum[113]);
    FullAdder FA114(inputA[114],b114,  c114,c115,sum[114]);
    FullAdder FA115(inputA[115],b115,  c115,c116,sum[115]);
    FullAdder FA116(inputA[116],b116,  c116,c117,sum[116]);
    FullAdder FA117(inputA[117],b117,  c117,c118,sum[117]);
    FullAdder FA118(inputA[118],b118,  c118,c119,sum[118]);
    FullAdder FA119(inputA[119],b119,  c119,c120,sum[119]);
    FullAdder FA120(inputA[120],b120,  c120,c121,sum[120]);
    FullAdder FA121(inputA[121],b121,  c121,c122,sum[121]);
    FullAdder FA122(inputA[122],b122,  c122,c123,sum[122]);
    FullAdder FA123(inputA[123],b123,  c123,c124,sum[123]);
    FullAdder FA124(inputA[124],b124,  c124,c125,sum[124]);
    FullAdder FA125(inputA[125],b125,  c125,c126,sum[125]);
    FullAdder FA126(inputA[126],b126,  c126,c127,sum[126]);
    FullAdder FA127(inputA[127],b127,  c127,c128,sum[127]);
	
    assign carry=c128;
    assign overflow=c128^c127;
	
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


module multiplier128B(inpA, inpB, out);
	input [127:0] inpA;
	input [127:0] inpB;
	output [127:0] out;
	
	assign out = inpA * inpB;

endmodule;


module divisor(inputA,inputB,result,error);
	input [127:0] inputA;
	input [127:0] inputB;
	
	output [127:0] result;
	output error;
	
	assign result = (inputB == 128'b0) ? 128'b0 :
					inputA/inputB;
					
	assign error = (inputB == 128'b0) ? 1'b1 :
					1'b0;
	
endmodule



module modulus(inputA,inputB,result,error);
	input [127:0] inputA;
	input [127:0] inputB;
	
	output [127:0] result;
	output error;
	
	assign result = (inputB == 128'b0) ? 128'b0 :
					inputA%inputB;
	
	assign error = (inputB == 128'b0) ? 1'b1 :
					1'b0;
	
endmodule



module XOR(inputA,inputB,result);
	input [127:0] inputA;
	input [127:0] inputB;
	
	output [127:0] result;
	
	assign result[127:0] = inputA ^ inputB;
	
endmodule


module AND(inputA,inputB,result);
	input [127:0] inputA;
	input [127:0] inputB;
	
	output [127:0] result;
	
	assign result[127:0] = inputA & inputB;
	
endmodule

module OR(inputA,inputB,result);
	input [127:0] inputA;
	input [127:0] inputB;
	
	output [127:0] result;
	
	assign result[127:0] = inputA | inputB;
	
endmodule

module NAND(inputA,inputB,result);
	input [127:0] inputA;
	input [127:0] inputB;
	
	output [127:0] result;
	
	assign result[127:0] = inputA ~& inputB;
	
endmodule

module NOR(inputA,inputB,result);
	input [127:0] inputA;
	input [127:0] inputB;
	
	output [127:0] result;
	
	assign result[127:0] = inputA ~| inputB;
	
endmodule

module XNOR(inputA,inputB,result);
	input [127:0] inputA;
	input [127:0] inputB;
	
	output [127:0] result;
	
	assign result[127:0] = inputA ~^ inputB;
	
endmodule

module NOT(inputA,result);
	input [127:0] inputA;
	
	output [127:0] result;
	
	assign result[127:0] = ~inputA;
	
endmodule

module BreadBoard(clk,feedback,OpCode,inputB,Result,Error);
	input clk;
	input [127:0]inputB;
	input [3:0] OpCode;
	
	output [127:0] Result;
	output [127:0] feedback;
	output [1:0] Error;
	
	reg [127:0] Result;

	//Multiplexer
	wire [15:0][127:0] channels ;
	wire [15:0] DECtoMUX;

	// Adder-Subtractor
	wire [127:0] ADDtoMUX;
	reg mode;
	wire overflow;
	
	// Multiplier
	wire [127:0] MULTtoMUX;
	
	// Divisor
	wire [127:0] DIVtoMUX;
	wire DIV_err;
	
	// Modulus
	wire [127:0] MODtoMUX;
	wire MOD_err;
	
	// Logic Gates
	wire [127:0] XORtoMUX;
	wire [127:0] ORtoMUX;
	wire [127:0] XNORtoMUX;
	wire [127:0] NORtoMUX;
	wire [127:0] ANDtoMUX;
	wire [127:0] NANDtoMUX;
	wire [127:0] NOTtoMUX;
	
	//DFlipFlop
	wire [127:0] out;
	wire [127:0] nout;
	wire [127:0] feedback;
	
	//Multiplexer
	wire [127:0] MUXtoDFF;
	
	Dec4x16 Decoder(OpCode,DECtoMUX);
	AddSub128B AddSub(feedback,inputB,mode,ADDtoMUX,carry,overflow);
	multiplier128B Multiplier(feedback,inputB,MULTtoMUX);
	divisor Divider(feedback,inputB,DIVtoMUX,DIV_err);
	modulus Modulus(feedback,inputB,MODtoMUX,MOD_err);
	Mux16x128b Multiplexor(channels,DECtoMUX,MUXtoDFF);
	DFF #(128) Accumulator(clk,MUXtoDFF,out);
	
	XOR xorg(feedback,inputB,XORtoMUX);
	XNOR xnorg(feedback,inputB,XNORtoMUX);
	OR org(feedback,inputB,ORtoMUX);
	NOR norg(feedback,inputB,NORtoMUX);
	AND andg(feedback,inputB,ANDtoMUX);
	NAND nandg(feedback,inputB,NANDtoMUX);
	NOT notg(feedback,NOTtoMUX);
	
	assign feedback = out[127:0];
	
	assign channels[ 0]=ADDtoMUX;//Addition
	assign channels[ 1]=ADDtoMUX;//Subtraction
	assign channels[ 2]=MULTtoMUX;
	assign channels[ 3]=DIVtoMUX;
	assign channels[ 4]=MODtoMUX;
	assign channels[ 5]=XORtoMUX;
	assign channels[ 6]=XNORtoMUX;
	assign channels[ 7]=ORtoMUX;
	assign channels[ 8]=NORtoMUX;
	assign channels[ 9]=ANDtoMUX;
	assign channels[10]=NANDtoMUX;
	assign channels[11]=NOTtoMUX;
	assign channels[12]=out;//NoOp
	assign channels[13]={128{1'b0}};//reset
	assign channels[14]={128{1'b1}};//preset
	assign channels[15]=inputB;//set
	
	assign Error[0]=overflow & (DECtoMUX[0] | DECtoMUX[1]);
	assign Error[1]=(DIV_err & DECtoMUX[3]) | (MOD_err & DECtoMUX[4]);
	
	always @(*)  
	begin
		mode=~OpCode[3]&~OpCode[2]&~OpCode[1]&OpCode[0];
		Result = MUXtoDFF;
	end
	
endmodule



module TestBench();
 
  reg signed [127:0] inputB;
  reg [3:0] OpCode;
  reg clk;
  wire signed [127:0] Result;
  wire [1:0] Error;
  wire [127:0] feedback;
  BreadBoard BB8(clk,feedback,OpCode,inputB,Result,Error);
  integer opsfile, outfile;
  reg dummy;

//CLOCK THREAD	
initial
	begin
 		forever
			begin
				clk = 0;
				#5;
				clk = 1;
				#5;
			end
	end

//OPERATION THREAD
always @(posedge clk)
	begin
		#1; // start ops at posedge + 1
		if(!$feof(opsfile)) begin
			dummy = $fscanf(opsfile,"%b\n",OpCode);
			dummy = $fscanf(opsfile,"%b\n",inputB);
			#8;
			if((OpCode[3]&OpCode[2]&~OpCode[1]&~OpCode[0])==1) begin
				$fdisplay(outfile,"%b",Result);
			end
		end
		else begin
			$fclose(opsfile);
			$fclose(outfile);
			$finish;
		end
	end
//FILE OPEN THREAD
initial begin
	opsfile = $fopen("v_ops_test.txt","r");
	outfile = $fopen("v_out_test.txt","w");
  end  
  
endmodule
