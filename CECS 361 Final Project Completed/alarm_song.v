`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2020 05:39:44 PM
// Design Name: 
// Module Name: alarm_song
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

//brings other music modules together and allows our speaker to output sound

module alarm_song(
    input clk,
	input rst,
	input play_music, //input signal received from activate alarm
	output reg speaker //output signal that will output sound when activated
);



reg [32:0]tone; // the larger the counter, the longer it takes for it to reached the bits that correspond
                // to the music notes, which will cause the notes to be played slower or faster depending on its size.
                
reg [8:0] clkdivider; //used to have our clock count count to a certain number which corresponds with the frequency of the note to be played
reg [8:0] counter_note; //counter which takes the value of clkdivider and counts down to reach the note we want to play
reg [7:0] counter_octave; //counter which is used to count down to reach the octave we want to play in

wire [7:0] fullnote; //Value that is used to determine the octave and music note to be played

wire [2:0] octave; // 0 to 4 octaves
wire [3:0] note; // 0 to 11 notes

music_ROM get_fullnote(.clk(clk), .rst(rst), .address(tone[31:24]), .note(fullnote));
divide_by_12 get_octave_and_note(.numerator(fullnote[5:0]), .quotient(octave), .remainder(note));

always @(*) //Music note to be played
    case(note)
	   0: clkdivider = 9'd511;//  D#/Eb
	   1: clkdivider = 9'd482;//  E
	   2: clkdivider = 9'd455;//  F
	   3: clkdivider = 9'd430;//  F#/Gb
	   4: clkdivider = 9'd405;//  G
	   5: clkdivider = 9'd383;//  G#/Ab 
	   6: clkdivider = 9'd361;//  A 
	   7: clkdivider = 9'd341;//  A#/Bb 
	   8: clkdivider = 9'd322;//  B 
	   9: clkdivider = 9'd303;//  C 
	  10: clkdivider = 9'd286;//  C#/Db 
	  11: clkdivider = 9'd270;//  D 
 default: clkdivider = 9'd0;
endcase

always @(posedge clk or posedge rst) begin
    
    if (rst) begin
        tone <= 33'b0;
        
    end
    else begin 
    begin
        counter_note <= counter_note==0 ? clkdivider : counter_note-9'd1; //if counter reaches 0, we go to the next note, otherwise it continues counting down to 0
        end 
        if (play_music) begin   //when the play music signal becomes active, we are allowed to increment our tone counter which is being used
                                //to hold the location where the music notes will be extracted from
            tone <= tone + 33'd1; 
        end
        if (counter_note==0) begin //when counter note reaches 0, if counter octave is 0, then
                                   //we will replace a certain amount of most significant bits of the number 255 with 0's and set this new value to counter octave
                                   //other wise, we decrement counter octave by 1
                                   //the reason for this is because this is essentially dividing 255 by 2 whenever a 0 is used to replace its most significant bit
                                   //and an octave works the same way
        counter_octave <= counter_octave==0 ? 8'd255 >> octave : counter_octave-8'd1;
        end
        if(counter_note==0 && counter_octave==0 && fullnote!=0 && tone[23:20]!=0) begin//speaker will output sound when both counters have reached the 
                                                                              //music note and octave we want to play, we are not at note 0 which would be a silent note  
            speaker <= ~speaker;                                              //the four bits before tone[24] are not 0. This will create a delay which allows for the music note to play for a certain amount of time
    end                                                                       //before the speaker turns off and turns back on again to play the next music note
    end
    
    end   

endmodule




