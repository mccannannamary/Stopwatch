`timescale 1ns / 1ps
module TB_Control;
	// Inputs to module being verified
	reg clk5, reset, startPB, stopPB;
	// Outputs from module being verified
	wire run;
	// Instantiate module
	Control uut (
		.clk5(clk5),
		.reset(reset),
		.startPB(startPB),
		.stopPB(stopPB),
		.run(run)
		);
	// Generate clock signal
	initial
		begin
			clk5  = 1'b1;
			forever
				#100 clk5  = ~clk5 ;
		end
	// Generate other input signals
	initial
		begin
			reset = 1'b0;
			startPB = 1'b0;
			stopPB = 1'b0;
			#250
			reset = 1'b1;
			#1000
			reset = 1'b0;
			#700
			startPB = 1'b1;
			#3300
			startPB = 1'b0;
			#700
			stopPB = 1'b1;
			#1600
			stopPB = 1'b0;
			#900
			stopPB = 1'b1;
			#900
			stopPB = 1'b0;
			#400
			startPB = 1'b1;
			#2250
			$stop;
		end
endmodule
