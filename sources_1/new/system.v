`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2023 07:56:08 PM
// Design Name: 
// Module Name: system
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


module system(
input SYS_clk,
input SYS_reset,
input SYS_load,
input [7 :0] SYS_pc_val,
input [7 :0] SYS_output_sel,
output[26:0] SYS_leds
    );
    
endmodule
