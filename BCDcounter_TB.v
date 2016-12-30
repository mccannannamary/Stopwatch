`timescale 1ns / 1ps
module TB_BCDcounter;
	// Inputs to module being verified
	reg clk5, reset, enable;
	// Outputs from module being verified
	wire ovwOutput;
	wire [3:0] value;
	// Instantiate module
	BCDcounter uut (
		.clk5(clk5),
		.reset(reset),
		.enable(enable),
		.value(value),
		.ovwOutput(ovwOutput)
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
			enable = 1'b0;
			#550
			reset = 1'b1;
			#1000
			reset = 1'b0;
			#600
			enable = 1'b1;
			#2000
			enable = 1'b0;
			#900
			enable = 1'b1;
			#3300
			enable = 1'b0;
			#2200
			enable = 1'b1;
			#1450
			$stop;
		end
endmodule
