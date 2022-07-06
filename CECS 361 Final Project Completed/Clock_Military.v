`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 07:39:27 PM
// Design Name: 
// Module Name: Clock_Military
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

//connecting all of our modules together in order to create our configurable clock 

module Clock_Military(
    input clk,
    input reset,
    input start_switch,
    input min_up_button,
    input min_down_button,
    input hour_up_button,
    input hour_down_button,
    input set_alarm_button,
    
    output [7:0] anode,
    output [7:0] cathode,
    output audio
    );
    
    wire clk_pulse;
    wire second_pulse;
    wire hour_up_pulse;
    wire hour_down_pulse;
    
    wire hour_up;
    wire hour_down;
    wire minute_up;
    wire minute_down;
    wire set_alarm;
    
    
    wire [3:0] right_sec;
    wire [3:0] left_sec;
    wire [3:0] right_min;
    wire [3:0] left_min;
    wire [3:0] right_hour;
    wire [3:0] left_hour;
    
    
    wire anode_pulse;
    wire [2:0] mux_sel;
    wire [23:0] total_count_to_mux_input_and_alarm;
    wire [3:0] mux_out_to_SSD;
    
    wire [23:0] activate_alarm;
    wire play_music;
    
    
    //Keeping track of time
    Clock_Divider  div(.clk(clk), .rst(reset), .start(start_switch), .clk_divider(clk_pulse));
    second_counter sec(.clk(clk), .rst(reset), .pulse(clk_pulse), .right_sec(right_sec), .left_sec(left_sec), .change_minute(second_pulse));
    minute_counter min(.clk(clk), .rst(reset), .pulse(second_pulse), .minute_up(minute_up), .minute_down(minute_down), .right_min(right_min), .left_min(left_min), .change_hour_up(hour_up_pulse), .change_hour_down(hour_down_pulse));
    hour_counter    hr(.clk(clk), .rst(reset), .pulse_up(hour_up_pulse), .pulse_down(hour_down_pulse), .hour_up(hour_up), .hour_down(hour_down), .right_hour(right_hour), .left_hour(left_hour));
    total_time_counter tot(.clk(clk), .rst(reset), .right_sec(right_sec), .left_sec(left_sec), .right_min(right_min), .left_min(left_min), .right_hour(right_hour), .left_hour(left_hour), .count(total_count_to_mux_input_and_alarm));
    
    //Buttons being used 
    Debounce_Circuit min_up(.clk(clk), .rst(reset), .button(min_up_button), .doit(minute_up));
    Debounce_Circuit min_down(.clk(clk), .rst(reset), .button(min_down_button), .doit(minute_down));
    Debounce_Circuit hr_up(.clk(clk), .rst(reset), .button(hour_up_button), .doit(hour_up));
    Debounce_Circuit hr_down(.clk(clk), .rst(reset), .button(hour_down_button), .doit(hour_down));
    Debounce_Circuit alarm_button(.clk(clk), .rst(reset), .button(set_alarm_button), .doit(set_alarm));
    
    //Utilizing seven segment display to show time
    pulse_gen_anode a     (.clk(clk), .rst(reset), .pulse(anode_pulse));
    Counter cnt           (.clk(clk), .rst(reset), .tick(anode_pulse), .count(mux_sel));
    AnodeShiftRegister ano(.clk(clk), .rst(reset), .counter(mux_sel), .anode(anode));
    Mux                  m(.count(total_count_to_mux_input_and_alarm), .select(mux_sel), .switch(mux_out_to_SSD));
    ano_cath_decoder decode(.count(mux_out_to_SSD), .Cathode(cathode));
    
    //Playing Music through FPGA
    alarm_song         fur(.clk(clk), .rst(reset), .play_music(play_music), .speaker(audio));
    Set_Alarm_Time     set(.clk(clk), .rst(reset), .load_alarm(set_alarm), .clock_time(total_count_to_mux_input_and_alarm), .alarm_time(activate_alarm));
    Activate_Alarm   alarm(.clk(clk), .rst(reset), .start(start_switch), .alarm_time(activate_alarm), .current_time(total_count_to_mux_input_and_alarm), .play(play_music));
    
    
    
    
    
    
endmodule
