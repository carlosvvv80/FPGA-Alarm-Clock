`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2020 12:00:44 AM
// Design Name: 
// Module Name: divide_by_12
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

//divides value that we sent from our rom by 12 to give us the octave and music note that will be played

module divide_by_12(

    input [5:0] numerator,  // full note to be divided by 12 111111 means we have 64 possible notes to play
	output reg [2:0] quotient, //octave the note will be in 
	output [3:0] remainder //note to be played
);
reg [1:0] remainder3to2; 

// 010100  20
// removing the first 2 bits is essentially the same as dividing the entire number by 4
// 0101 is now 5
// now we use the remaining 4 bits and divide them by 3 which will give us our octave and remaining note
//octave 1 remainder[3:2] = 2
//so putting this together with the 1:0 bits that we took out from our full note earlier
// our remainder is 1000


assign remainder[1:0] = numerator[1:0];  // the first 2 bits are copied through
assign remainder[3:2] = remainder3to2;  // and the last 2 bits come from the case statement



always @(numerator[5:2]) //we are using the remaining 4 most significant bits of numerator, and dividing it by 3
case(numerator[5:2])     //giving us a quotient with will be the octave the note will be in, and remainder which will be the note to be played
	 0: begin quotient=0; remainder3to2=0; end
	 1: begin quotient=0; remainder3to2=1; end
	 2: begin quotient=0; remainder3to2=2; end
	 3: begin quotient=1; remainder3to2=0; end
	 4: begin quotient=1; remainder3to2=1; end
	 5: begin quotient=1; remainder3to2=2; end
	 6: begin quotient=2; remainder3to2=0; end
	 7: begin quotient=2; remainder3to2=1; end
	 8: begin quotient=2; remainder3to2=2; end
	 9: begin quotient=3; remainder3to2=0; end
	10: begin quotient=3; remainder3to2=1; end
	11: begin quotient=3; remainder3to2=2; end
	12: begin quotient=4; remainder3to2=0; end
	13: begin quotient=4; remainder3to2=1; end
	14: begin quotient=4; remainder3to2=2; end
	15: begin quotient=5; remainder3to2=0; end
endcase

endmodule
