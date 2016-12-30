`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Create Date: 10.11.2016 11:57:42
// Module Name:  Control
// Project Name: Stopwatch Design
// Description:  Produce a run signal that is high when the start button is pressed and 
//               and stays high until the stop button is pressed
//////////////////////////////////////////////////////////////////////////////////


module Control(
    input clk5,
    input reset,
    input startPB,
    input stopPB,
    output run
    );
	
        localparam STATE_STOPPED = 1'b0;
        localparam STATE_RUNNING = 1'b1;
        
        reg nextState;
        reg currentState;
        
        always @ (posedge clk5)
        begin
            if (reset)
                currentState = STATE_STOPPED;
            else 
                currentState = nextState;
        end
        
        always @ (currentState, startPB, stopPB)
        begin
            nextState = currentState;            // default, this will be the case most of the time
            case(currentState)
                STATE_STOPPED: 
                begin
                    if (startPB)                 // only move out of stopped state to running state when start button pressed
                        nextState = STATE_RUNNING;
                end
                STATE_RUNNING:
                begin
                    if (stopPB)                  // only move out of running state to stopped state when stop button pressed
                        nextState = STATE_STOPPED;
                end
            endcase
        end
        
        assign run = currentState;
    
endmodule
