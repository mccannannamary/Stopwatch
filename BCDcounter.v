`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Create Date: 10.11.2016 11:57:42
// Module Name:  BCDcounter
// Project Name: Stopwatch Design
// Description:  binary-coded decimal counter block, to allow time counter to count in tenths of a second

//////////////////////////////////////////////////////////////////////////////////


module BCDcounter(
    input clk5,
    input reset,
    input enable,                  // counter should only be advancing when the enable signal is high
    output reg [3:0]value,         // BCD -> 4 bits allows for values 0 to 9
    output ovwOutput               // acts as enable input for next BCDcounter
    );
    
    wire [3:0] nextValue, sum;
    wire ovwInternal;              // indicates when value in BCDcounter is 9
        
    always @ (posedge clk5)        // synchronous reset
    begin
        if (reset) value <= 4'b0;
        else value <= nextValue;
    end   
        
    assign sum = value + 4'b1;
	assign ovwInternal = (value==4'b1001);     
	assign nextValue = (enable) ? (ovwInternal ? 4'b0 : sum) : value;     // after 9, count should return to zero, keep value as is when counter not enabled                                             
    assign ovwOutput = ovwInternal && enable;                             // indicates when next BCDcounter should advance 
endmodule
