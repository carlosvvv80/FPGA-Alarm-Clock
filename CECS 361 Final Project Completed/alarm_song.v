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
                

wire[31:0]  note;
reg[31:0]  counter;//holds note value

music_ROM get_fullnote(.clk(clk), .rst(rst), .address(tone[31:24]), .note(note));


always @(posedge clk or posedge rst) begin
    
    if (rst) begin
        tone <= 33'b0;
        counter <= 33'b0;
    end
    else begin 
    begin
        counter <= counter==0 ? note : counter-32'd1; //if counter reaches 0, we go to the next note, otherwise it continues counting down to 0
         
        end 
        if (play_music) begin   //when the play music signal becomes active, we are allowed to increment our tone counter which is being used
                                //to hold the location where the music notes will be extracted from
            tone <= tone + 33'd1; 
        end
      
        if(counter==0 && tone[23:20]!=0) begin//plays note through speaker when counter holding music frequency reaches 0 
                                              //and tone bits corresponding to the music ROM address is no longer 0
            speaker <= ~speaker;                                             
    end                                                                       
    end
    
    end   

endmodule









