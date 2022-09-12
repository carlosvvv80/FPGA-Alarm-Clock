`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2020 11:48:26 PM
// Design Name: 
// Module Name: music_rom
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

/* Music Notes: There are 12 different music notes. Each music note can be played at a certain freqeuncy and 
       have different octaves which change it to a higher or lower pitch
        
        Notes in Fur Elise(these are example octaves)
        
        E2 D#2 E2 D#2 E2   B1 D2 C2 A1   C1 E1 A1 B1   E1 A1 B1 C2
        E2 D#2 E2 D#2 E2   B1 D2 C2 A1   C1 E1 A1 B1   E1 C2 B1 A1
        B1 C2 D2 E2        E2 F2 E2 D2   D2 E2 D2 C2   C2 D2 C2 B1 and repeats 
        
        */
//holds the music notes that we want to play for our song
module music_ROM(
	input clk,
	input rst,
	input [7:0] address, //uses 8 bits of our tone counter to determine location of address
	output reg [31:0] note //value of note is sent to divide by 12 module to determine
	                      //our octave and music note to play
);
//correspond to music notes being used for the song to be played

parameter F4 = 32'd143266/2;
parameter E4 = 32'd151745/2;
parameter Dsharp4 = 32'd160771/2;
parameter D4 = 32'd168350/2;
parameter C4 = 32'd190840/2;
parameter A3 = 32'd227273/2;
parameter B3 = 32'd202429/2;
parameter C3 = 32'd381679/2;
parameter E3 = 32'd303030/2;


always @(posedge clk or posedge rst) //song being played based on notes. There a short pause at the end
     if (rst)
        note <= 32'b0;
     else                //and song starts playing again. 39 seconds to play
case(address)            
	 
	  0: note<= E4; 
	  1: note<= Dsharp4;
	  2: note<= E4;  
	  3: note<= Dsharp4;
	  4: note<= E4; 
	  5: note<= B3;
	  6: note<= D4;
	  7: note<= C4; 
	  8: note<= A3;
	  9: note<= A3;
	 10: note<= A3;
	 11: note<= C3;
	 12: note<= E3;
	 13: note<= A3;
	 14: note<= B3;
	 15: note<= B3;
	 16: note<= B3;
	 17: note<= E3;
	 18: note<= A3;
	 19: note<= B3;
	 20: note<= C4;
	 21: note<= C4;
	 22: note<= C4;
	 23: note<= E4;
	 24: note<= Dsharp4;
	 25: note<= E4;
	 26: note<= Dsharp4;
	 27: note<= E4;
	 28: note<= B3;
	 29: note<= D4;
	 30: note<= C4;
	 31: note<= A3;
	 32: note<= A3;
	 33: note<= A3;
	 34: note<= C3;
	 35: note<= E3;
	 36: note<= A3;
	 37: note<= B3;
	 38: note<= B3;
	 39: note<= B3;
	 40: note<= E3;
	 41: note<= C4;
	 42: note<= B3;
	 43: note<= A3;
	 44: note<= A3;
	 45: note<= A3;
	 46: note<= E4; 
     47: note<= Dsharp4; 
     48: note<= E4;  
     49: note<= Dsharp4;
     50: note<= E4; 
     51: note<= B3;
     52: note<= D4;
     53: note<= C4; 
     54: note<= A3;
     55: note<= A3;
     56: note<= A3;
     57: note<= C3;
     58: note<= E3;
     59: note<= A3;
     60: note<= B3;
     61: note<= B3;
     62: note<= B3;
     63: note<= E3;
     64: note<= A3;
     65: note<= B3;
     66: note<= C4;
     67: note<= C4;
     68: note<= C4;
     69: note<= E4;
     70: note<= Dsharp4;
     71: note<= E4;
     72: note<= Dsharp4;
     73: note<= E4;
     74: note<= B3;
     75: note<= D4;
     76: note<= C4;
     77: note<= A3;
     78: note<= A3;
     79: note<= A3;
     80: note<= C3;
     81: note<= E3;
     82: note<= A3;
     83: note<= B3;
     84: note<= B3;
     85: note<= B3;
     86: note<= E3;
     87: note<= C4;
     88: note<= B3;
     89: note<= A3;
     90: note<= A3;
     91: note<= A3;
	 92: note<= B3;
	 93: note<= C4;
	 94: note<= D4;
	 95: note<= E4;
	 96: note<= E4;
	 97: note<= E4;
	 98: note<= E4;
	 99: note<= F4;
	 100: note<= E4;
	 101: note<= D4;
	 102: note<= D4;
	103: note<= D4;
	104: note<= D4;
	105: note<= E4;
	106: note<= D4;
	107: note<= C4;
	108: note<= C4;
	109: note<= C4;
	110: note<= C4;
	111: note<= D4;
	112: note<= C4;
	113: note<= B3;
	114: note<= B3;
	115: note<= B3;
	116: note<= E4;
    117: note<= Dsharp4; 
    118: note<= E4;  
    119: note<= Dsharp4;
    120: note<= E4; 
    121: note<= B3;
    122: note<= D4;
    123: note<= C4; 
    124: note<= A3;
    125: note<= A3;
    126: note<= A3;
    127: note<= C3;
    128: note<= E3;
    129: note<= A3;
    130: note<= B3;
    131: note<= B3;
    132: note<= B3;
    133: note<= E3;
    134: note<= A3;
    135: note<= B3;
    136: note<= C4;
    137: note<= C4;
    138: note<= C4;
    139: note<= E4;
    140: note<= Dsharp4;
    141: note<= E4;
    142: note<= Dsharp4;
    143: note<= E4;
    144: note<= B3;
    145: note<= D4;
    146: note<= C4;
    147: note<= A3;
    148: note<= A3;
    149: note<= A3;
    150: note<= C3;
    151: note<= E3;
    152: note<= A3;
    153: note<= B3;
    154: note<= B3;
    155: note<= B3;
    156: note<= E3;
    157: note<= C4;
    158: note<= B3;
    159: note<= A3;
    160: note<= A3;
    161: note<= A3;
    162: note<= E4; 
    163: note<= Dsharp4; 
    164: note<= E4;  
    165: note<= Dsharp4;
    166: note<= E4; 
    167: note<= B3;
    168: note<= D4;
    169: note<= C4; 
    170: note<= A3;
    171: note<= A3;
    172: note<= A3;
    173: note<= C3;
    174: note<= E3;
    175: note<= A3;
    176: note<= B3;
    177: note<= B3;
    178: note<= B3;
    179: note<= E3;
    180: note<= A3;
    181: note<= B3;
    182: note<= C4;
    183: note<= C4;
    184: note<= C4;
    185: note<= E4;
    186: note<= Dsharp4;
    187: note<= E4;
    188: note<= Dsharp4;
    189: note<= E4;
    190: note<= B3;
    191: note<= D4;
    192: note<= C4;
    193: note<= A3;
    194: note<= A3;
    195: note<= A3;
    196: note<= C3;
    197: note<= E3;
    198: note<= A3;
    199: note<= B3;
    200: note<= B3;
    201: note<= B3;
    202: note<= E3;
    203: note<= C4;
    204: note<= B3;
    205: note<= A3;
    206: note<= A3;
    207: note<= A3;
    208: note<= B3;
    209: note<= C4;
    210: note<= D4;
    211: note<= E4;
    212: note<= E4;
    213: note<= E4;
    214: note<= E4;
    215: note<= F4;
    216: note<= E4;
    217: note<= D4;
    218: note<= D4;
    219: note<= D4;
    220: note<= D4;
    221: note<= E4;
    222: note<= D4;
    223: note<= C4;
    224: note<= C4;
    225: note<= C4;
    226: note<= C4;
    227: note<= D4;
    228: note<= C4;
    229: note<= B3;
    230: note<= B3;
    231: note<= B3;
	default: note <= 32'd0;
endcase



endmodule
