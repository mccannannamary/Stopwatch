`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Create Date: 10.11.2016 11:57:42
// Module Name:  StopwatchTOPlevel
// Project Name: Stopwatch Design
// Description:  Top level description of hardware for stopwatch 

//////////////////////////////////////////////////////////////////////////////////


module StopwatchTOPlevel(
    input clk100,                  // 100 MHz input clock
    input rstPBn,                  // reset pushbutton
    input startPB,                 // start push button
    input stopPB,                  // stop push button
    output [7:0] segment,          // for 7-segment display
    output [7:0] digit             // for which digit should be lit on display
    );
   
    clockReset clkRst (            // block to produce 5MHz clock and reset signal for the rest of the blocks in the hardware
        .clk100(clk100),           
        .rstPBn(rstPBn),           
        .clk5(clk5),               
        .reset(reset)              
        );
   
    Control control(               // state machine to control the "run" signal
        .clk5(clk5),
        .reset(reset),
        .startPB(startPB),
        .stopPB(stopPB),
        .run(run)
        );
       
    pulseGenerator pulse10(        // generate a pulse every 0.1 seconds
        .clk5(clk5),
        .reset(reset),
        .pulse10Hz(pulse10Hz)
        );
		
   wire enable = pulse10Hz && run;     // enables "time counter" block to begin counting
   wire [3:0] value1, value2, value3, value4;
   
    BCDcounter c1(                     // generates bits[3:0] of output timevalue
        .clk5(clk5),
        .reset(reset),
        .enable(enable),
        .value(value1),
        .ovwOutput(ovw1)
        );
		 
    BCDcounter c2(                     // generates bits[7:4] of output timevalue
        .clk5(clk5),
        .reset(reset),
        .enable(ovw1),
        .value(value2),
        .ovwOutput(ovw2)
        );
		 
    BCDcounter c3(                     // generates bits[11:8] of output timevalue
        .clk5(clk5),
        .reset(reset),
        .enable(ovw2),
        .value(value3),
        .ovwOutput(ovw3)
        );
		 
    BCDcounter c4(                     // generates bits [15:12] of output timevalue]
        .clk5(clk5),
        .reset(reset),
        .enable(ovw3),
        .value(value4),
        .ovwOutput()
        );
   
    wire [15:0] timevalue={value4, value3, value2, value1};   // time to be displayed by display interface
    
    DisplayInterface dpinterface(                             // takes a value as input and displays on board
        .clk(clk5),
        .rst(reset),
        .value(timevalue),
        .segment(segment),
        .digit(digit)
        );
		
endmodule
