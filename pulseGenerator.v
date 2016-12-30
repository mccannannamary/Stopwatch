`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Create Date: 10.11.2016 11:57:42
// Module Name:  pulseGenerator
// Project Name: Stopwatch Design
// Description:  Generate a high pulse for one clock cycle every 0.1s so that time counter
//               may count in tenths of a second - slow down the clock
//////////////////////////////////////////////////////////////////////////////////


module pulseGenerator(
    input clk5,
    input reset,
    output pulse10Hz
    );
    
        localparam [18:0] MAXVAL = 19'd499999;                // 5MHz clock multiplied by pulse every 0.1s = 500,000 cycles
        localparam ONE = 1'b1;
        localparam ZERO = 1'b0;
        
        reg[18:0] count19;
        wire[18:0] nextCount19;
        
        always @ (posedge clk5)     // synchronous reset
        begin
            if (reset)
            
                 count19 <= ZERO;
            
            else
            
                 count19 <= nextCount19;
            
        end
        
        assign pulse10Hz = (count19 == MAXVAL);                    // pulse10Hz should be high only 0.1s
        
        assign nextCount19 = pulse10Hz ? ZERO : (count19 + ONE) ;  // since 19 bits is too many for MAXVAL - set nextCount19 back to zero every MAXVAL clock cycles
        
        
endmodule
